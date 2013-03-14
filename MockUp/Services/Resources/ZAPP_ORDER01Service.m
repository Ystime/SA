/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: ZAPP_ORDER01Service.h
 Abstract: The generated proxy classes for the ZAPP_ORDER01 Service. Service Version: 1.  
*/

#import "ZAPP_ORDER01Service.h"
#import "BaseODataObject.h"
#import "Logger.h"
#import "SDMODataEntitySchema.h"
#import "SDMODataCollection.h"
#import "SDMODataFunctionImport.h"
#import "TypeConverter.h"

#define ZAPP_ORDER01_SERVICE_DOCUMENT @"ZAPP_ORDER01ServiceDocument"
#define ZAPP_ORDER01_SERVICE_METADATA @"ZAPP_ORDER01ServiceMetadata"

#pragma mark - Complex Types



#pragma mark - Entity Types


#pragma mark - AZAPP_ORDER01Result
@implementation AZAPP_ORDER01Result 

@synthesize ROWID = m_ROWID;
@synthesize A0SOLD_TO = m_A0SOLD_TO;
@synthesize A0SOLD_TO_T = m_A0SOLD_TO_T;
@synthesize A0DOC_CATEG = m_A0DOC_CATEG;
@synthesize A0DOC_CATEG_T = m_A0DOC_CATEG_T;
@synthesize A006EI3ULWC7I23DQTK2PB6GHO = m_A006EI3ULWC7I23DQTK2PB6GHO;
@synthesize A006EI3ULWC7I23DQTK2PB6GHO_F = m_A006EI3ULWC7I23DQTK2PB6GHO_F;
@synthesize A006EI3ULWC7I23DS6UU6EBLKS = m_A006EI3ULWC7I23DS6UU6EBLKS;
@synthesize A006EI3ULWC7I23DS6UU6EBLKS_F = m_A006EI3ULWC7I23DS6UU6EBLKS_F;
@synthesize ISTOTAL = m_ISTOTAL;

static NSMutableDictionary *aZAPP_ORDER01ResultLabels = nil;
static SDMODataEntitySchema *aZAPP_ORDER01ResultEntitySchema = nil;

- (id)init
{
    self = [super init];
    if (self) {
        m_SDMEntry = [BaseEntityType createEmptySDMODataEntryWithSchema:aZAPP_ORDER01ResultEntitySchema error:nil];
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
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.ROWID forSDMPropertyWithName:@"ROWID" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0SOLD_TO forSDMPropertyWithName:@"A0SOLD_TO" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0SOLD_TO_T forSDMPropertyWithName:@"A0SOLD_TO_T" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0DOC_CATEG forSDMPropertyWithName:@"A0DOC_CATEG" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0DOC_CATEG_T forSDMPropertyWithName:@"A0DOC_CATEG_T" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23DQTK2PB6GHO forSDMPropertyWithName:@"A006EI3ULWC7I23DQTK2PB6GHO" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23DQTK2PB6GHO_F forSDMPropertyWithName:@"A006EI3ULWC7I23DQTK2PB6GHO_F" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23DS6UU6EBLKS forSDMPropertyWithName:@"A006EI3ULWC7I23DS6UU6EBLKS" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23DS6UU6EBLKS_F forSDMPropertyWithName:@"A006EI3ULWC7I23DS6UU6EBLKS_F" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.ISTOTAL forSDMPropertyWithName:@"ISTOTAL" error:&innerError];
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
    SDMODataCollection *collectionSchema = [aService.schema getCollectionByName:@"AZAPP_ORDER01Results" workspaceOfCollection:nil];
    aZAPP_ORDER01ResultEntitySchema = collectionSchema.entitySchema;
}

+ (void)loadLabels:(SDMODataServiceDocument *)aService
{
		NSMutableDictionary *properties = [BaseODataObject getSchemaPropertiesFromCollection:@"AZAPP_ORDER01Results" andService:aService];
    	if (properties) {    
	    	aZAPP_ORDER01ResultLabels = [NSMutableDictionary dictionary];
	    	for (SDMODataPropertyInfo *property in [properties allValues]) {
	        	[aZAPP_ORDER01ResultLabels setValue:property.label forKey:property.name];
	    	}
	    }
	    else {
        	LOGERROR(@"Failed to load SAP labels from service metadata");
    	}
}


+ (NSString *)getLabelForProperty:(NSString *)aPropertyName
{
    return [BaseODataObject getLabelFromDictionary:aZAPP_ORDER01ResultLabels forProperty:aPropertyName];
}

