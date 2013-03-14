/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.100.0
  
 File: RequestHandler.h
 Abstract: A singleton class responsible for sending the appropriate service requests (for retrieving service data needed by the application views) and parsing the responses into semantic objects, using the SALES_INFORMATION service proxy and the SDMConnectivityHelper class. The sent requests also consider the service URL and the SAP client defined in the application settings. The class is also responsible for sending the appropriate notifications to the application delegate and view controllers, for handling the request success, failure and authentication challenge.  
 
 */

#import <Foundation/Foundation.h>
#import "SDMHttpRequestDelegate.h"
#import "SDMConnectivityHelper.h"
#import "NSStringAdditions.h"
#import "SettingsUtilities.h"
#import "DemoData.h"
//Notification UserInfo keys:
extern NSString * const kResponseItem; ///< Single item response
extern NSString * const kResponseItems; ///< Multiple items response
extern NSString * const kResponseError; ///< Response error message
extern NSString * const kResponseParentItem; ///< Item selected in the view previous to the one triggered the request

extern NSString * const kBusinessPartnerCreateCompletedNotification;

//Notification keys:
extern NSString * const kAuthenticationNeededNotification; ///< Notification key for request authentication challenge.
extern NSString * const kRequestErrorNotification; ///< Notification key for request error.

extern NSString * const kLoadBusinessPartnersCompletedNotification; ///< Notification key for successful loading of BusinessPartners items.

extern NSString * const kLoadContactsCompletedNotification;
extern NSString * const kContactCreateCompletedNotification;


extern NSString * const kLoadMaterialCompletedNotification;

extern NSString * const kLoadSalesDocumentsCompletedNotification;
extern NSString * const kLoadSalesDocumentItemsCompletedNotification;

extern NSString * const kLoadHierarchyCompletedNotification;


#define ERROR_DOMAIN @"SAP Netweaver Gateway Application"
#define kPicuresLoaded @"BUPA Pictures have been recieved"
#define kMaterialPicuresLoaded @"Material pictures have been recieved"
#define SERVICE_URL_EMPTY_ERROR_CODE 1001
#define LOGIN_ERROR_CODE 1002
#define SERVICE_METADATA_PARSE_ERROR_CODE 1005


/**
 A singleton class responsible for sending the appropriate service requests (for retrieving service data needed by the application views) and parsing the responses into semantic objects, using the SALES_INFORMATION service proxy and the SDMConnectivityHelper class. The sent requests also consider the service URL and the SAP client defined in the application settings. The class is also responsible for sending the appropriate notifications to the application delegate and view controllers, for handling the request success, failure and authentication challenge.
 */
@interface RequestHandler : NSObject <SDMHttpRequestDelegate, SDMConnectivityHelperDelegate> {
    SDMConnectivityHelper *connectivityHelper;
    ECCSALESDATA_SRVService *service;

    NSString *m_serviceDocumentURL;
    NSString *m_bwserviceDocumentURL;
    NSString *m_bwserviceDocumentURL2;
    NSString *m_client;
}

@property (strong, nonatomic, readonly) NSString *serviceDocumentURL; ///< SALES_INFORMATION service document URL retrieved from the application settings at instance initialization (used as base URL for service requests). 
@property (strong, nonatomic, readonly) NSString *client; ///< SAP client retrieved from the application settings at instance initialization (may be empty or nil for default client). 

/**
 @return RequestHandler singleton instance.
 */
+ (RequestHandler *)uniqueInstance;

/**
 @return BOOL indicating if service is valid.
 */
- (BOOL)isServiceValid;


-(BOOL)createBusinessPartner:(BusinessPartner*)bussPartner;

/**
 Load the service entity-set BusinessPartners items, parsed into BusinessPartner objects. 
 May send notifications with the following keys and associated objects (as userInfo dictionary):
 - kLoadBusinessPartnersCompletedNotification for successful request, along with the array of BusinessPartner items (for kResponseItems key) or parsing error message (for kResponseError key).
 - kRequestErrorNotification for request failure, along with the request error message (for kResponseError key).
 - kAuthenticationNeededNotification for request authentication challenge.
 */
- (void)loadBusinessPartners;

-(void)loadContacts:(BusinessPartner*)bupa;

-(BOOL) createContactPerson:(ContactPerson*)contact forBusinessPartner:(BusinessPartner*)bupa;

- (void)loadMaterials;

-(Material*)loadMaterial:(NSString*)barcode;


-(void)loadSalesDocuments:(NSString*)bupaID;

-(BOOL) createSalesDocument:(SalesDocument*)salesdoc;

-(void)loadSalesDocumentItems:(SalesDocument*)sd;

-(void)loadImagesforBusinessPartner:(BusinessPartner*)bupa;
-(void)loadImagesforMaterials:(NSArray*)materials;
-(void)loadHierarchyWithRootNode:(NSString*)bupaID;



/**
 Authenticates the given user name and password against the service.
 @param aUsername a user name.
 @param aPassword a password.
 @param error A pointer to an NSError object.
 @return BOOL indicating if authentication succeeded.
 */
- (BOOL)executeLoginWithUsername:(NSString *)aUsername andPassword:(NSString *)aPassword error:(NSError **)error;

@end
