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
@synthesize viewVisible;

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        m_serviceDocumentURL = [SettingsUtilities getServiceUrlFromUserSettings];
        
        m_client = [SettingsUtilities getServiceClientFromUserSettings];
        
        service = [[ECCSALESDATA_SRVService alloc] init];
        
        if ([m_serviceDocumentURL length] > 0) {
            [service setServiceDocumentUrl:m_serviceDocumentURL];
        }
		viewVisible = NO;
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
    
    NSMutableArray *rawResults = [service getBusinessPartnersWithData:request.responseData error:&error];
    NSMutableArray *Results = [NSMutableArray array];
    for(BusinessPartner *bp in rawResults)
    {
        if([bp.Address.Country isEqualToString:kLanguage])
            [Results addObject:bp];
    }
    
    if (error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:Results forKey:kResponseItems];
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

-(BusinessPartner*)loadBusinessPartnerWithID:(NSString*)bupaID
{
    if([SettingsUtilities getDemoStatus])
    {
        for(BusinessPartner *bp in [[DemoData getInstance]bupas])
        {
            if([bp.BusinessPartnerID isEqualToString:bupaID])
                return bp;
        }
        return nil;
    }
    BusinessPartner *result = nil;
    ODataQuery *query = [service getBusinessPartnersEntryQueryWithBusinessPartnerID:bupaID];
    id<SDMRequesting>request = [connectivityHelper executeBasicSyncRequestWithQuery:query];
    NSError *error;
    result = [service getBusinessPartnersEntryWithData:[request responseData] error:&error];
    return result;
}

-(BusinessPartner*)createBusinessPartner:(BusinessPartner*)bussPartner
{
    if([SettingsUtilities getDemoStatus])
    {
        bussPartner.BusinessPartnerID = [NSString stringWithFormat:@"%i",[[DemoData getInstance]bupas].count +1];
        bussPartner.ContactPersons = [NSMutableArray array];
        [[[DemoData getInstance]bupas]addObject:bussPartner];
        [[RequestHandler uniqueInstance]loadBusinessPartners];
        return bussPartner;
    }
    else
    {
        BusinessPartner* success = nil;
        NSError *error;
        
        CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
        
        NSString* test = [service getXMLForCreateRequest:bussPartner error:&error];
        //    NSLog(@"%@",test);
        
        if (csrf) {
            id<SDMRequesting> request = [connectivityHelper executeCreateSyncRequestWithQuery: service.BusinessPartnersQuery andBody:test andCSRFData:csrf];
            
            
            NSLog(@"REQUEST: %@", [request responseString]);
            success = [BusinessPartner parseBusinessPartnerEntryWithData:request.responseData error:&error];
            if(error)
                success = nil;
        }
        return success;
    }
}

#pragma mark - Instance Methods Parents


-(void)loadParents
{
    if([SettingsUtilities getDemoStatus])
    {
        BusinessPartnerParent *parent = [[BusinessPartnerParent alloc]initWithSDMDictionary:nil];
        parent.BusinessPartnerName = @"FEXS";
        parent.BusinessPartnerParentID = @"FEXS_PARENT";
        NSArray *temp = [[DemoData getInstance]bupas];
        parent.BusinessPartners = [NSMutableArray arrayWithObjects:temp[0],temp[1],nil];
        NSDictionary *userinfo = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:parent forKey:parent.BusinessPartnerParentID] forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadHierarchyCompletedNotification object:self userInfo:userinfo];
    }
    else
    {
        ODataQuery *query = service.BusinessPartnerParentsQuery;
        [query expand:@"BusinessPartners"];
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadParentsCompleted:) andUserInfo:nil];
    }
}



-(void)loadParentsCompleted:(id<SDMRequesting>)request
{
    NSMutableDictionary *parents = [NSMutableDictionary dictionary];
    NSError *error;
    NSDictionary *userinfo;
    
    NSArray *tempParents = [service getBusinessPartnerParentsWithData:[request responseData] error:&error];
    if(error)
        userinfo = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    else
    {
        for(BusinessPartnerParent *parent in tempParents)
        {
            if(parent.BusinessPartners.count >0 && [parent.Address.Country isEqualToString:kLanguage])
                [parents setObject:parent forKey:parent.BusinessPartnerParentID];
        }
        userinfo = [NSDictionary dictionaryWithObject:parents forKey:kResponseItems];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadHierarchyCompletedNotification object:self userInfo:userinfo];
}