- (void)loadProperties
{
    [super loadProperties];
	m_ROWID = [self getStringValueForSDMPropertyWithName:@"ROWID"];
	m_A0SOLD_TO = [self getStringValueForSDMPropertyWithName:@"A0SOLD_TO"];
	m_A0SOLD_TO_T = [self getStringValueForSDMPropertyWithName:@"A0SOLD_TO_T"];
	m_A0DOC_CATEG = [self getStringValueForSDMPropertyWithName:@"A0DOC_CATEG"];
	m_A0DOC_CATEG_T = [self getStringValueForSDMPropertyWithName:@"A0DOC_CATEG_T"];
	m_A006EI3ULWC7I23DQTK2PB6GHO = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23DQTK2PB6GHO"];
	m_A006EI3ULWC7I23DQTK2PB6GHO_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23DQTK2PB6GHO_F"];
	m_A006EI3ULWC7I23DS6UU6EBLKS = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23DS6UU6EBLKS"];
	m_A006EI3ULWC7I23DS6UU6EBLKS_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23DS6UU6EBLKS_F"];
	m_ISTOTAL = [self getStringValueForSDMPropertyWithName:@"ISTOTAL"];
}

+ (NSMutableArray *)createAZAPP_ORDER01ResultEntriesForSDMEntries:(NSMutableArray *)sdmEntries
{
    NSMutableArray *entries = [NSMutableArray array];
    for (SDMODataEntry *entry in sdmEntries) {
        AZAPP_ORDER01Result *aZAPP_ORDER01ResultObject = [[AZAPP_ORDER01Result alloc] initWithSDMEntry:entry];
        [entries addObject:aZAPP_ORDER01ResultObject];
    }
    return entries;
}


+ (NSMutableArray *)parseAZAPP_ORDER01ResultEntriesWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getSDMEntriesForEntitySchema:aZAPP_ORDER01ResultEntitySchema andData:aData error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_ORDER01Result createAZAPP_ORDER01ResultEntriesForSDMEntries:sdmEntries];
}

+ (NSMutableArray *)parseExpandedAZAPP_ORDER01ResultEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_ORDER01ResultEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_ORDER01Result createAZAPP_ORDER01ResultEntriesForSDMEntries:sdmEntries];
}

+ (AZAPP_ORDER01Result *)parseAZAPP_ORDER01ResultEntryWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *aZAPP_ORDER01ResultEntries = [AZAPP_ORDER01Result parseAZAPP_ORDER01ResultEntriesWithData:aData error:error];
    if (!aZAPP_ORDER01ResultEntries) {
    	return nil;
    }
    return (AZAPP_ORDER01Result *)[AZAPP_ORDER01Result getFirstObjectFromArray:aZAPP_ORDER01ResultEntries];
}

+ (AZAPP_ORDER01Result *)parseExpandedAZAPP_ORDER01ResultEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
	NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_ORDER01ResultEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    NSMutableArray *aZAPP_ORDER01ResultEntries = [AZAPP_ORDER01Result createAZAPP_ORDER01ResultEntriesForSDMEntries:sdmEntries];
	return (AZAPP_ORDER01Result *)[AZAPP_ORDER01Result getFirstObjectFromArray:aZAPP_ORDER01ResultEntries];
}



@end

#pragma mark - AZAPP_ORDER01Parameters
@implementation AZAPP_ORDER01Parameters 

@synthesize A0S_CUSTOFrom = m_A0S_CUSTOFrom;
@synthesize A0S_CUSTOTo = m_A0S_CUSTOTo;
@synthesize A0S_CUSTOText = m_A0S_CUSTOText;
@synthesize ResultsQuery = m_ResultsQuery;
@synthesize Results = m_Results;

static NSMutableDictionary *aZAPP_ORDER01ParametersLabels = nil;
static SDMODataEntitySchema *aZAPP_ORDER01ParametersEntitySchema = nil;

- (id)init
{
    self = [super init];
    if (self) {
        m_SDMEntry = [BaseEntityType createEmptySDMODataEntryWithSchema:aZAPP_ORDER01ParametersEntitySchema error:nil];
        if (!m_SDMEntry) {
            return nil;
        }        
        m_properties = nil;
        m_baseUrl = nil;
    }
    return self;
}

- (NSMutableDictionary *)getSDMEntriesForNavigationProperties
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if ([self.Results count] > 0) {
        [dictionary setObject:[self createSDMEntriesForNavigationPropertyEntries:self.Results] forKey:@"Results"];
    }
    return dictionary;
}


