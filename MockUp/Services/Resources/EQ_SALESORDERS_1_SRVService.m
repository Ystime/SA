/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: EQ_SALESORDERS_1_SRVService.h
 Abstract: The generated proxy classes for the EQ_SALESORDERS_1_SRV Service. Service Version: 1.  
*/

#import "EQ_SALESORDERS_1_SRVService.h"
#import "BaseODataObject.h"
#import "Logger.h"
#import "SDMODataEntitySchema.h"
#import "SDMODataCollection.h"
#import "SDMODataFunctionImport.h"
#import "TypeConverter.h"

#define EQ_SALESORDERS_1_SRV_SERVICE_DOCUMENT @"EQ_SALESORDERS_1_SRVServiceDocument"
#define EQ_SALESORDERS_1_SRV_SERVICE_METADATA @"EQ_SALESORDERS_1_SRVServiceMetadata"

#pragma mark - Complex Types



#pragma mark - Entity Types


#pragma mark - ZAPP_ORDER03Result
@implementation ZAPP_ORDER03Result 

@synthesize ID = m_ID;
@synthesize CustomerId = m_CustomerId;
@synthesize CustomerName = m_CustomerName;
@synthesize DocumentCategoryId = m_DocumentCategoryId;
@synthesize DocumentCategory = m_DocumentCategory;
@synthesize MaterialGroupId = m_MaterialGroupId;
@synthesize MaterialGroup = m_MaterialGroup;
@synthesize MaterialId = m_MaterialId;
@synthesize Material = m_Material;
@synthesize NetValue = m_NetValue;
@synthesize NetValueStringFormat = m_NetValueStringFormat;
@synthesize NumberOfItems = m_NumberOfItems;
@synthesize NumberOfItemsStringFormat = m_NumberOfItemsStringFormat;

static NSMutableDictionary *zAPP_ORDER03ResultLabels = nil;
static SDMODataEntitySchema *zAPP_ORDER03ResultEntitySchema = nil;

- (id)init
{
    self = [super init];
    if (self) {
        m_SDMEntry = [BaseEntityType createEmptySDMODataEntryWithSchema:zAPP_ORDER03ResultEntitySchema error:nil];
        if (!m_SDMEntry) {
            return nil;
        }        
        m_properties = nil;
        m_baseUrl = nil;
    }
    return self;
}



- (SDMODataEntry *)buildSDMEntryFromPropertiesAndReturnError:(NSError **)error
{
    if (m_SDMEntry) {
        NSError *innerError = nil;
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.ID forSDMPropertyWithName:@"ID" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.CustomerId forSDMPropertyWithName:@"CustomerId" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.CustomerName forSDMPropertyWithName:@"CustomerName" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.DocumentCategoryId forSDMPropertyWithName:@"DocumentCategoryId" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.DocumentCategory forSDMPropertyWithName:@"DocumentCategory" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.MaterialGroupId forSDMPropertyWithName:@"MaterialGroupId" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.MaterialGroup forSDMPropertyWithName:@"MaterialGroup" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.MaterialId forSDMPropertyWithName:@"MaterialId" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.Material forSDMPropertyWithName:@"Material" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.NetValue forSDMPropertyWithName:@"NetValue" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.NetValueStringFormat forSDMPropertyWithName:@"NetValueStringFormat" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.NumberOfItems forSDMPropertyWithName:@"NumberOfItems" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.NumberOfItemsStringFormat forSDMPropertyWithName:@"NumberOfItemsStringFormat" error:&innerError];
        if (innerError) {
            if (error) {
                *error = innerError;
            }
            return nil;
        }
	}
    return m_SDMEntry;
}

+ (void)loadEntitySchema:(SDMODataServiceDocument *)aService
{
    SDMODataCollection *collectionSchema = [aService.schema getCollectionByName:@"ZAPP_ORDER03Results" workspaceOfCollection:nil];
    zAPP_ORDER03ResultEntitySchema = collectionSchema.entitySchema;
}

+ (void)loadLabels:(SDMODataServiceDocument *)aService
{
		NSMutableDictionary *properties = [BaseODataObject getSchemaPropertiesFromCollection:@"ZAPP_ORDER03Results" andService:aService];
    	if (properties) {    
	    	zAPP_ORDER03ResultLabels = [NSMutableDictionary dictionary];
	    	for (SDMODataPropertyInfo *property in [properties allValues]) {
	        	[zAPP_ORDER03ResultLabels setValue:property.label forKey:property.name];
	    	}
	    }
	    else {
        	LOGERROR(@"Failed to load SAP labels from service metadata");
    	}
}


+ (NSString *)getLabelForProperty:(NSString *)aPropertyName
{
    return [BaseODataObject getLabelFromDictionary:zAPP_ORDER03ResultLabels forProperty:aPropertyName];
}

