/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: ZAPP_ORDER01Service.h
 Abstract: The generated proxy classes for the ZAPP_ORDER01 Service. Service Version: 1.   
*/

#import <Foundation/Foundation.h>
#import "BaseEntityType.h"
#import "BaseComplexType.h"
#import "BaseServiceObject.h"

#pragma mark - Complex Types



#pragma mark - Entity Types

/**
 Each of the following classes represents an entity-type of the ZAPP_ORDER01Service service.
 
 Any entity-type class should be used as following:
 
 1. The entity object may represent an existing entry of an appropriate service collection,
 if the object is initialized using data returned from an appropriate service call.
 This may be achieved by using the initWithSDMEntry: constructor,
 or using the static methods creating the entity object (parse<entity-type-name>EntriesWithData,
 parse<entity-type-name>EntryWithData, and create<entity-type-name>EntriesForSDMEntries).
 
 For retrieving the entry data, use the appropriate query properties and methods of this class 
 and of the ZAPP_ORDER01Service class, and then execute the request (see the SDMConnectivityHelper class).
 
 2. Another option is to use this entity object as a new entry to create in an appropriate service collection.
 In this case, use the init constructor and set the appropriate properties. 
 Note that some features (as navigation properties) are not available in this mode (since it is not yet an actual service entry).
 Use the SDMConnectivityHelper class and the getXMLForCreateRequest method of the BaseServiceObject class, to send the 'create' request.
 Then use the service response for constructing a new object, in order to represent the entry as existed in the service. 
 
 In both operation modes, setting the entity property values will not affect the service until the changes are sent to the server.
 For sending changes to the server, see the SDMConnectivityHelper class and the getXMLForRequest methods of the BaseServiceObject class.
 It is recommended to use the server response for constructing a new object, in order to represent the entry as existed in the service.
 
 Note: For proper behavior of this class, make sure to initialize the ZAPP_ORDER01Service class
 in your application, before initializing the entity-type class objects.
*/
 

#pragma mark - AZAPP_ORDER01Result
@interface AZAPP_ORDER01Result : BaseEntityType {
	NSString *m_ROWID;
	NSString *m_A0SOLD_TO;
	NSString *m_A0SOLD_TO_T;
	NSString *m_A0DOC_CATEG;
	NSString *m_A0DOC_CATEG_T;
	NSDecimalNumber *m_A006EI3ULWC7I23DQTK2PB6GHO;
	NSString *m_A006EI3ULWC7I23DQTK2PB6GHO_F;
	NSDecimalNumber *m_A006EI3ULWC7I23DS6UU6EBLKS;
	NSString *m_A006EI3ULWC7I23DS6UU6EBLKS_F;
	NSString *m_ISTOTAL;

}

@property (strong, nonatomic) NSString *ROWID; ///< ROWID - Edm.String
@property (strong, nonatomic) NSString *A0SOLD_TO; ///< Sold-to party - Edm.String
@property (strong, nonatomic) NSString *A0SOLD_TO_T; ///< Sold-to party - Edm.String
@property (strong, nonatomic) NSString *A0DOC_CATEG; ///< SD Document Category - Edm.String
@property (strong, nonatomic) NSString *A0DOC_CATEG_T; ///< SD Document Category - Edm.String
@property (strong, nonatomic) NSDecimalNumber *A006EI3ULWC7I23DQTK2PB6GHO; ///< Net val. in statCurr - Edm.Decimal
@property (strong, nonatomic) NSString *A006EI3ULWC7I23DQTK2PB6GHO_F; ///< Net val. in statCurr (Formatted) - Edm.String
@property (strong, nonatomic) NSDecimalNumber *A006EI3ULWC7I23DS6UU6EBLKS; ///< No. of docs - Edm.Decimal
@property (strong, nonatomic) NSString *A006EI3ULWC7I23DS6UU6EBLKS_F; ///< No. of docs (Formatted) - Edm.String
@property (strong, nonatomic) NSString *ISTOTAL; ///< Total/Subtotal Columns - Edm.String

