/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: ZAPP_ORDER02Service.h
 Abstract: The generated proxy classes for the ZAPP_ORDER02 Service. Service Version: 1.   
*/

#import <Foundation/Foundation.h>
#import "BaseEntityType.h"
#import "BaseComplexType.h"
#import "BaseServiceObject.h"

#pragma mark - Complex Types



#pragma mark - Entity Types

/**
 Each of the following classes represents an entity-type of the ZAPP_ORDER02Service service.
 
 Any entity-type class should be used as following:
 
 1. The entity object may represent an existing entry of an appropriate service collection,
 if the object is initialized using data returned from an appropriate service call.
 This may be achieved by using the initWithSDMEntry: constructor,
 or using the static methods creating the entity object (parse<entity-type-name>EntriesWithData,
 parse<entity-type-name>EntryWithData, and create<entity-type-name>EntriesForSDMEntries).
 
 For retrieving the entry data, use the appropriate query properties and methods of this class 
 and of the ZAPP_ORDER02Service class, and then execute the request (see the SDMConnectivityHelper class).
 
 2. Another option is to use this entity object as a new entry to create in an appropriate service collection.
 In this case, use the init constructor and set the appropriate properties. 
 Note that some features (as navigation properties) are not available in this mode (since it is not yet an actual service entry).
 Use the SDMConnectivityHelper class and the getXMLForCreateRequest method of the BaseServiceObject class, to send the 'create' request.
 Then use the service response for constructing a new object, in order to represent the entry as existed in the service. 
 
 In both operation modes, setting the entity property values will not affect the service until the changes are sent to the server.
 For sending changes to the server, see the SDMConnectivityHelper class and the getXMLForRequest methods of the BaseServiceObject class.
 It is recommended to use the server response for constructing a new object, in order to represent the entry as existed in the service.
 
 Note: For proper behavior of this class, make sure to initialize the ZAPP_ORDER02Service class
 in your application, before initializing the entity-type class objects.
*/
 

#pragma mark - AZAPP_ORDER02Result
@interface AZAPP_ORDER02Result : BaseEntityType {
	NSString *m_ROWID;
	NSString *m_A0SOLD_TO;
	NSString *m_A0SOLD_TO_T;
	NSString *m_A0DOC_CATEG;
	NSString *m_A0DOC_CATEG_T;
	NSString *m_A0MATERIAL__0MATL_GROUP;
	NSString *m_A0MATERIAL__0MATL_GROUP_T;
	NSDecimalNumber *m_A006EI3ULWC7I23DR830YQPUD8;
	NSString *m_A006EI3ULWC7I23DR830YQPUD8_F;
	NSDecimalNumber *m_A006EI3ULWC7I23F3EUWUWJ858;
	NSString *m_A006EI3ULWC7I23F3EUWUWJ858_F;
	NSString *m_ISTOTAL;

}

@property (strong, nonatomic) NSString *ROWID; ///< ROWID - Edm.String
@property (strong, nonatomic) NSString *A0SOLD_TO; ///< Sold-to party - Edm.String
@property (strong, nonatomic) NSString *A0SOLD_TO_T; ///< Sold-to party - Edm.String
@property (strong, nonatomic) NSString *A0DOC_CATEG; ///< SD Document Category - Edm.String
@property (strong, nonatomic) NSString *A0DOC_CATEG_T; ///< SD Document Category - Edm.String
@property (strong, nonatomic) NSString *A0MATERIAL__0MATL_GROUP; ///< Material Group - Edm.String
@property (strong, nonatomic) NSString *A0MATERIAL__0MATL_GROUP_T; ///< Material Group - Edm.String
@property (strong, nonatomic) NSDecimalNumber *A006EI3ULWC7I23DR830YQPUD8; ///< Net val. in statCurr - Edm.Decimal
@property (strong, nonatomic) NSString *A006EI3ULWC7I23DR830YQPUD8_F; ///< Net val. in statCurr (Formatted) - Edm.String
@property (strong, nonatomic) NSDecimalNumber *A006EI3ULWC7I23F3EUWUWJ858; ///< No. Document Items - Edm.Decimal
@property (strong, nonatomic) NSString *A006EI3ULWC7I23F3EUWUWJ858_F; ///< No. Document Items (Formatted) - Edm.String
@property (strong, nonatomic) NSString *ISTOTAL; ///< Total/Subtotal Columns - Edm.String