- (SDMODataEntry *)buildSDMEntryFromPropertiesAndReturnError:(NSError **)error
{
    if (m_SDMEntry) {
        NSError *innerError = nil;
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0S_CUSTOFrom forSDMPropertyWithName:@"A0S_CUSTOFrom" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0S_CUSTOTo forSDMPropertyWithName:@"A0S_CUSTOTo" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0S_CUSTOText forSDMPropertyWithName:@"A0S_CUSTOText" error:&innerError];
        [self addRelativeLinksToSDMEntryFromDictionary:[self getSDMEntriesForNavigationProperties]];
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
    SDMODataCollection *collectionSchema = [aService.schema getCollectionByName:@"AZAPP_ORDER01" workspaceOfCollection:nil];
    aZAPP_ORDER01ParametersEntitySchema = collectionSchema.entitySchema;
}

+ (void)loadLabels:(SDMODataServiceDocument *)aService
{
		NSMutableDictionary *properties = [BaseODataObject getSchemaPropertiesFromCollection:@"AZAPP_ORDER01" andService:aService];
    	if (properties) {    
	    	aZAPP_ORDER01ParametersLabels = [NSMutableDictionary dictionary];
	    	for (SDMODataPropertyInfo *property in [properties allValues]) {
	        	[aZAPP_ORDER01ParametersLabels setValue:property.label forKey:property.name];
	    	}
	    }
	    else {
        	LOGERROR(@"Failed to load SAP labels from service metadata");
    	}
}


+ (NSString *)getLabelForProperty:(NSString *)aPropertyName
{
    return [BaseODataObject getLabelFromDictionary:aZAPP_ORDER01ParametersLabels forProperty:aPropertyName];
}

- (void)loadProperties
{
    [super loadProperties];
	m_A0S_CUSTOFrom = [self getStringValueForSDMPropertyWithName:@"A0S_CUSTOFrom"];
	m_A0S_CUSTOTo = [self getStringValueForSDMPropertyWithName:@"A0S_CUSTOTo"];
	m_A0S_CUSTOText = [self getStringValueForSDMPropertyWithName:@"A0S_CUSTOText"];
}

- (void)loadNavigationPropertyQueries
{
    [super loadNavigationPropertyQueries];
    m_ResultsQuery = [self getRelatedLinkForNavigationName:@"Results"];
}

- (void)loadNavigationPropertyData
{
    [super loadNavigationPropertyData];
    
    NSMutableArray *entries = nil;

    entries = [self getInlinedRelatedEntriesForNavigationName:@"Results"];
    m_Results = [AZAPP_ORDER01Result createAZAPP_ORDER01ResultEntriesForSDMEntries:entries];

}

+ (NSMutableArray *)createAZAPP_ORDER01ParametersEntriesForSDMEntries:(NSMutableArray *)sdmEntries
{
    NSMutableArray *entries = [NSMutableArray array];
    for (SDMODataEntry *entry in sdmEntries) {
        AZAPP_ORDER01Parameters *aZAPP_ORDER01ParametersObject = [[AZAPP_ORDER01Parameters alloc] initWithSDMEntry:entry];
        [entries addObject:aZAPP_ORDER01ParametersObject];
    }
    return entries;
}


+ (NSMutableArray *)parseAZAPP_ORDER01ParametersEntriesWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getSDMEntriesForEntitySchema:aZAPP_ORDER01ParametersEntitySchema andData:aData error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_ORDER01Parameters createAZAPP_ORDER01ParametersEntriesForSDMEntries:sdmEntries];
}

+ (NSMutableArray *)parseExpandedAZAPP_ORDER01ParametersEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_ORDER01ParametersEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_ORDER01Parameters createAZAPP_ORDER01ParametersEntriesForSDMEntries:sdmEntries];
}

+ (AZAPP_ORDER01Parameters *)parseAZAPP_ORDER01ParametersEntryWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *aZAPP_ORDER01ParametersEntries = [AZAPP_ORDER01Parameters parseAZAPP_ORDER01ParametersEntriesWithData:aData error:error];
    if (!aZAPP_ORDER01ParametersEntries) {
    	return nil;
    }
    return (AZAPP_ORDER01Parameters *)[AZAPP_ORDER01Parameters getFirstObjectFromArray:aZAPP_ORDER01ParametersEntries];
}

+ (AZAPP_ORDER01Parameters *)parseExpandedAZAPP_ORDER01ParametersEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
	NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_ORDER01ParametersEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    NSMutableArray *aZAPP_ORDER01ParametersEntries = [AZAPP_ORDER01Parameters createAZAPP_ORDER01ParametersEntriesForSDMEntries:sdmEntries];
	return (AZAPP_ORDER01Parameters *)[AZAPP_ORDER01Parameters getFirstObjectFromArray:aZAPP_ORDER01ParametersEntries];
}