-(void)loadHierarchyWithRootNode:(NSString*)bupaID
{
    
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
    if(viewVisible)
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadContactsCompletedNotification object:self userInfo:userInfoDict];
    
}

-(void)loadContacts:(BusinessPartner*)bupa
{
    if([SettingsUtilities getDemoStatus])
    {
        NSMutableArray *temp = [[DemoData getInstance]bupas];
        NSMutableArray *contact = [NSMutableArray array];
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

-(ContactPerson*) createContactPerson:(ContactPerson*)contact forBusinessPartner:(BusinessPartner*)bupa
{
    if([SettingsUtilities getDemoStatus])
    {
        for(BusinessPartner *bp in [[DemoData getInstance]bupas])
        {
            if([bp.BusinessPartnerID isEqualToString:bupa.BusinessPartnerID])
            {
                [bp.ContactPersons addObject:contact];
                return contact;
            }
        }
    }
    NSError *error;
    
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    
    NSString *test = [service getXMLForCreateRequest:contact error:&error];
    
    if (csrf) {
        id<SDMRequesting> request = [connectivityHelper executeCreateSyncRequestWithQuery:bupa.ContactPersonsQuery andBody:test andCSRFData:csrf];
        
        if(!request.error)
        {
            return [ContactPerson parseContactPersonEntryWithData:request.responseData error:&error];
        }
    }
    return nil;
}

#pragma mark - Instance Methods Materials
- (void)loadMaterialsCompleted:(id <SDMRequesting>)request
{
    NSDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *unsortedMaterials = [service getMaterialsWithData:request.responseData error:&error];
    /*For now, manually filter materials starting with Y*/
    NSMutableArray *materials = [NSMutableArray array];
    NSString *prefix = @"";
    if([kLanguage isEqualToString:@"DE"])
        prefix = @"DEDI";
    else if ([kLanguage isEqualToString:@"NL"])
        prefix = @"Y";
    for(Material *mat  in unsortedMaterials)
    {
        if([mat.MaterialNumber hasPrefix:prefix])
            [materials addObject:mat];
    }
    
    
    
    if(error || materials.count < 1) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:materials forKey:kResponseItems];
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
    if([SettingsUtilities getDemoStatus])
    {
        for(Material *mat in [[DemoData getInstance]materials])
        {
            if([mat.EANCode isEqualToString:barcode])
                return mat;
        }
        return nil;
    }
    
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

-(void)loadMaterialGroups
{
    if([SettingsUtilities getDemoStatus])
    {
        NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:[[DemoData getInstance]materialGroups] forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMaterialGroupsLoaded object:nil userInfo:userInfoDict];
    }
    else
    {
        ODataQuery *query = service.MaterialGroupsQuery;
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(MaterialGroupsLoaded:) andUserInfo:nil];
    }
}


-(void)MaterialGroupsLoaded:(id<SDMRequesting>)request
{
    NSDictionary *userInfoDict;
    NSError *error;
    NSMutableArray *groups = [service getMaterialGroupsWithData:[request responseData] error:&error];
    MaterialGroup *temp = [[MaterialGroup alloc]init];
    temp.Description = @"All Products";
    temp.MaterialGroupID = @"0";
    NSMutableArray *selectedGroups = [NSMutableArray array];
    [selectedGroups insertObject:temp atIndex:0];
    NSString *prefix = @"";
    if([kLanguage isEqualToString:@"DE"])
        prefix = @"ZDEDI";
    else if ([kLanguage isEqualToString:@"NL"])
        prefix = @"ZTD";
    
    
    for(MaterialGroup *mg in groups)
    {
        if([mg.MaterialGroupID hasPrefix:prefix])
        {
            ODataQuery *query = mg.MaterialSetQuery;
            NSError *error;
            mg.MaterialSet = [service getMaterialsWithData:[[connectivityHelper executeBasicSyncRequestWithQuery:query]responseData] error:&error];
            [selectedGroups addObject:mg];
        }
    }
    if(error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:selectedGroups forKey:kResponseItems];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kMaterialGroupsLoaded object:nil userInfo:userInfoDict];
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
    if(viewVisible)
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadSalesDocumentsCompletedNotification object:self userInfo:userInfoDict];
    
}