#pragma mark Static Methods
/**
 Static method that returns an array of AZAPP_ORDER02Result entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER02Result entities.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER02Result entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseAZAPP_ORDER02ResultEntriesWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER02Result entities and their related entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER02Result entities.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER02Result entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseExpandedAZAPP_ORDER02ResultEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER02Result entity from the provided data.
 @param aData The NSData containing an Atom Entry including the entry to be parsed to a AZAPP_ORDER02Result entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER02Result entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER02Result *)parseAZAPP_ORDER02ResultEntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER02Result entity and related entities from the provided data.
 @param aData The NSData containing an Atom Entry including the entry and its related entries to be parsed to a AZAPP_ORDER02Result entity.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER02Result entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER02Result *)parseExpandedAZAPP_ORDER02ResultEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER02Result objects from a given array of SDMODataEntry objects.
 @param sdmEntries Array of SDMODataEntry objects.
 @return Array of AZAPP_ORDER02Result objects.
*/
+ (NSMutableArray *)createAZAPP_ORDER02ResultEntriesForSDMEntries:(NSMutableArray *)sdmEntries;

/**
 Static method that loads the entity schema of this type.
 This method is called when the ZAPP_ORDER02Service class is initialized.
 @param aService Service document object containing all of the entity type properties.
*/
+ (void)loadEntitySchema:(SDMODataServiceDocument *)aService;

/**
 Static method that loads all of the entity type property labels.
 This method is called when the ZAPP_ORDER02Service class is initialized.
 @param aService Service document object containing all of the entity type properties.
*/
+ (void)loadLabels:(SDMODataServiceDocument *)aService;

/**
 Static method that returns the label for a given property name.
 @param aPropertyName Property name.
 @return Property label.
*/
+ (NSString *)getLabelForProperty:(NSString *)aPropertyName;



@end

#pragma mark - AZAPP_ORDER02Parameters
@interface AZAPP_ORDER02Parameters : BaseEntityType {
	NSString *m_ZDOCCAT1From;
	NSString *m_ZDOCCAT1To;
	NSString *m_ZDOCCAT1Text;
	NSString *m_A0S_CUSTOFrom;
	NSString *m_A0S_CUSTOTo;
	NSString *m_A0S_CUSTOText;
    ODataQuery *m_ResultsQuery;
	NSMutableArray *m_Results;

}

@property (strong, nonatomic) NSString *ZDOCCAT1From; ///< Document category - Edm.String
@property (strong, nonatomic) NSString *ZDOCCAT1To; ///< Document category - Edm.String
@property (strong, nonatomic) NSString *ZDOCCAT1Text; ///< Document category (Text) - Edm.String
@property (strong, nonatomic) NSString *A0S_CUSTOFrom; ///< Sold-to party (optional entry) - Edm.String
@property (strong, nonatomic) NSString *A0S_CUSTOTo; ///< Sold-to party (optional entry) - Edm.String
@property (strong, nonatomic) NSString *A0S_CUSTOText; ///< Sold-to party (optional entry) (Text) - Edm.String
#pragma mark Entity Navigation Properties
@property (strong, nonatomic) ODataQuery *ResultsQuery;
@property (strong, nonatomic) NSMutableArray *Results;

#pragma mark Static Methods
/**
 Static method that returns an array of AZAPP_ORDER02Parameters entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER02Parameters entities.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER02Parameters entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseAZAPP_ORDER02ParametersEntriesWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER02Parameters entities and their related entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER02Parameters entities.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER02Parameters entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseExpandedAZAPP_ORDER02ParametersEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER02Parameters entity from the provided data.
 @param aData The NSData containing an Atom Entry including the entry to be parsed to a AZAPP_ORDER02Parameters entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER02Parameters entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER02Parameters *)parseAZAPP_ORDER02ParametersEntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER02Parameters entity and related entities from the provided data.
 @param aData The NSData containing an Atom Entry including the entry and its related entries to be parsed to a AZAPP_ORDER02Parameters entity.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER02Parameters entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER02Parameters *)parseExpandedAZAPP_ORDER02ParametersEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER02Parameters objects from a given array of SDMODataEntry objects.
 @param sdmEntries Array of SDMODataEntry objects.
 @return Array of AZAPP_ORDER02Parameters objects.
*/
+ (NSMutableArray *)createAZAPP_ORDER02ParametersEntriesForSDMEntries:(NSMutableArray *)sdmEntries;

/**
 Static method that loads the entity schema of this type.
 This method is called when the ZAPP_ORDER02Service class is initialized.
 @param aService Service document object containing all of the entity type properties.
*/
+ (void)loadEntitySchema:(SDMODataServiceDocument *)aService;

/**
 Static method that loads all of the entity type property labels.
 This method is called when the ZAPP_ORDER02Service class is initialized.
 @param aService Service document object containing all of the entity type properties.
*/
+ (void)loadLabels:(SDMODataServiceDocument *)aService;

