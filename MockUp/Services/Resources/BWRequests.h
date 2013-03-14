//
//  BWRequests.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 26-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SDMHttpRequestDelegate.h"
#import "SDMConnectivityHelper.h"
#import "NSStringAdditions.h"
#import "SettingsUtilities.h"
#import "DemoData.h"
#import "ZAPP_AR01Service.h"
#import "ZAPP_ORDER01Service.h"
#import "ZAPP_ORDER02Service.h"
#import "ZAPP_ORDER03Service.h"

#define ERROR_DOMAIN @"SAP Netweaver Gateway Application"
#define SERVICE_URL_EMPTY_ERROR_CODE 1001
#define LOGIN_ERROR_CODE 1002
#define SERVICE_METADATA_PARSE_ERROR_CODE 1005
extern NSString * const kQueryNumber;
extern NSString * const kLoadQueryCompletedNotification;
extern NSString * const kLoadQueryErrorNotification;


@interface BWRequests : NSObject<SDMHttpRequestDelegate, SDMConnectivityHelperDelegate> {
    SDMConnectivityHelper *connectivityHelper;
    
    
    ZAPP_AR01Service *AR01Service;
    ZAPP_ORDER01Service *ORDER01Service;
    ZAPP_ORDER02Service *ORDER02Service;
    ZAPP_ORDER03Service *ORDER03Service;
    
    
    NSString *m_query1URL;
    NSString *m_query2URL;
    NSString *m_query3URL;
    NSString *m_query4URL;
    NSString *m_client;
}

@property (strong, nonatomic, readonly) NSString *query1URL;
@property (strong, nonatomic, readonly) NSString *query2URL;
@property (strong, nonatomic, readonly) NSString *query3URL;
@property (strong, nonatomic, readonly) NSString *query4URL;
@property (strong, nonatomic, readonly) NSString *client;

+ (BWRequests *)uniqueInstance;
- (void)loadQuery1ForBusinessPartner:(BusinessPartner*)bupa;
- (void)loadQuery2ForBusinessPartner:(BusinessPartner*)bupa andDocumentCategory:(NSString*)doc_cat;
- (void)loadQuery3ForBusinessPartner:(BusinessPartner*)bupa andDocumentCategory:(NSString*)doc_cat andMaterialGroup:(NSString*)matgr;
-(void)loadQuery4ForBusinessPartner:(BusinessPartner*)bupa andDebit:(NSString*)debit andKeyDate:(NSDate*)keyDate;
@end
