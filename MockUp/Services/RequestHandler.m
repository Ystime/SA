/*
 
 File: RequestHandler.m
 Abstract: A singleton class responsible for sending the appropriate service requests (for retrieving service data needed by the application views) and parsing the responses into semantic objects, using the SALES_INFORMATION service proxy and the SDMConnectivityHelper class. The sent requests also consider the service URL and the SAP client defined in the application settings. The class is also responsible for sending the appropriate notifications to the application delegate and view controllers, for handling the request success, failure and authentication challenge.
 Version: 1.0
 
 */

#import "RequestHandler.h"
#import "SDMRequestBuilder.h"
#import "SDMHttpRequest.h"
#import "SettingsUtilities.h"
/**
 * Uncomment the following lines for SUP Server connectivity support
 * Make sure to uncomment the additional required method under "Methods for SUP Server connectivity" pragma mark and the line in the executeLoginWithUsername:andPassword:error: method.
 */
//#import "LiteSUPAppSettings.h"
//#import "LiteSUPUserManager.h"


//Notification UserInfo keys:
NSString * const kResponseItem = @"item";
NSString * const kResponseItems = @"items";
NSString * const kResponseError = @"error";
NSString * const kResponseParentItem = @"parent";

//Notification keys:
NSString * const kAuthenticationNeededNotification = @"AuthenticationNeeded";
NSString * const kRequestErrorNotification = @"RequestError";

NSString * const kLoadBusinessPartnersCompletedNotification = @"LoadBusinessPartnersCompleted";
NSString * const kBusinessPartnerCreateCompletedNotification = @"BusinessPartnerCreateCompleted";

NSString * const kLoadContactsCompletedNotification = @"LoadContactsCompleted";
NSString * const kLoadMaterialCompletedNotification = @"LoadMaterialsCompleted";
NSString * const kLoadSalesDocumentsCompletedNotification = @"LoadSalesDocumentsCompleted";
NSString * const kLoadSalesDocumentItemsCompletedNotification = @"LoadSalesDocumentItemssCompleted";

NSString * const kContactCreateCompletedNotification = @"ContactCreateCompleted";
NSString * const kLoadHierarchyCompletedNotification = @"Hierarchy Loaded";


@implementation RequestHandler

@synthesize serviceDocumentURL = m_serviceDocumentURL;
@synthesize client = m_client;

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        m_serviceDocumentURL = [SettingsUtilities getServiceUrlFromUserSettings];
        
        m_client = [SettingsUtilities getServiceClientFromUserSettings];
        
        service = [[ECCSALESDATA_SRVService alloc] init];
        //[service retain];
        
        if ([m_serviceDocumentURL length] > 0) {
            [service setServiceDocumentUrl:m_serviceDocumentURL];
        }
		
        connectivityHelper = [[SDMConnectivityHelper alloc] init];
        if ([m_client length] > 0) {
            connectivityHelper.sapClient = m_client;
        }
        connectivityHelper.delegate = self;
    }
    return self;
}

- (BOOL)isServiceValid
{
    return (service != nil);
}

#pragma mark - Singleton

+ (RequestHandler *)uniqueInstance
{
    static RequestHandler *instance;
	
    @synchronized(self) {
        if (!instance) {
            instance = [[RequestHandler alloc] init];
        }
        return instance;
    }
}

#pragma mark - Instance Methods Bussiness Partner


- (void)loadBusinessPartnersCompleted:(id <SDMRequesting>)request
{
    NSDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *items = [service getBusinessPartnersWithData:request.responseData error:&error];
    if (error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:items forKey:kResponseItems];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoadBusinessPartnersCompletedNotification object:self userInfo:userInfoDict];
}

- (void)loadBusinessPartners
{
    if([SettingsUtilities getDemoStatus])
    {
        [[DemoData getInstance]postNotificationfor:@"BUPA"];
        return;
    }
    NSError *error;
    if([self executeLoginWithUsername:[SettingsUtilities getUsernameFromUserSettings] andPassword:[SettingsUtilities getPasswordFromUserSettings] error:&error])
    {
        ODataQuery *query = service.BusinessPartnersQuery;
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadBusinessPartnersCompleted:) andUserInfo:nil];
    }
}