/**
 Static method that returns the label for a given property name.
 @param aPropertyName Property name.
 @return Property label.
*/
+ (NSString *)getLabelForProperty:(NSString *)aPropertyName;


#pragma mark Entity Navigation Property loading methods
/**
 Navigation property. Loads Results details for this entity from the provided data.
 @param aData The NSData containing the Results information to be parsed.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns YES if the method completed successfully.
*/
- (BOOL)loadResultsWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;


@end



#pragma mark - ZAPP_ORDER02 Service Proxy
@interface ZAPP_ORDER02Service : BaseServiceObject {
    ODataQuery *m_AZAPP_ORDER02Query;
    ODataQuery *m_AZAPP_ORDER02ResultsQuery;

}

#pragma mark Query properties for service Entity Sets
/**
The OData query for the AZAPP_ORDER02Parameters collection.
(Addressable true, Requires-filter false, Creatable false, Updatable false, Deletable false)
*/
@property (strong, nonatomic) ODataQuery *AZAPP_ORDER02Query;

/**
The OData query for the AZAPP_ORDER02Result collection.
(Addressable false, Requires-filter false, Creatable false, Updatable false, Deletable false)
*/
@property (strong, nonatomic) ODataQuery *AZAPP_ORDER02ResultsQuery;


#pragma mark Service Entity Set methods
/**
 Returns a collection of AZAPP_ORDER02Parameters entities from the data returned by the OData service.
 @param aData The NSData returned from the OData service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER02Parameters entities.
*/
- (NSMutableArray *)getAZAPP_ORDER02WithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns the OData query for a specific AZAPP_ORDER02Parameters entity.
 @param ZDOCCAT1From Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 @param ZDOCCAT1To Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 @param A0S_CUSTOFrom Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 @param A0S_CUSTOTo Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 Note: pass the parameter values exactly as they should appear in the query URL, 
 in the correct format according to their types 
 (for more information, see: http://www.odata.org/documentation/overview#AbstractTypeSystem).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER02EntryQueryWithZDOCCAT1From:(NSString *)ZDOCCAT1From andZDOCCAT1To:(NSString *)ZDOCCAT1To andA0S_CUSTOFrom:(NSString *)A0S_CUSTOFrom andA0S_CUSTOTo:(NSString *)A0S_CUSTOTo;

/**
 Returns the OData query for a specific AZAPP_ORDER02Parameters entity with typed parameters.
 Note: This method is relevant only for OData compliant services.
 @param ZDOCCAT1From Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 @param ZDOCCAT1To Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 @param A0S_CUSTOFrom Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 @param A0S_CUSTOTo Part of the AZAPP_ORDER02Parameters unique identifier (of type Edm.String).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER02EntryQueryTypedWithZDOCCAT1From:(NSString *)ZDOCCAT1From andZDOCCAT1To:(NSString *)ZDOCCAT1To andA0S_CUSTOFrom:(NSString *)A0S_CUSTOFrom andA0S_CUSTOTo:(NSString *)A0S_CUSTOTo;

/**
 Returns a specific AZAPP_ORDER02Parameters entity from the provided data.
 @param aData The NSData containing the AZAPP_ORDER02Parameters information to be parsed to a AZAPP_ORDER02Parameters entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER02Parameters entity. Returns nil if the data in invalid.
*/
- (AZAPP_ORDER02Parameters *)getAZAPP_ORDER02EntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;
/**
 Returns a collection of AZAPP_ORDER02Result entities from the data returned by the OData service.
 @param aData The NSData returned from the OData service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER02Result entities.
*/
- (NSMutableArray *)getAZAPP_ORDER02ResultsWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns the OData query for a specific AZAPP_ORDER02Result entity.
 @param ROWID Part of the AZAPP_ORDER02Result unique identifier (of type Edm.String).
 Note: pass the parameter values exactly as they should appear in the query URL, 
 in the correct format according to their types 
 (for more information, see: http://www.odata.org/documentation/overview#AbstractTypeSystem).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER02ResultsEntryQueryWithROWID:(NSString *)ROWID;

/**
 Returns the OData query for a specific AZAPP_ORDER02Result entity with typed parameters.
 Note: This method is relevant only for OData compliant services.
 @param ROWID Part of the AZAPP_ORDER02Result unique identifier (of type Edm.String).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER02ResultsEntryQueryTypedWithROWID:(NSString *)ROWID;

/**
 Returns a specific AZAPP_ORDER02Result entity from the provided data.
 @param aData The NSData containing the AZAPP_ORDER02Result information to be parsed to a AZAPP_ORDER02Result entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER02Result entity. Returns nil if the data in invalid.
*/
- (AZAPP_ORDER02Result *)getAZAPP_ORDER02ResultsEntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;


#pragma mark Service Function Import methods
@end