#pragma mark Static Methods
/**
 Static method that returns an array of AZAPP_ORDER01Result entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER01Result entities.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER01Result entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseAZAPP_ORDER01ResultEntriesWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER01Result entities and their related entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER01Result entities.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER01Result entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseExpandedAZAPP_ORDER01ResultEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER01Result entity from the provided data.
 @param aData The NSData containing an Atom Entry including the entry to be parsed to a AZAPP_ORDER01Result entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER01Result entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER01Result *)parseAZAPP_ORDER01ResultEntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER01Result entity and related entities from the provided data.
 @param aData The NSData containing an Atom Entry including the entry and its related entries to be parsed to a AZAPP_ORDER01Result entity.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER01Result entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER01Result *)parseExpandedAZAPP_ORDER01ResultEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER01Result objects from a given array of SDMODataEntry objects.
 @param sdmEntries Array of SDMODataEntry objects.
 @return Array of AZAPP_ORDER01Result objects.
*/
+ (NSMutableArray *)createAZAPP_ORDER01ResultEntriesForSDMEntries:(NSMutableArray *)sdmEntries;

/**
 Static method that loads the entity schema of this type.
 This method is called when the ZAPP_ORDER01Service class is initialized.
 @param aService Service document object containing all of the entity type properties.
*/
+ (void)loadEntitySchema:(SDMODataServiceDocument *)aService;

/**
 Static method that loads all of the entity type property labels.
 This method is called when the ZAPP_ORDER01Service class is initialized.
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

#pragma mark - AZAPP_ORDER01Parameters
@interface AZAPP_ORDER01Parameters : BaseEntityType {
	NSString *m_A0S_CUSTOFrom;
	NSString *m_A0S_CUSTOTo;
	NSString *m_A0S_CUSTOText;
    ODataQuery *m_ResultsQuery;
	NSMutableArray *m_Results;

}

@property (strong, nonatomic) NSString *A0S_CUSTOFrom; ///< Sold-to party (optional entry) - Edm.String
@property (strong, nonatomic) NSString *A0S_CUSTOTo; ///< Sold-to party (optional entry) - Edm.String
@property (strong, nonatomic) NSString *A0S_CUSTOText; ///< Sold-to party (optional entry) (Text) - Edm.String
#pragma mark Entity Navigation Properties
@property (strong, nonatomic) ODataQuery *ResultsQuery;
@property (strong, nonatomic) NSMutableArray *Results;

#pragma mark Static Methods
/**
 Static method that returns an array of AZAPP_ORDER01Parameters entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER01Parameters entities.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER01Parameters entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseAZAPP_ORDER01ParametersEntriesWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER01Parameters entities and their related entities from the provided data.
 @param aData The NSData containing an Atom Feed including the entries to be parsed to AZAPP_ORDER01Parameters entities.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER01Parameters entities. Returns nil if the data in invalid.
*/
+ (NSMutableArray *)parseExpandedAZAPP_ORDER01ParametersEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER01Parameters entity from the provided data.
 @param aData The NSData containing an Atom Entry including the entry to be parsed to a AZAPP_ORDER01Parameters entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER01Parameters entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER01Parameters *)parseAZAPP_ORDER01ParametersEntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns a single AZAPP_ORDER01Parameters entity and related entities from the provided data.
 @param aData The NSData containing an Atom Entry including the entry and its related entries to be parsed to a AZAPP_ORDER01Parameters entity.
 @param aServiceDocument The SDMODataServiceDocument that represents the service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER01Parameters entity. Returns nil if the data in invalid.
*/
+ (AZAPP_ORDER01Parameters *)parseExpandedAZAPP_ORDER01ParametersEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error;

/**
 Static method that returns an array of AZAPP_ORDER01Parameters objects from a given array of SDMODataEntry objects.
 @param sdmEntries Array of SDMODataEntry objects.
 @return Array of AZAPP_ORDER01Parameters objects.
*/
+ (NSMutableArray *)createAZAPP_ORDER01ParametersEntriesForSDMEntries:(NSMutableArray *)sdmEntries;

/**
 Static method that loads the entity schema of this type.
 This method is called when the ZAPP_ORDER01Service class is initialized.
 @param aService Service document object containing all of the entity type properties.
*/
+ (void)loadEntitySchema:(SDMODataServiceDocument *)aService;