- (void)loadProperties
{
    [super loadProperties];
	m_ID = [self getStringValueForSDMPropertyWithName:@"ID"];
	m_CustomerId = [self getStringValueForSDMPropertyWithName:@"CustomerId"];
	m_CustomerName = [self getStringValueForSDMPropertyWithName:@"CustomerName"];
	m_DocumentCategoryId = [self getStringValueForSDMPropertyWithName:@"DocumentCategoryId"];
	m_DocumentCategory = [self getStringValueForSDMPropertyWithName:@"DocumentCategory"];
	m_MaterialGroupId = [self getStringValueForSDMPropertyWithName:@"MaterialGroupId"];
	m_MaterialGroup = [self getStringValueForSDMPropertyWithName:@"MaterialGroup"];
	m_MaterialId = [self getStringValueForSDMPropertyWithName:@"MaterialId"];
	m_Material = [self getStringValueForSDMPropertyWithName:@"Material"];
	m_NetValue = [self getDecimalValueForSDMPropertyWithName:@"NetValue"];
	m_NetValueStringFormat = [self getStringValueForSDMPropertyWithName:@"NetValueStringFormat"];
	m_NumberOfItems = [self getDecimalValueForSDMPropertyWithName:@"NumberOfItems"];
	m_NumberOfItemsStringFormat = [self getStringValueForSDMPropertyWithName:@"NumberOfItemsStringFormat"];
}

+ (NSMutableArray *)createZAPP_ORDER03ResultEntriesForSDMEntries:(NSMutableArray *)sdmEntries
{
    NSMutableArray *entries = [NSMutableArray array];
    for (SDMODataEntry *entry in sdmEntries) {
        ZAPP_ORDER03Result *zAPP_ORDER03ResultObject = [[ZAPP_ORDER03Result alloc] initWithSDMEntry:entry];
        [entries addObject:zAPP_ORDER03ResultObject];
    }
    return entries;
}


+ (NSMutableArray *)parseZAPP_ORDER03ResultEntriesWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getSDMEntriesForEntitySchema:zAPP_ORDER03ResultEntitySchema andData:aData error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [ZAPP_ORDER03Result createZAPP_ORDER03ResultEntriesForSDMEntries:sdmEntries];
}

+ (NSMutableArray *)parseExpandedZAPP_ORDER03ResultEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:zAPP_ORDER03ResultEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [ZAPP_ORDER03Result createZAPP_ORDER03ResultEntriesForSDMEntries:sdmEntries];
}

+ (ZAPP_ORDER03Result *)parseZAPP_ORDER03ResultEntryWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *zAPP_ORDER03ResultEntries = [ZAPP_ORDER03Result parseZAPP_ORDER03ResultEntriesWithData:aData error:error];
    if (!zAPP_ORDER03ResultEntries) {
    	return nil;
    }
    return (ZAPP_ORDER03Result *)[ZAPP_ORDER03Result getFirstObjectFromArray:zAPP_ORDER03ResultEntries];
}

+ (ZAPP_ORDER03Result *)parseExpandedZAPP_ORDER03ResultEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
	NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:zAPP_ORDER03ResultEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    NSMutableArray *zAPP_ORDER03ResultEntries = [ZAPP_ORDER03Result createZAPP_ORDER03ResultEntriesForSDMEntries:sdmEntries];
	return (ZAPP_ORDER03Result *)[ZAPP_ORDER03Result getFirstObjectFromArray:zAPP_ORDER03ResultEntries];
}



@end


#pragma mark - EQ_SALESORDERS_1_SRV Service Proxy


@implementation EQ_SALESORDERS_1_SRVService

@synthesize ZAPP_ORDER03ResultsQuery = m_ZAPP_ORDER03ResultsQuery;

- (NSString *)getServiceDocumentFilename
{
	return EQ_SALESORDERS_1_SRV_SERVICE_DOCUMENT;
}

- (NSString *)getServiceMetadataFilename
{
	return EQ_SALESORDERS_1_SRV_SERVICE_METADATA;
}

- (void)loadEntitySetQueries
{
	[super loadEntitySetQueries];
    m_ZAPP_ORDER03ResultsQuery = [self getQueryForRelativePath:@"ZAPP_ORDER03Results"];
}

- (void)loadEntitySchemaForAllEntityTypes
{
    [super loadEntitySchemaForAllEntityTypes];
    [ZAPP_ORDER03Result loadEntitySchema:m_serviceDocument];
}

- (void)loadLabels
{
    [super loadLabels];
    [ZAPP_ORDER03Result loadLabels:m_serviceDocument];
}

 
#pragma mark Service Entity Set methods
- (NSMutableArray *)getZAPP_ORDER03ResultsWithData:(NSData *)aData error:(NSError **)error
{
	return [ZAPP_ORDER03Result parseExpandedZAPP_ORDER03ResultEntriesWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}

- (ODataQuery *)getZAPP_ORDER03ResultsEntryQueryWithID:(NSString *)ID
{
	ID = [ODataQuery encodeURLParameter:ID];
	NSString *relativePath = [NSString stringWithFormat:@"ZAPP_ORDER03Results(ID=%@)", ID];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (ODataQuery *)getZAPP_ORDER03ResultsEntryQuery
{
	NSString *relativePath = [NSString stringWithFormat:@"ZAPP_ORDER03Results"];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (ODataQuery *)getZAPP_ORDER03ResultsEntryQueryTypedWithID:(NSString *)ID
{
	id <URITypeConverting> converter = [ODataURITypeConverter uniqueInstance];
	NSString *IDUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:ID]];
	NSString *relativePath = [NSString stringWithFormat:@"ZAPP_ORDER03Results(ID=%@)", IDUri];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (ZAPP_ORDER03Result *)getZAPP_ORDER03ResultsEntryWithData:(NSData *)aData error:(NSError **)error
{
	return [ZAPP_ORDER03Result parseExpandedZAPP_ORDER03ResultEntryWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}



#pragma mark Service Function Import methods 

@end