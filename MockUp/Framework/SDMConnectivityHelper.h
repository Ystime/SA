/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: SDMConnectivityHelper.h
 Abstract: A helper class that helps with making OData requests to the server.
 
 
 */


#import <Foundation/Foundation.h>
#import "ODataQuery.h"
#import "CSRFData.h"
#import "MediaLink.h"

// SAP OData Mobile SDK Imports
#import "SDMConnectivityHelperDelegate.h"
#import "SDMHttpRequestDelegate.h"
#import "SDMODataEntry.h"
#import "SDMODataServiceDocument.h"

/**
 * Uncomment the following line for SUP Server connectivity support 
 * Make sure to uncomment the additional required methods under "Methods for SUP Server connectivity" pragma mark.
 * In addition, make sure to reference the libSUPProxyClient.a library and SUPProxyClient headers in the project
 */
//#import "LiteSUPUserManager.h"

/**
 A helper class that helps with making OData requests to the server.
 */
@interface SDMConnectivityHelper : NSObject {
    __weak id <SDMConnectivityHelperDelegate> m_delegate;
    BOOL isSUPMode;
}


/**
 Creates an instance of the SDMConnectivityHelper class.
 @param aUsername The user name used to login to the service.
 @param aPassword The password for the provided user name.
 */
- (id)initWithUsername:(NSString *)aUsername andPassword:(NSString *)aPassword;


#pragma mark - Execute OData query synchronously

/**
 A helper method that executes an OData query synchronously.
 @param aQuery The OData query to execute.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeBasicSyncRequestWithQuery:(ODataQuery *)aQuery;

/**
 A helper method that executes an OData query synchronously.
 @param aQuery The OData query to execute.
 @param aBody The request body.
 @param aHttpMethod The HTTP method to use in this request.
 @param aCSRFData Object containing the CSRF cookie and token.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeBasicSyncRequestWithQuery:(ODataQuery *)aQuery andBody:(NSString *)aBody andMethod:(NSString *)aHttpMethod andCSRFData:(CSRFData *)aCSRFData;

/**
 A helper method that executes an OData Create query synchronously.
 @param aQuery The OData query to execute.
 @param aBody The post body.
 @param aCSRFData Object containing the CSRF cookie and token.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeCreateSyncRequestWithQuery:(ODataQuery *)aQuery andBody:(NSString *)aBody andCSRFData:(CSRFData *)aCSRFData;

/**
 A helper method that executes an OData Update query synchronously.
 @param aQuery The OData query to execute.
 @param aBody The post body.
 @param aCSRFData Object containing the CSRF cookie and token.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeUpdateSyncRequestWithQuery:(ODataQuery *)aQuery andBody:(NSString *)aBody andCSRFData:(CSRFData *)aCSRFData;

/**
 A helper method that executes an OData Delete query synchronously.
 @param aQuery The OData query to execute.
 @param aCSRFData Object containing the CSRF cookie and token.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeDeleteSyncRequestWithQuery:(ODataQuery *)aQuery andCSRFData:(CSRFData *)aCSRFData;

/**
 A helper method that creates an OData media link synchronously.
 @param aMediaLink The media link object to create.
 @param aBody The post body data.
 @param aCSRFData Object containing the CSRF cookie and token.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeCreateMediaLinkSyncRequest:(MediaLink *)aMediaLink andBody:(NSMutableData *)aBody andCSRFData:(CSRFData *)aCSRFData;

/**
 A helper method that updates an OData media link synchronously.
 @param aMediaLink The media link object to execute.
 @param aBody The request body data.
 @param aCSRFData Object containing the CSRF cookie and token.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeUpdateMediaLinkSyncRequest:(MediaLink *)aMediaLink andBody:(NSMutableData *)aBody andCSRFData:(CSRFData *)aCSRFData;

/**
 A helper method that deletes an OData media link synchronously.
 @param aMediaLink The media link object to execute.
 @param aCSRFData Object containing the CSRF cookie and token.
 @return <SDMRequesting> compliant object.
 */
- (id <SDMRequesting>)executeDeleteMediaLinkSyncRequest:(MediaLink *)aMediaLink andCSRFData:(CSRFData *)aCSRFData;

