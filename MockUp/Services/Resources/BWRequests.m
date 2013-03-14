//
//  BWRequests.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 26-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "BWRequests.h"
#import "SDMRequestBuilder.h"
#import "SDMHttpRequest.h"
#import "SettingsUtilities.h"

NSString * const kQueryNumber = @"Number of the Query";
NSString * const kLoadQueryCompletedNotification = @"Query Result Loaded";
NSString * const kLoadQueryErrorNotification = @"Error loading Query";

@implementation BWRequests
@synthesize query1URL = m_query1URL;
@synthesize query2URL = m_query2URL;
@synthesize query3URL = m_query3URL;
@synthesize query4URL = m_query4URL;
@synthesize client = m_client;



- (id)init
{
    self = [super init];
    if (self) {
        m_query1URL = @"http://knowledge.nl4b.com/sap/opu/odata/sap/ZAPP_ORDER01";
        m_query2URL = @"http://knowledge.nl4b.com/sap/opu/odata/sap/ZAPP_ORDER02";
        m_query3URL = @"http://knowledge.nl4b.com/sap/opu/odata/sap/ZAPP_ORDER03";
        m_query4URL = @"http://knowledge.nl4b.com/sap/opu/odata/sap/ZAPP_AR01";
        
        ORDER01Service = [[ZAPP_ORDER01Service alloc]init];
        ORDER02Service = [[ZAPP_ORDER02Service alloc]init];
        ORDER03Service = [[ZAPP_ORDER03Service alloc]init];
        AR01Service = [[ZAPP_AR01Service alloc]init];

        
        m_client = @"100";
        
        if (m_query1URL.length > 0) {
            [ORDER01Service setServiceDocumentUrl:m_query1URL];
        }
        if ([m_query2URL length] > 0) {
            [ORDER02Service setServiceDocumentUrl:m_query2URL];
        }
        if ([m_query3URL length] > 0) {
            [ORDER03Service setServiceDocumentUrl:m_query3URL];
        }
        if ([m_query4URL length] > 0) {
            [AR01Service setServiceDocumentUrl:m_query4URL];
        }
		
        connectivityHelper = [[SDMConnectivityHelper alloc] init];
        if ([m_client length] > 0) {
            connectivityHelper.sapClient = m_client;
        }
        connectivityHelper.delegate = self;
    }
    return self;
}


#pragma mark - Singleton

+ (BWRequests *)uniqueInstance
{
    static BWRequests *instance;
	
    @synchronized(self) {
        if (!instance) {
            instance = [[BWRequests alloc] init];
        }
        return instance;
    }
}


#pragma mark - Query Calls

-(void)loadQuery1ForBusinessPartner:(BusinessPartner*)bupa
{
    if([SettingsUtilities getDemoStatus])
    {
        [[DemoData getInstance]postNotificationfor:@"BWQuery1"];
    }
    else
    {
        ODataQuery *query = [ORDER01Service getAZAPP_ORDER01EntryQueryWithA0S_CUSTOFrom:bupa.BusinessPartnerID andA0S_CUSTOTo:bupa.BusinessPartnerID];
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadQuery1ResultsCompleted:) andUserInfo:nil];
    }
}

-(void)loadQuery1ResultsCompleted:(id<SDMRequesting>)request
{
    NSMutableDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *items = [ORDER01Service getAZAPP_ORDER01ResultsWithData:[request responseData] error:&error];
    if (error) {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:items forKey:kResponseItems];
    }
    [userInfoDict setObject:[NSString stringWithFormat:@"1"] forKey:kQueryNumber];
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadQueryCompletedNotification object:self userInfo:userInfoDict];
}
-(void)loadQuery2ForBusinessPartner:(BusinessPartner*)bupa andDocumentCategory:(NSString*)doc_cat
{
    NSString *bupaid = bupa.BusinessPartnerID;
    if([SettingsUtilities getDemoStatus])
    {
        
    }
    else
    {
        ODataQuery *query = [ORDER02Service getAZAPP_ORDER02EntryQueryWithZDOCCAT1From:bupaid andZDOCCAT1To:bupaid andA0S_CUSTOFrom:doc_cat andA0S_CUSTOTo:doc_cat];
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadQuery2ResultsCompleted:) andUserInfo:nil];
    }
}