-(void)loadSalesDocuments:(ODataQuery*)bupaDocQuery
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
        //        NSURL *url = [service.SalesDocumentsQuery.URL copy];
        //        ODataQuery *query = [[ODataQuery alloc]initWithURL:url];
        //        [query filter:[NSString stringWithFormat:@"CustomerID eq '%@'",bupaID ]];
        //[query expand:@"Items"];
        [connectivityHelper executeBasicAsyncRequestWithQuery:bupaDocQuery andRequestDelegate:self andDidFinishSelector:@selector(loadSalesDocumentsCompleted:) andUserInfo:nil];
    }
    
}

-(BOOL) createSalesDocument:(SalesDocument*)salesdoc
{
    
    if([SettingsUtilities getDemoStatus])
    {
        salesdoc.OrderID = [NSString stringWithFormat:@"%i",[[DemoData getInstance]getNextDocId]];
        [[[DemoData getInstance]salesDocs]addObject:salesdoc];
        return YES;
    }
    NSError *error;
    
    [self loginWithUsername:[SettingsUtilities getUsernameFromUserSettings] andPassword:[SettingsUtilities getPasswordFromUserSettings] error:&error];
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    
    NSString *test = [service getXMLForCreateRequest:salesdoc error:&error];
    
    if(csrf)
    {
        //        NSURL *url = [[NSURL alloc]initWithString:@"http://knowledge.nl4b.com/sap/opu/odata/FEXS/SALESAPP_SRV/SalesDocuments"];
        //        ODataQuery *sdQuery = [[ODataQuery alloc]initWithURL:url];
        //        NSLog(@"%@",sdQuery.URL);
        
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
    
    NSMutableArray *items = [service getSalesDocItemsWithData:request.responseData error:&error];
    if(error) {
        userInfoDict = [NSDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSDictionary dictionaryWithObject:items forKey:kResponseItems];
    }
    if(viewVisible)
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
    NSMutableDictionary *images= [NSMutableDictionary dictionary];
    if([SettingsUtilities getDemoStatus])
    {
        images = [[[DemoData getInstance]bupaPictures]objectForKey:bupa.BusinessPartnerID];
    }
    else
    {
        NSError *error;
        
        id<SDMRequesting>request = [connectivityHelper executeBasicSyncRequestWithQuery:bupa.MediaCollectionQuery];
        NSMutableArray *tempResults = [service getMediaCollectionForBusinessPartnerWithData:[request responseData] error:&error];
        NSMutableArray *tempImagesEntries = [NSMutableArray array];
        
        for(MediaForBusinessPartner* temp in tempResults)
        {
            if([temp.MediaType isEqualToString:@"Attachment"])
            {
                [tempImagesEntries addObject:temp];
            }
        }
        for(MediaForBusinessPartner *temp in tempImagesEntries)
        {
            if(!viewVisible)
                return;
            id<SDMRequesting>requestAttachment = [connectivityHelper executeBasicSyncRequestWithQuery:temp.MediaQuery];
            Media *tempMedia = [service getMediasetEntryWithData:[requestAttachment responseData] error:&error];
            if([tempMedia.ContentType hasPrefix:@"image/"])
            {
                id<SDMRequesting>requestImage = [connectivityHelper executeBasicSyncRequestWithQuery:tempMedia.mediaLinkRead.mediaLinkQuery];
                UIImage *result = [UIImage imageWithData:requestImage.responseData];
                if(result)
                {
                    [images setObject:result forKey:tempMedia.Keyword];
                }
            }
        }
    }
    NSDictionary *temp ;
    NSString *noImages = @"No Images found!";
    if(images.count > 0)
        temp = [NSDictionary dictionaryWithObject:images forKey:kResponseItems];
    else
        temp = [NSDictionary dictionaryWithObject:noImages forKey:kResponseError];
    if(viewVisible)
        [[NSNotificationCenter defaultCenter]postNotificationName:kPicturesLoaded object:self userInfo:temp];
}




-(void)loadImagesforMaterials:(NSArray*)materials;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if([SettingsUtilities getDemoStatus])
    {
        for(NSString *string in materials)
        {
            [dic setObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",string]] forKey:string];
        }
    }
    else
    {
        NSError *error;
        for(NSString *materialID in materials)
        {
            ODataQuery *query = [service getMediaCollectionForMaterialEntryQueryWithMaterialNumber:materialID andKeyword:@"thumbnail" andMediaType:@"Attachment"];
            id<SDMRequesting>request = [connectivityHelper executeBasicSyncRequestWithQuery:query];
            Media *result = [service getMediasetEntryWithData:request.responseData error:&error];
            if(!error)
            {
                id<SDMRequesting>requestImage = [connectivityHelper executeBasicSyncRequestWithQuery:result.mediaLinkRead.mediaLinkQuery];
                UIImage *thumbnail = [UIImage imageWithData:[requestImage responseData]];
                if(thumbnail)
                    [dic setObject:thumbnail forKey:materialID];
            }
        }
    }
    NSDictionary *temp = [NSDictionary dictionaryWithObject:dic forKey:kResponseItems];
    [[NSNotificationCenter defaultCenter]postNotificationName:kMaterialPicuresLoaded object:self userInfo:temp];
}


-(void)loadImagesForParents:(NSArray*)parentIDs
{
    NSMutableDictionary *parentsPic = [NSMutableDictionary dictionary];
    NSError *error;
    [parentsPic setObject:[UIImage imageNamed:@"AllComps.png"] forKey:@"All"];
    if([SettingsUtilities getDemoStatus])
    {
        for(NSString *parent in parentIDs)
        {
            [parentsPic setObject:[UIImage imageNamed:@"FEXS_LOGO.png"] forKey:parent];
        }   
    }
    else{
        for(NSString *parent in parentIDs)
        {
            ODataQuery *query = [service getMediaCollectionForBPParentEntryQueryWithParentID:parent andKeyword:@"LOGO" andMediaType:@"Attachment"];
            id<SDMRequesting>request = [connectivityHelper executeBasicSyncRequestWithQuery:query];
            Media *result = [service getMediasetEntryWithData:request.responseData error:&error];
            if(!error)
            {
                id<SDMRequesting>requestImage = [connectivityHelper executeBasicSyncRequestWithQuery:result.mediaLinkRead.mediaLinkQuery];
                UIImage *logo = [UIImage imageWithData:requestImage.responseData];
                if(logo)
                    [parentsPic setObject:logo forKey:parent];
                else
                    [parentsPic setObject:[UIImage imageNamed:@"AllComps.png"] forKey:parent];
            }
            else
                [parentsPic setObject:[UIImage imageNamed:@"AllComps.png"] forKey:parent];
            
        }
    }
    NSDictionary *userinfo;
    if(parentsPic.count > 0)
        userinfo = [NSDictionary dictionaryWithObject:parentsPic forKey:kResponseItems];
    else
        userinfo = [NSDictionary dictionaryWithObject:@"No pics found!" forKey:kResponseError];
    [[NSNotificationCenter defaultCenter]postNotificationName:kParentsPicLoaded object:self userInfo:userinfo];
    
}
-(void)loadImagesforContacts:(NSArray*)contacts;
{
    NSMutableDictionary *photos = [NSMutableDictionary dictionary];
    NSString *noImages;
    if([SettingsUtilities getDemoStatus])
    {
    }
    else
    {
        
        for(ContactPerson *cp in contacts)
        {
            if(!viewVisible)
                return;
            NSError *error;
            id<SDMRequesting>request = [connectivityHelper executeBasicSyncRequestWithQuery:[service getMediasetEntryQueryWithKeyword:@"Passphoto" andRelatedID:cp.ContactPersonID andSource:@"MediaForContactPerson" andMediaType:@"Attachment"]];
            Media *result = [service getMediasetEntryWithData:request.responseData error:&error];
            if(!error)
            {
                id<SDMRequesting>requestImage = [connectivityHelper executeBasicSyncRequestWithQuery:result.mediaLinkRead.mediaLinkQuery];
                UIImage *passPhoto = [UIImage imageWithData:requestImage.responseData];
                if(passPhoto)
                    [photos setObject:passPhoto forKey:cp.ContactPersonID];
            }
            else
            {
                if(!noImages)
                    noImages = @"No Images found!";
            }
        }
    }
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    
    if(photos.count > 0)
        [temp setObject:photos forKey:kResponseItems];
    if(noImages)
        [temp setObject:noImages forKey:kResponseError];
    if(viewVisible)
        [[NSNotificationCenter defaultCenter]postNotificationName:kPassPhotosLoaded object:self userInfo:temp];
}



-(BOOL)uploadPicture:(UIImage*)photo withKeyword:(NSString*)key andRelatedID:(NSString*)relID andSource:(NSString*)source andType:(NSString*)mediatype
{
    if([SettingsUtilities getDemoStatus])
    {
        NSMutableDictionary *tempDic = [[[DemoData getInstance]bupaPictures]objectForKey:relID];
        if(!tempDic)
        {
            [[[DemoData getInstance]bupaPictures]setObject:[NSMutableDictionary dictionaryWithObject:photo forKey:key] forKey:relID];
        }
        else
            [tempDic setObject:photo forKey:key];
        return YES;
    }
    NSString *slug = [NSString stringWithFormat:@"Keyword='%@',RelatedID='%@',Source='%@',MediaType='%@',Filename='PhotoTakenOn:%@.jpeg'",key,relID,source,mediatype,[NSDate date]];
    MediaLink *link = [[MediaLink alloc]initWithQuery:service.MediasetQuery andContentType:@"image/jpeg" andSlug:slug];
    NSMutableData *body = (NSMutableData*)UIImageJPEGRepresentation(photo, 0.7);
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    if(csrf)
    {
        id<SDMRequesting>request = [connectivityHelper executeCreateMediaLinkSyncRequest:link andBody:body andCSRFData:csrf];
        NSString *result = [request responseStatusMessage];
        NSLog(@"Result: %@",result);
        if([result hasPrefix:@"HTTP/1.1 201"])
            return YES;
    }
    return NO;
}

-(BOOL)uploadPicture:(UIImage*)photo forSlug:(NSString*)slug
{
    if([SettingsUtilities getDemoStatus])
    {
        return NO;
        
    }
    MediaLink *link = [[MediaLink alloc]initWithQuery:service.MediasetQuery andContentType:@"image/jpeg" andSlug:slug];
    NSMutableData *body = (NSMutableData*)UIImageJPEGRepresentation(photo, 0.7);
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    if(csrf)
    {
        id<SDMRequesting>request = [connectivityHelper executeCreateMediaLinkSyncRequest:link andBody:body andCSRFData:csrf];
        NSString *result = [request responseStatusMessage];
        NSLog(@"Result: %@",result);
        if([result hasPrefix:@"HTTP/1.1 201"])
            return YES;
    }
    return NO;
}

#pragma mark - Methods for Notes
-(void)loadNotesForBusinessPartner:(BusinessPartner*)bupa withPrefix:(NSString*)pref
{
    NSMutableDictionary *notes= [NSMutableDictionary dictionary];
    if([SettingsUtilities getDemoStatus])
    {
        NSMutableDictionary *tempNotes = [[[DemoData getInstance]bupaNotes]objectForKey:bupa.BusinessPartnerID];
        for(NSString *key in tempNotes.allKeys)
        {
            if(!pref || [key hasPrefix:pref])
            {
                NSString *secondKey;
                if(!([key rangeOfString:@"_%_"].location == NSNotFound))
                {
                    NSArray *subs = [key componentsSeparatedByString:@"_%_"];
                    secondKey = subs[subs.count-2];
                }
                else
                    secondKey = key;
                [notes setObject:tempNotes[key] forKey:secondKey];
            }
        }
    }
    else
    {
        NSError *error;
        
        id<SDMRequesting>request = [connectivityHelper executeBasicSyncRequestWithQuery:bupa.MediaCollectionQuery];
        NSMutableArray *tempResults = [service getMediaCollectionForBusinessPartnerWithData:[request responseData] error:&error];
        NSMutableArray *tempNotesEntries = [NSMutableArray array];
        
        for(MediaForBusinessPartner* temp in tempResults)
        {
            if([temp.MediaType isEqualToString:@"Note"] && (!pref || [temp.Keyword hasPrefix:pref]))
            {
                [tempNotesEntries addObject:temp];
            }
        }
        for(MediaForBusinessPartner *temp in tempNotesEntries)
        {
            if(!viewVisible)
                return;
            id<SDMRequesting>requestAttachment = [connectivityHelper executeBasicSyncRequestWithQuery:temp.MediaQuery];
            Media *tempMedia = [service getMediasetEntryWithData:[requestAttachment responseData] error:&error];
            if([tempMedia.ContentType hasPrefix:@"text"])
            {
                id<SDMRequesting>requestNote = [connectivityHelper executeBasicSyncRequestWithQuery:tempMedia.mediaLinkRead.mediaLinkQuery];
                NSString *result = [[NSString alloc]initWithData:requestNote.responseData encoding:NSUTF8StringEncoding];
                if(result)
                {
                    if(!([tempMedia.Keyword rangeOfString:@"_%_"].location == NSNotFound))
                    {
                        NSArray *subs = [tempMedia.Keyword componentsSeparatedByString:@"_%_"];
                        tempMedia.Keyword = subs[subs.count-2];
                    }
                    [notes setObject:result forKey:tempMedia.Keyword];
                }
            }
        }
    }
    NSDictionary *temp ;
    NSString *noNotes = @"No Notes found!";
    if(notes.count > 0)
        temp = [NSDictionary dictionaryWithObject:notes forKey:kResponseItems];
    else
        temp = [NSDictionary dictionaryWithObject:noNotes forKey:kResponseError];
    if(viewVisible)
    {
        if([pref isEqualToString:@"ALERT"])
            [[NSNotificationCenter defaultCenter]postNotificationName:kAlertsLoaded object:self userInfo:temp];
        else
            [[NSNotificationCenter defaultCenter]postNotificationName:kNotesLoaded object:self userInfo:temp];
    }
}

-(BOOL)uploadNote:(NSString*)note withTitle:(NSString*)title withCategory:(NSString*)category forBusinessPartner:(BusinessPartner*)bupa
{
    if([SettingsUtilities getDemoStatus])
    {
        NSMutableDictionary *temp = [[[DemoData getInstance]bupaNotes]objectForKey:bupa.BusinessPartnerID];
        [temp setObject:note forKey:title];
        return YES;
    }
    NSString *keyword;
    if(category)
        keyword = [NSString stringWithFormat:@"%@_%%_%@_%%_%@",category,title,[NSDate date]];
    else
        keyword = [NSString stringWithFormat:@"%@_%%_%@",title,[NSDate date]];
    NSString *slug= [NSString stringWithFormat:@"Keyword='%@',RelatedID='%@',Source='MediaForBusinessPartner',MediaType='Note'",keyword,bupa.BusinessPartnerID];
    MediaLink *link = [[MediaLink alloc]initWithQuery:service.MediasetQuery andContentType:@"text/plain" andSlug:slug];
    CSRFData *csrf = [connectivityHelper getCSRFDataForServiceQuery:service.serviceDocumentQuery];
    NSMutableData *body =  (NSMutableData*)[note dataUsingEncoding:NSUTF8StringEncoding];
    if(csrf)
    {
        id<SDMRequesting>request = [connectivityHelper executeCreateMediaLinkSyncRequest:link andBody:body andCSRFData:csrf];
        NSString *result = [request responseStatusMessage];
        NSLog(@"Result: %@",result);
        if([result hasPrefix:@"HTTP/1.1 201"])
            return YES;
    }
    return NO;
}


#pragma mark - Instance Methods Hierarchy

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

#pragma mark - Cancelling all ongoing transactions

@end