-(BOOL)createBusinessPartner:(BusinessPartner*)bussPartner
{
    BOOL success = NO;
    NSError *error;
    
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    
    NSString* test = [service getXMLForCreateRequest:bussPartner error:&error];
    NSLog(@"%@",test);
    
    if (csrf) {
        id<SDMRequesting> request = [connectivityHelper executeCreateSyncRequestWithQuery: service.BusinessPartnersQuery andBody:test andCSRFData:csrf];
        
        
        NSLog(@"REQUEST: %@", request);
        //         BusinessPartner *busspart = [BusinessPartner parseBusinessPartnerEntryWithData:request.responseData error:&error];
        
        if(!error)
        {
            success = YES;
        }
        else
            success = NO;
        
    }
    return success;
}


#pragma mark - Instance Methods Contacts
- (void)loadContactsCompleted:(id <SDMRequesting>)request
{
    NSDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *contacts = [service getContactPersonsWithData:request.responseData error:&error];
    if(error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:contacts forKey:kResponseItems];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadContactsCompletedNotification object:self userInfo:userInfoDict];
    
}

-(void)loadContacts:(BusinessPartner*)bupa
{
    if([SettingsUtilities getDemoStatus])
    {
        NSMutableArray *temp = [[DemoData getInstance]bupas];
        NSMutableArray *contact = [[NSMutableArray alloc]init];
        for(BusinessPartner *bp in temp)
        {
            if([bp.BusinessPartnerID isEqualToString:bupa.BusinessPartnerID])
                contact = bp.ContactPersons;
        }
        NSDictionary *dic = [NSDictionary dictionaryWithObject:contact forKey:kResponseItems];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadContactsCompletedNotification object:nil userInfo:dic];
        return;
    }
    NSError *error;
    if([self executeLoginWithUsername:[SettingsUtilities getUsernameFromUserSettings] andPassword:[SettingsUtilities getPasswordFromUserSettings] error:&error])
    {
        ODataQuery *query = bupa.ContactPersonsQuery;
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadContactsCompleted:) andUserInfo:nil];
    }
    
}

-(BOOL) createContactPerson:(ContactPerson*)contact forBusinessPartner:(BusinessPartner*)bupa
{
    NSError *error;
    
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    
    NSString *test = [service getXMLForCreateRequest:contact error:&error];
    
    if (csrf) {
        id<SDMRequesting> request = [connectivityHelper executeCreateSyncRequestWithQuery:bupa.ContactPersonsQuery andBody:test andCSRFData:csrf];
        
        if(!request.error)
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Instance Methods Materials
- (void)loadMaterialsCompleted:(id <SDMRequesting>)request
{
    NSDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *contacts = [service getMaterialsWithData:request.responseData error:&error];
    if(error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:contacts forKey:kResponseItems];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadMaterialCompletedNotification object:self userInfo:userInfoDict];
    
}

-(void)loadMaterials
{
    if([SettingsUtilities getDemoStatus])
    {
        NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:[[DemoData getInstance]materials] forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadMaterialCompletedNotification object:nil userInfo:userInfoDict];
        return;
    }
    ODataQuery *query = service.MaterialsQuery;
    [query filter:@"SalesOrganization eq '1000'"];
    [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadMaterialsCompleted:) andUserInfo:nil];
}

-(Material*)loadMaterial:(NSString*)barcode
{
    ODataQuery *query = service.MaterialsQuery;
    [query filter:@"SalesOrganization eq '1000'"];
    id<SDMRequesting> request = [connectivityHelper executeBasicSyncRequestWithQuery:query];
    NSError *error;
    NSMutableArray * materials = [service getMaterialsWithData:[request responseData] error:&error];
    Material *result = NULL;
    for(Material *temp in materials)
    {
        NSLog(@"EAN:%@",temp.EANCode);
        if([temp.EANCode isEqualToString:barcode])
            result = temp;
    }
    return result;
}

#pragma mark - Instance Methods Sales Documents
- (void)loadSalesDocumentsCompleted:(id <SDMRequesting>)request
{
    NSDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *contacts = [service getSalesDocumentsWithData:request.responseData error:&error];
    if(error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:contacts forKey:kResponseItems];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadSalesDocumentsCompletedNotification object:self userInfo:userInfoDict];
    
}