-(void)loadQuery2ResultsCompleted:(id<SDMRequesting>)request
{
    NSMutableDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *items = [ORDER02Service getAZAPP_ORDER02ResultsWithData:[request responseData] error:&error];
    if (error) {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:items forKey:kResponseItems];
    }
    [userInfoDict setObject:[NSString stringWithFormat:@"2"] forKey:kQueryNumber];
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadQueryCompletedNotification object:self userInfo:userInfoDict];
}

-(void)loadQuery3ForBusinessPartner:(BusinessPartner*)bupa andDocumentCategory:(NSString*)doc_cat andMaterialGroup:(NSString*)matgr
{
    NSString *bupaid = bupa.BusinessPartnerID;
    if([SettingsUtilities getDemoStatus])
    {
        
    }
    else
    {
        ODataQuery *query = [ORDER03Service getAZAPP_ORDER03EntryQueryWithZDOCCAT1From:doc_cat andZDOCCAT1To:doc_cat andA0S_CUSTOFrom:bupaid andA0S_CUSTOTo:bupaid andA0S_MATGFrom:matgr andA0S_MATGTo:matgr];
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadQuery3ResultsCompleted:) andUserInfo:nil];
    }
}

-(void)loadQuery3ResultsCompleted:(id<SDMRequesting>)request
{
    NSMutableDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *items = [ORDER03Service getAZAPP_ORDER03ResultsWithData:[request responseData] error:&error];
    if (error) {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:items forKey:kResponseItems];
    }
    [userInfoDict setObject:[NSString stringWithFormat:@"3"] forKey:kQueryNumber];
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadQueryCompletedNotification object:self userInfo:userInfoDict];
}


-(void)loadQuery4ForBusinessPartner:(BusinessPartner*)bupa andDebit:(NSString*)debit andKeyDate:(NSDate*)keyDate
{
    NSString *datum = [GlobalFunctions getStringFormat:@"ddMMyyyy" FromDate:keyDate];
    if([SettingsUtilities getDemoStatus])
    {
        [[DemoData getInstance]postNotificationfor:@"BWQuery4"];
    }
    else
    {
        ODataQuery *query = [AR01Service getAZAPP_AR01EntryQueryWithA0P_COCD:@"1000" andA0S_DEBITFrom:debit andA0S_DEBITTo:debit andA0P_KEYDT:datum];
        [connectivityHelper executeBasicAsyncRequestWithQuery:query andRequestDelegate:self andDidFinishSelector:@selector(loadQuery4ResultsCompleted:) andUserInfo:nil];
    }
}

-(void)loadQuery4ResultsCompleted:(id<SDMRequesting>)request
{
    NSMutableDictionary *userInfoDict;
    NSError *error;
    
    NSMutableArray *items = [AR01Service getAZAPP_AR01ResultsWithData:[request responseData] error:&error];
    if (error) {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:error forKey:kResponseError];
    }
    else {
        userInfoDict = [NSMutableDictionary dictionaryWithObject:items forKey:kResponseItems];
    }
    [userInfoDict setObject:[NSString stringWithFormat:@"4"] forKey:kQueryNumber];
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoadQueryCompletedNotification object:self userInfo:userInfoDict];
}




#pragma mark - SDMHttpRequestDelegate

- (void)requestFailed:(SDMHttpRequest *)request
{
    int statusCode = [request responseStatusCode];
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
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoadQueryErrorNotification object:self userInfo:[NSDictionary dictionaryWithObject:request.error forKey:kResponseError]];
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