#pragma mark - Execute OData query asynchronously

/**
 A helper method that executes an OData query asynchronously.
 @param aQuery The OData query to execute.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 */
- (void)executeBasicAsyncRequestWithQuery:(ODataQuery *)aQuery andRequestDelegate:(__weak id<SDMHttpRequestDelegate>)aDelegate;

/**
 A helper method that executes an OData query asynchronously.
 @param aQuery The OData query to execute.
 @param aBody The request body.
 @param aHttpMethod The HTTP method to use in this request.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 */
- (void)executeBasicAsyncRequestWithQuery:(ODataQuery *)aQuery andBody:(NSString *)aBody andMethod:(NSString *)aHttpMethod andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id <SDMHttpRequestDelegate>)aDelegate;

/**
 A helper method that executes an OData query asynchronously, 
 with an option to define a specified selector for handling successfully received response, 
 and a userInfo dictionary for custom information associated with the request.
 @param aQuery The OData query to execute.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeBasicAsyncRequestWithQuery:(ODataQuery *)aQuery andRequestDelegate:(__weak id<SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo;

/**
 A helper method that executes an OData query asynchronously, 
 with an option to define a specified selector for handling successfully received response, 
 and a userInfo dictionary for custom information associated with the request.
 @param aQuery The OData query to execute.
 @param aBody The request body.
 @param aHttpMethod The HTTP method to use in this request.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeBasicAsyncRequestWithQuery:(ODataQuery *)aQuery andBody:(NSString *)aBody andMethod:(NSString *)aHttpMethod andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id<SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo ;

/**
 A helper method that executes an OData Create query asynchronously.
 @param aQuery The OData query to execute.
 @param aBody The post body.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeCreateAsyncRequestWithQuery:(ODataQuery *)aQuery andBody:(NSString *)aBody andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id<SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo;

/**
 A helper method that executes an OData Update query asynchronously.
 @param aQuery The OData query to execute.
 @param aBody The post body.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeUpdateAsyncRequestWithQuery:(ODataQuery *)aQuery andBody:(NSString *)aBody andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id<SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo;

/**
 A helper method that executes an OData Delete query asynchronously.
 @param aQuery The OData query to execute.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeDeleteAsyncRequestWithQuery:(ODataQuery *)aQuery andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id<SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo;

/**
 A helper method that creates an OData media link asynchronously.
 @param aMediaLink The media link object to create.
 @param aBody The post body data.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeCreateMediaLinkAsyncRequest:(MediaLink *)aMediaLink andBody:(NSMutableData *)aBody andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id <SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo;

/**
 A helper method that updates an OData media link asynchronously.
 @param aMediaLink The media link object to update.
 @param aBody The request body data.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeUpdateMediaLinkAsyncRequest:(MediaLink *)aMediaLink andBody:(NSMutableData *)aBody andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id <SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo;

/**
 A helper method that deletes an OData media link asynchronously.
 @param aMediaLink The media link object to create.
 @param aCSRFData Object containing the CSRF cookie and token.
 @param aDelegate A delegate to an SDMHttpRequestDelegate object that will handle the response.
 @param aFinishSelector A selector to a method that will handle the successfully received response (optional, may be nil).
 @param aUserInfo A userInfo dictionary with custom information associated with the request and can be used in method handling the response (optional, may be nil).
 */
- (void)executeDeleteMediaLinkAsyncRequest:(MediaLink *)aMediaLink andCSRFData:(CSRFData *)aCSRFData andRequestDelegate:(__weak id <SDMHttpRequestDelegate>)aDelegate andDidFinishSelector:(SEL)aFinishSelector andUserInfo:(NSDictionary *)aUserInfo;

#pragma mark - CSRF helper methods

/**
 A Helper method to get X-CSRF token.
 This is needed for POST requests.
 @param aServiceQuery to the service document (use serviceDocumentQuery property of your service proxy object).
 @return CSRFData containing the CSRF cookie and token.
 */
- (CSRFData *)getCSRFDataForServiceQuery:(ODataQuery *)aServiceQuery;