#pragma mark Entity Navigation Property loading methods
- (BOOL)loadResultsWithData:(NSData *)aData error:(NSError **)error
{
    self.Results = [AZAPP_ORDER01Result parseAZAPP_ORDER01ResultEntriesWithData:aData error:error];
    if (!self.Results) {
    	return NO;
    }
    return YES;
}


@end


#pragma mark - ZAPP_ORDER01 Service Proxy


@implementation ZAPP_ORDER01Service

@synthesize AZAPP_ORDER01Query = m_AZAPP_ORDER01Query;
@synthesize AZAPP_ORDER01ResultsQuery = m_AZAPP_ORDER01ResultsQuery;

- (NSString *)getServiceDocumentFilename
{
	return ZAPP_ORDER01_SERVICE_DOCUMENT;
}

- (NSString *)getServiceMetadataFilename
{
	return ZAPP_ORDER01_SERVICE_METADATA;
}

- (void)loadEntitySetQueries
{
	[super loadEntitySetQueries];
    m_AZAPP_ORDER01Query = [self getQueryForRelativePath:@"AZAPP_ORDER01"];
    m_AZAPP_ORDER01ResultsQuery = [self getQueryForRelativePath:@"AZAPP_ORDER01Results"];
}

- (void)loadEntitySchemaForAllEntityTypes
{
    [super loadEntitySchemaForAllEntityTypes];
    [AZAPP_ORDER01Result loadEntitySchema:m_serviceDocument];
    [AZAPP_ORDER01Parameters loadEntitySchema:m_serviceDocument];
}

- (void)loadLabels
{
    [super loadLabels];
    [AZAPP_ORDER01Result loadLabels:m_serviceDocument];
    [AZAPP_ORDER01Parameters loadLabels:m_serviceDocument];
}

 
#pragma mark Service Entity Set methods
- (NSMutableArray *)getAZAPP_ORDER01WithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_ORDER01Parameters parseExpandedAZAPP_ORDER01ParametersEntriesWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}

- (ODataQuery *)getAZAPP_ORDER01EntryQueryWithA0S_CUSTOFrom:(NSString *)A0S_CUSTOFrom andA0S_CUSTOTo:(NSString *)A0S_CUSTOTo
{
	A0S_CUSTOFrom = [ODataQuery encodeURLParameter:A0S_CUSTOFrom];
	A0S_CUSTOTo = [ODataQuery encodeURLParameter:A0S_CUSTOTo];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_ORDER01(A0S_CUSTOFrom='%@',A0S_CUSTOTo='%@')/Results", A0S_CUSTOFrom, A0S_CUSTOTo];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (ODataQuery *)getAZAPP_ORDER01EntryQueryTypedWithA0S_CUSTOFrom:(NSString *)A0S_CUSTOFrom andA0S_CUSTOTo:(NSString *)A0S_CUSTOTo
{
	id <URITypeConverting> converter = [ODataURITypeConverter uniqueInstance];
	NSString *A0S_CUSTOFromUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:A0S_CUSTOFrom]];
	NSString *A0S_CUSTOToUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:A0S_CUSTOTo]];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_ORDER01(A0S_CUSTOFrom=%@,A0S_CUSTOTo=%@)", A0S_CUSTOFromUri, A0S_CUSTOToUri];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (AZAPP_ORDER01Parameters *)getAZAPP_ORDER01EntryWithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_ORDER01Parameters parseExpandedAZAPP_ORDER01ParametersEntryWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}

- (NSMutableArray *)getAZAPP_ORDER01ResultsWithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_ORDER01Result parseExpandedAZAPP_ORDER01ResultEntriesWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}

- (ODataQuery *)getAZAPP_ORDER01ResultsEntryQueryWithROWID:(NSString *)ROWID
{
	ROWID = [ODataQuery encodeURLParameter:ROWID];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_ORDER01Results(ROWID=%@)", ROWID];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (ODataQuery *)getAZAPP_ORDER01ResultsEntryQueryTypedWithROWID:(NSString *)ROWID
{
	id <URITypeConverting> converter = [ODataURITypeConverter uniqueInstance];
	NSString *ROWIDUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:ROWID]];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_ORDER01Results(ROWID=%@)", ROWIDUri];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (AZAPP_ORDER01Result *)getAZAPP_ORDER01ResultsEntryWithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_ORDER01Result parseExpandedAZAPP_ORDER01ResultEntryWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}



#pragma mark Service Function Import methods 

@end