/**
 Static method that loads all of the entity type property labels.
 This method is called when the ZAPP_ORDER01Service class is initialized.
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



#pragma mark - ZAPP_ORDER01 Service Proxy
@interface ZAPP_ORDER01Service : BaseServiceObject {
    ODataQuery *m_AZAPP_ORDER01Query;
    ODataQuery *m_AZAPP_ORDER01ResultsQuery;

}

#pragma mark Query properties for service Entity Sets
/**
The OData query for the AZAPP_ORDER01Parameters collection.
(Addressable true, Requires-filter false, Creatable false, Updatable false, Deletable false)
*/
@property (strong, nonatomic) ODataQuery *AZAPP_ORDER01Query;

/**
The OData query for the AZAPP_ORDER01Result collection.
(Addressable false, Requires-filter false, Creatable false, Updatable false, Deletable false)
*/
@property (strong, nonatomic) ODataQuery *AZAPP_ORDER01ResultsQuery;


#pragma mark Service Entity Set methods
/**
 Returns a collection of AZAPP_ORDER01Parameters entities from the data returned by the OData service.
 @param aData The NSData returned from the OData service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER01Parameters entities.
*/
- (NSMutableArray *)getAZAPP_ORDER01WithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns the OData query for a specific AZAPP_ORDER01Parameters entity.
 @param A0S_CUSTOFrom Part of the AZAPP_ORDER01Parameters unique identifier (of type Edm.String).
 @param A0S_CUSTOTo Part of the AZAPP_ORDER01Parameters unique identifier (of type Edm.String).
 Note: pass the parameter values exactly as they should appear in the query URL, 
 in the correct format according to their types 
 (for more information, see: http://www.odata.org/documentation/overview#AbstractTypeSystem).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER01EntryQueryWithA0S_CUSTOFrom:(NSString *)A0S_CUSTOFrom andA0S_CUSTOTo:(NSString *)A0S_CUSTOTo;

/**
 Returns the OData query for a specific AZAPP_ORDER01Parameters entity with typed parameters.
 Note: This method is relevant only for OData compliant services.
 @param A0S_CUSTOFrom Part of the AZAPP_ORDER01Parameters unique identifier (of type Edm.String).
 @param A0S_CUSTOTo Part of the AZAPP_ORDER01Parameters unique identifier (of type Edm.String).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER01EntryQueryTypedWithA0S_CUSTOFrom:(NSString *)A0S_CUSTOFrom andA0S_CUSTOTo:(NSString *)A0S_CUSTOTo;

/**
 Returns a specific AZAPP_ORDER01Parameters entity from the provided data.
 @param aData The NSData containing the AZAPP_ORDER01Parameters information to be parsed to a AZAPP_ORDER01Parameters entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER01Parameters entity. Returns nil if the data in invalid.
*/
- (AZAPP_ORDER01Parameters *)getAZAPP_ORDER01EntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;
/**
 Returns a collection of AZAPP_ORDER01Result entities from the data returned by the OData service.
 @param aData The NSData returned from the OData service.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns an array of AZAPP_ORDER01Result entities.
*/
- (NSMutableArray *)getAZAPP_ORDER01ResultsWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;

/**
 Returns the OData query for a specific AZAPP_ORDER01Result entity.
 @param ROWID Part of the AZAPP_ORDER01Result unique identifier (of type Edm.String).
 Note: pass the parameter values exactly as they should appear in the query URL, 
 in the correct format according to their types 
 (for more information, see: http://www.odata.org/documentation/overview#AbstractTypeSystem).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER01ResultsEntryQueryWithROWID:(NSString *)ROWID;

/**
 Returns the OData query for a specific AZAPP_ORDER01Result entity with typed parameters.
 Note: This method is relevant only for OData compliant services.
 @param ROWID Part of the AZAPP_ORDER01Result unique identifier (of type Edm.String).
 @return Returns an OData query object.
*/
- (ODataQuery *)getAZAPP_ORDER01ResultsEntryQueryTypedWithROWID:(NSString *)ROWID;

/**
 Returns a specific AZAPP_ORDER01Result entity from the provided data.
 @param aData The NSData containing the AZAPP_ORDER01Result information to be parsed to a AZAPP_ORDER01Result entity.
 @param error A pointer to an NSError object that will hold the error info if one occurs.
 @return Returns a AZAPP_ORDER01Result entity. Returns nil if the data in invalid.
*/
- (AZAPP_ORDER01Result *)getAZAPP_ORDER01ResultsEntryWithData:(NSData *)aData error:(NSError * __autoreleasing *)error;


#pragma mark Service Function Import methods
@end