-(void)loadSalesDocuments:(NSString*)bupaID
{
    if([SettingsUtilities getDemoStatus])
    {
        NSMutableArray *salesDocs = [[DemoData getInstance]salesDocs];
        NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:salesDocs forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadSalesDocumentsCompletedNotification object:nil userInfo:userInfoDict];
        
        return;
    }
    NSError *error;
    if([self executeLoginWithUsername:[SettingsUtilities getUsernameFromUserSettings] andPassword:[SettingsUtilities getPasswordFromUserSettings] error:&error])
    {
        NSURL *url = [service.SalesDocumentsQuery.URL copy];
        ODataQuery *query = [[ODataQuery alloc]initWithURL:url];
        [query filter:[NSString stringWithFormat:@"CustomerID eq '%@'",bupaID ]];
        //[query expand:@"Items"];
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadSalesDocumentsCompleted:) andUserInfo:nil];
    }
    
}

-(BOOL) createSalesDocument:(SalesDocument*)salesdoc
{
    
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    
    NSError *error;
    NSString *test = [service getXMLForCreateRequest:salesdoc error:&error];
    NSLog(@"%@",test);
    
    if(csrf)
    {
        NSURL *url = [[NSURL alloc]initWithString:@"http://knowledge.nl4b.com/sap/opu/odata/FEXS/SALESAPP_SRV/SalesDocuments"];
        ODataQuery *sdQuery = [[ODataQuery alloc]initWithURL:url];
        NSLog(@"%@",sdQuery.URL);
        
        id<SDMRequesting> request = [connectivityHelper executeCreateSyncRequestWithQuery:service.SalesDocumentsQuery andBody:test andCSRFData:csrf];
        NSLog(@"REQUEST: %@", [request responseString]);
        if(!request.error)
        {
            return YES;
        }
    }
    return NO;
}


-(void) loadSalesDocumentItemsCompleted:(id<SDMRequesting>) request
{
    NSDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *items = [service getSalesDocumentItemsWithData:request.responseData error:&error];
    if(error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:items forKey:kResponseItems];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadSalesDocumentItemsCompletedNotification object:self userInfo:userInfoDict];
    
}

-(void)loadSalesDocumentItems:(SalesDocument*)sd
{
    if([SettingsUtilities getDemoStatus])
    {
        NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:sd.Items forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadSalesDocumentItemsCompletedNotification object:self userInfo:userInfoDict];
        return;
    }
    ODataQuery *query = [[ODataQuery alloc]initWithURL:sd.ItemsQuery.URL];
    NSLog(@"%@",query.URL);
    [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadSalesDocumentItemsCompleted:) andUserInfo:nil];
}


#pragma mark - Instance Methods Images

-(void)loadImagesforBusinessPartner:(BusinessPartner*)bupa
{
    if([SettingsUtilities getDemoStatus])
    {
        if([bupa.BusinessPartnerID isEqualToString:@"1"])
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[UIImage imageNamed:@"Scheer Front.jpg"] forKey:@"Scheer Front"];
            [dic setObject:[UIImage imageNamed:@"Scheer Inside.jpg"] forKey:@"Scheer Inside"];
            [dic setObject:[UIImage imageNamed:@"Scheer Tower.jpg"] forKey:@"Scheer Tower"];
            NSDictionary *temp = [NSDictionary dictionaryWithObject:dic forKey:kResponseItems];
            [[NSNotificationCenter defaultCenter]postNotificationName:kPicuresLoaded object:self userInfo:temp];
        }
    }
}


-(void)loadImagesforMaterials:(NSArray*)materials;
{
    if([SettingsUtilities getDemoStatus])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for(NSString *string in materials)
        {
            [dic setObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",string]] forKey:string];
        }
        NSDictionary *temp = [NSDictionary dictionaryWithObject:dic forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMaterialPicuresLoaded object:self userInfo:temp];
    }
}
#pragma mark - Instance Methods Hierarchy