/**
 A Helper method to add X-CSRF token to the request.
 This is needed for POST requests.
 @param aRequest The request object to which the X-CSRF token will be added.
 @param aServiceQuery to the service document (use serviceDocumentQuery property of your service proxy object).
 */
- (void)addCSRFDataToRequest:(id <SDMRequesting>)aRequest andServiceQuery:(ODataQuery *)aServiceQuery;

#pragma  mark - Methods for SUP Server connectivity

/**
 * Uncomment the following methods for SUP Server connectivity support
 */

///**
// Switch SDMConnectivityHelper instance to work with SUP Server.
// Before executing calls to Gateway you must call registerSUPUser, or set the username and password properties using the LiteSUPUserManager vault.
// You must surround this method call with try-catch and refer to LiteSUPUserManager class documentation.
// @param aSUPHost a SUP Server host as configured by the Administrator of Sybase Control Center.
// @param aSUPPort a SUP Server port as configured by the Administrator of Sybase Control Center.
// @param aSUPFarmId a SUP Farm Id as configured by the Administrator of Sybase Control Center.
// @param aAppId an Application Id as configured by the Administrator of Sybase Control Center.
// @return a LiteSUPUserManager instance.
// */
//- (LiteSUPUserManager *)activateSUPModeWithHost:(NSString *)aSUPHost andSUPPort:(NSInteger)aSUPPort andSUPFarmId:(NSString *)aSUPFarmId andAppId:(NSString *)aAppId;
//
///**
// Switch SDMConnectivityHelper instance to work with SUP Server.
// Use this method only if the activateSUPModeWithHost:andSUPPort:andSUPFarmId:andAppId method was called in the past with the same application ID (in the current or a previous application run).
// Before executing calls to Gateway you must call registerSUPUser, or set the username and password properties using the LiteSUPUserManager vault.
// You must surround this method call with try-catch and refer to LiteSUPUserManager class documentation.
// @param aAppId an Application Id as configured by the Administrator of Sybase Control Center.
// @return a LiteSUPUserManager instance.
// */
//- (LiteSUPUserManager *)activateSUPModeWithAppId:(NSString *)aAppId;
//
///**
// Registers a new user.
// You must surround this method call with try-catch and refer to LiteSUPUserManager class documentation.
// @param aUsername a user name.
// @param aPassword a password.
// @param aSecurityConfigName as configured by the Administrator of Sybase Control Center.
// @param aSUPUserManager the LiteSUPUserManager instance that was returned by the switchToSUPModeWithHost method.
// */
//- (void)registerSUPUser:(NSString *)aUsername andPassword:(NSString *)aPassword andSecurityConfigName:(NSString *)aSecurityConfigName andSUPUserManager:(LiteSUPUserManager *)aSUPUserManager;
//
///**
// Registers a new user. Use the vault password for maximum security.
// You must surround this method call with try-catch and refer to LiteSUPUserManager class documentation.
// @param aUsername a user name.
// @param aPassword a password.
// @param aSecurityConfigName as configured by the Administrator of Sybase Control Center.
// @param aVaultPassword the password for the Vault.
// @param aSUPUserManager the LiteSUPUserManager instance that was returned by the switchToSUPModeWithHost method.
// */
//- (void)registerSUPUser:(NSString *)aUsername andPassword:(NSString *)aPassword andSecurityConfigName:(NSString *)aSecurityConfigName andVaultPassowrd:(NSString *)aVaultPassword andSUPUserManager:(LiteSUPUserManager *)aSUPUserManager;
//
///**
// Unregisters the registered user.
// @param aSUPUserManager the LiteSUPUserManager instance that was returned by the switchToSUPModeWithHost method.
// */
//- (void)unregisterSUPUser:(LiteSUPUserManager *)aSUPUserManager;

#pragma mark 

@property (strong, nonatomic) NSString *username; ///< The user name value for the service.
@property (strong, nonatomic) NSString *password; ///< The password for the user.
@property (strong, nonatomic) NSString *sapClient; ///< The SAP client to connect to.
@property (weak, nonatomic) id <SDMConnectivityHelperDelegate> delegate; ///< A delegate to an SDMConnectivityHelperDelegate object that will allow the HTTP request object customization before sending it to the server.

@end