-(void)loadHierarchyWithRootNode:(NSString*)bupaID
{
    if([SettingsUtilities getDemoStatus])
    {
        
    }
    else
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if([bupaID isEqualToString:@""])
        {
            [dic setObject:[UIImage imageNamed:@"AllComps.png"] forKey:@"All"];

        }
        [dic setObject:[UIImage imageNamed:@"logoAH.png"] forKey:@"Albert Heijn"];
        [dic setObject:[UIImage imageNamed:@"C1000.png"] forKey:@"C1000"];
        NSDictionary *temp = [NSDictionary dictionaryWithObject:dic forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadHierarchyCompletedNotification object:self userInfo:temp];
    }
}
#pragma mark - Instance Methods Log In

- (BOOL)loginWithUsername:(NSString *)aUsername andPassword:(NSString *)aPassword error:(NSError * __autoreleasing *)error
{
    if ([self.serviceDocumentURL length] == 0) {
        NSString *errorMessage = NSLocalizedString(@"Service URL is empty. Please check the application settings.", @"Service URL is empty. Please check the application settings.");
        if (error) {
            *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:SERVICE_URL_EMPTY_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
        }
        NSLog(@"%@",errorMessage);
        return NO;
    }
    else {
        connectivityHelper.username = aUsername;
        connectivityHelper.password = aPassword;
        
        id<SDMRequesting> serviceDocumentRequest = [connectivityHelper executeBasicSyncRequestWithQuery:service.serviceDocumentQuery];
        
        //Reset user name  & password
        connectivityHelper.username = nil;
        connectivityHelper.password = nil;
        
        if ((!serviceDocumentRequest.error) && (serviceDocumentRequest.responseStatusCode == 200) && serviceDocumentRequest.rawResponseData) {
            //Authentication succeeded
            return YES;
        }
        else {
            //Authentication failed
            NSString *errorMessage = NSLocalizedString(@"Login failed.", @"Login failed.");
            if (error) {
                *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:LOGIN_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
            }
            NSLog(@"%@",errorMessage);
            return NO;
        }
    }
}

- (BOOL)executeLoginWithUsername:(NSString *)aUsername andPassword:(NSString *)aPassword error:(NSError * __autoreleasing *)error
{
    if (![self isServiceValid]) {
        NSString *errorMessage = NSLocalizedString(@"Service metadata is invalid. Please contact your administrator.", @"Service metadata is invalid. Please contact your administrator.");
        if (error) {
            *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:SERVICE_METADATA_PARSE_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
        }
        NSLog(@"%@",errorMessage);
        return NO;
    }
    
    /* Comment the following line for SUP Server connectivity support */
    return [self loginWithUsername:aUsername andPassword:aPassword error:error];
    
    /* Uncomment the following line for SUP Server connectivity support */
    //return [self loginUsingSUPWithUsername:aUsername andPassword:aPassword error:error];
}

#pragma mark - SDMHttpRequestDelegate

- (void)requestFailed:(SDMHttpRequest *)request
{
    int statusCode = request.responseStatusCode;
    NSLog(@"SDMHttpRequestDelegate requestFailed with status code: %d", statusCode);
    if (statusCode == 401) {
        [self authenticationNeededForRequest:request];
    }
    else {
        NSString *errorMessage = request.error ? [request.error localizedDescription] : [request responseStatusMessage];
        NSLog(@"Request Error: %@", errorMessage);
        //Display alert view with the error:
        //        NSString *title = NSLocalizedString(@"Error", @"Error");
        //        NSString *buttonTitle = NSLocalizedString(@"OK", @"OK");
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:errorMessage delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];
        //        [alert show];
        //Stop network activity indicator displayed by libSDMConnectivity library:
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //Send error notification (handled by all the application views):
        [[NSNotificationCenter defaultCenter] postNotificationName:kRequestErrorNotification object:self userInfo:[NSDictionary dictionaryWithObject:request.error forKey:kResponseError]];
    }
}

- (void)authenticationNeededForRequest:(SDMHttpRequest *)request
{
    //Cancel request and send notification to app delegate, so it will start the application flow all over again
    [request cancelAuthentication];
    [[NSNotificationCenter defaultCenter] postNotificationName:kAuthenticationNeededNotification object:self userInfo:nil];
}

#pragma mark - SDMConnectivityHelperDelegate

- (void)onBeforeSend:(id <SDMRequesting>)request
{
    request.shouldPresentAuthenticationDialog = YES;
}

@end