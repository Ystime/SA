/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: ZAPP_AR01Service.h
 Abstract: The generated proxy classes for the ZAPP_AR01 Service. Service Version: 1.  
*/

#import "ZAPP_AR01Service.h"
#import "BaseODataObject.h"
#import "Logger.h"
#import "SDMODataEntitySchema.h"
#import "SDMODataCollection.h"
#import "SDMODataFunctionImport.h"
#import "TypeConverter.h"

#define ZAPP_AR01_SERVICE_DOCUMENT @"ZAPP_AR01ServiceDocument"
#define ZAPP_AR01_SERVICE_METADATA @"ZAPP_AR01ServiceMetadata"

#pragma mark - Complex Types



#pragma mark - Entity Types


#pragma mark - AZAPP_AR01Result
@implementation AZAPP_AR01Result 

@synthesize ROWID = m_ROWID;
@synthesize A0DEBITOR = m_A0DEBITOR;
@synthesize A0DEBITOR_T = m_A0DEBITOR_T;
@synthesize A006EI3ULWC7I23F67E6D3RU2K = m_A006EI3ULWC7I23F67E6D3RU2K;
@synthesize A006EI3ULWC7I23F67E6D3RU2K_F = m_A006EI3ULWC7I23F67E6D3RU2K_F;
@synthesize A006EI3ULWC7I23F67E6D3SD18 = m_A006EI3ULWC7I23F67E6D3SD18;
@synthesize A006EI3ULWC7I23F67E6D3SD18_F = m_A006EI3ULWC7I23F67E6D3SD18_F;
@synthesize A006EI3ULWC7I23F67E6D3SVZW = m_A006EI3ULWC7I23F67E6D3SVZW;
@synthesize A006EI3ULWC7I23F67E6D3SVZW_F = m_A006EI3ULWC7I23F67E6D3SVZW_F;
@synthesize A006EI3ULWC7I23F67E6D3TEYK = m_A006EI3ULWC7I23F67E6D3TEYK;
@synthesize A006EI3ULWC7I23F67E6D3TEYK_F = m_A006EI3ULWC7I23F67E6D3TEYK_F;
@synthesize A006EI3ULWC7I23F67E6D3TXX8 = m_A006EI3ULWC7I23F67E6D3TXX8;
@synthesize A006EI3ULWC7I23F67E6D3TXX8_F = m_A006EI3ULWC7I23F67E6D3TXX8_F;
@synthesize A006EI3ULWC7I23F67E6D3UGVW = m_A006EI3ULWC7I23F67E6D3UGVW;
@synthesize A006EI3ULWC7I23F67E6D3UGVW_F = m_A006EI3ULWC7I23F67E6D3UGVW_F;
@synthesize A006EI3ULWC7I23F67E6D3UZUK = m_A006EI3ULWC7I23F67E6D3UZUK;
@synthesize A006EI3ULWC7I23F67E6D3UZUK_F = m_A006EI3ULWC7I23F67E6D3UZUK_F;
@synthesize ISTOTAL = m_ISTOTAL;

static NSMutableDictionary *aZAPP_AR01ResultLabels = nil;
static SDMODataEntitySchema *aZAPP_AR01ResultEntitySchema = nil;

- (id)init
{
    self = [super init];
    if (self) {
        m_SDMEntry = [BaseEntityType createEmptySDMODataEntryWithSchema:aZAPP_AR01ResultEntitySchema error:nil];
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
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0DEBITOR forSDMPropertyWithName:@"A0DEBITOR" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0DEBITOR_T forSDMPropertyWithName:@"A0DEBITOR_T" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3RU2K forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3RU2K" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3RU2K_F forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3RU2K_F" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3SD18 forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SD18" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3SD18_F forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SD18_F" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3SVZW forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SVZW" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3SVZW_F forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SVZW_F" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3TEYK forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TEYK" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3TEYK_F forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TEYK_F" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3TXX8 forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TXX8" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3TXX8_F forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TXX8_F" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3UGVW forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UGVW" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3UGVW_F forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UGVW_F" error:&innerError];
    	[BaseODataObject setDecimalValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3UZUK forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UZUK" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A006EI3ULWC7I23F67E6D3UZUK_F forSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UZUK_F" error:&innerError];
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
    SDMODataCollection *collectionSchema = [aService.schema getCollectionByName:@"AZAPP_AR01Results" workspaceOfCollection:nil];
    aZAPP_AR01ResultEntitySchema = collectionSchema.entitySchema;
}

+ (void)loadLabels:(SDMODataServiceDocument *)aService
{
		NSMutableDictionary *properties = [BaseODataObject getSchemaPropertiesFromCollection:@"AZAPP_AR01Results" andService:aService];
    	if (properties) {    
	    	aZAPP_AR01ResultLabels = [NSMutableDictionary dictionary];
	    	for (SDMODataPropertyInfo *property in [properties allValues]) {
	        	[aZAPP_AR01ResultLabels setValue:property.label forKey:property.name];
	    	}
	    }
	    else {
        	LOGERROR(@"Failed to load SAP labels from service metadata");
    	}
}


+ (NSString *)getLabelForProperty:(NSString *)aPropertyName
{
    return [BaseODataObject getLabelFromDictionary:aZAPP_AR01ResultLabels forProperty:aPropertyName];
}

- (void)loadProperties
{
    [super loadProperties];
	m_ROWID = [self getStringValueForSDMPropertyWithName:@"ROWID"];
	m_A0DEBITOR = [self getStringValueForSDMPropertyWithName:@"A0DEBITOR"];
	m_A0DEBITOR_T = [self getStringValueForSDMPropertyWithName:@"A0DEBITOR_T"];
	m_A006EI3ULWC7I23F67E6D3RU2K = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3RU2K"];
	m_A006EI3ULWC7I23F67E6D3RU2K_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3RU2K_F"];
	m_A006EI3ULWC7I23F67E6D3SD18 = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SD18"];
	m_A006EI3ULWC7I23F67E6D3SD18_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SD18_F"];
	m_A006EI3ULWC7I23F67E6D3SVZW = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SVZW"];
	m_A006EI3ULWC7I23F67E6D3SVZW_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3SVZW_F"];
	m_A006EI3ULWC7I23F67E6D3TEYK = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TEYK"];
	m_A006EI3ULWC7I23F67E6D3TEYK_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TEYK_F"];
	m_A006EI3ULWC7I23F67E6D3TXX8 = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TXX8"];
	m_A006EI3ULWC7I23F67E6D3TXX8_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3TXX8_F"];
	m_A006EI3ULWC7I23F67E6D3UGVW = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UGVW"];
	m_A006EI3ULWC7I23F67E6D3UGVW_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UGVW_F"];
	m_A006EI3ULWC7I23F67E6D3UZUK = [self getDecimalValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UZUK"];
	m_A006EI3ULWC7I23F67E6D3UZUK_F = [self getStringValueForSDMPropertyWithName:@"A006EI3ULWC7I23F67E6D3UZUK_F"];
	m_ISTOTAL = [self getStringValueForSDMPropertyWithName:@"ISTOTAL"];
}

+ (NSMutableArray *)createAZAPP_AR01ResultEntriesForSDMEntries:(NSMutableArray *)sdmEntries
{
    NSMutableArray *entries = [NSMutableArray array];
    for (SDMODataEntry *entry in sdmEntries) {
        AZAPP_AR01Result *aZAPP_AR01ResultObject = [[AZAPP_AR01Result alloc] initWithSDMEntry:entry];
        [entries addObject:aZAPP_AR01ResultObject];
    }
    return entries;
}


+ (NSMutableArray *)parseAZAPP_AR01ResultEntriesWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getSDMEntriesForEntitySchema:aZAPP_AR01ResultEntitySchema andData:aData error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_AR01Result createAZAPP_AR01ResultEntriesForSDMEntries:sdmEntries];
}

+ (NSMutableArray *)parseExpandedAZAPP_AR01ResultEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_AR01ResultEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_AR01Result createAZAPP_AR01ResultEntriesForSDMEntries:sdmEntries];
}

+ (AZAPP_AR01Result *)parseAZAPP_AR01ResultEntryWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *aZAPP_AR01ResultEntries = [AZAPP_AR01Result parseAZAPP_AR01ResultEntriesWithData:aData error:error];
    if (!aZAPP_AR01ResultEntries) {
    	return nil;
    }
    return (AZAPP_AR01Result *)[AZAPP_AR01Result getFirstObjectFromArray:aZAPP_AR01ResultEntries];
}

+ (AZAPP_AR01Result *)parseExpandedAZAPP_AR01ResultEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
	NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_AR01ResultEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    NSMutableArray *aZAPP_AR01ResultEntries = [AZAPP_AR01Result createAZAPP_AR01ResultEntriesForSDMEntries:sdmEntries];
	return (AZAPP_AR01Result *)[AZAPP_AR01Result getFirstObjectFromArray:aZAPP_AR01ResultEntries];
}



@end

#pragma mark - AZAPP_AR01Parameters
@implementation AZAPP_AR01Parameters 

@synthesize A0P_COCD = m_A0P_COCD;
@synthesize A0P_COCDText = m_A0P_COCDText;
@synthesize A0S_DEBITFrom = m_A0S_DEBITFrom;
@synthesize A0S_DEBITTo = m_A0S_DEBITTo;
@synthesize A0S_DEBITText = m_A0S_DEBITText;
@synthesize A0P_KEYDT = m_A0P_KEYDT;
@synthesize A0P_KEYDTText = m_A0P_KEYDTText;
@synthesize ResultsQuery = m_ResultsQuery;
@synthesize Results = m_Results;

static NSMutableDictionary *aZAPP_AR01ParametersLabels = nil;
static SDMODataEntitySchema *aZAPP_AR01ParametersEntitySchema = nil;

- (id)init
{
    self = [super init];
    if (self) {
        m_SDMEntry = [BaseEntityType createEmptySDMODataEntryWithSchema:aZAPP_AR01ParametersEntitySchema error:nil];
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
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0P_COCD forSDMPropertyWithName:@"A0P_COCD" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0P_COCDText forSDMPropertyWithName:@"A0P_COCDText" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0S_DEBITFrom forSDMPropertyWithName:@"A0S_DEBITFrom" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0S_DEBITTo forSDMPropertyWithName:@"A0S_DEBITTo" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0S_DEBITText forSDMPropertyWithName:@"A0S_DEBITText" error:&innerError];
    	[BaseODataObject setDoubleValueForSDMEntry:m_SDMEntry withValue:self.A0P_KEYDT forSDMPropertyWithName:@"A0P_KEYDT" error:&innerError];
    	[BaseODataObject setStringValueForSDMEntry:m_SDMEntry withValue:self.A0P_KEYDTText forSDMPropertyWithName:@"A0P_KEYDTText" error:&innerError];
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
    SDMODataCollection *collectionSchema = [aService.schema getCollectionByName:@"AZAPP_AR01" workspaceOfCollection:nil];
    aZAPP_AR01ParametersEntitySchema = collectionSchema.entitySchema;
}

+ (void)loadLabels:(SDMODataServiceDocument *)aService
{
		NSMutableDictionary *properties = [BaseODataObject getSchemaPropertiesFromCollection:@"AZAPP_AR01" andService:aService];
    	if (properties) {    
	    	aZAPP_AR01ParametersLabels = [NSMutableDictionary dictionary];
	    	for (SDMODataPropertyInfo *property in [properties allValues]) {
	        	[aZAPP_AR01ParametersLabels setValue:property.label forKey:property.name];
	    	}
	    }
	    else {
        	LOGERROR(@"Failed to load SAP labels from service metadata");
    	}
}


+ (NSString *)getLabelForProperty:(NSString *)aPropertyName
{
    return [BaseODataObject getLabelFromDictionary:aZAPP_AR01ParametersLabels forProperty:aPropertyName];
}

- (void)loadProperties
{
    [super loadProperties];
	m_A0P_COCD = [self getStringValueForSDMPropertyWithName:@"A0P_COCD"];
	m_A0P_COCDText = [self getStringValueForSDMPropertyWithName:@"A0P_COCDText"];
	m_A0S_DEBITFrom = [self getStringValueForSDMPropertyWithName:@"A0S_DEBITFrom"];
	m_A0S_DEBITTo = [self getStringValueForSDMPropertyWithName:@"A0S_DEBITTo"];
	m_A0S_DEBITText = [self getStringValueForSDMPropertyWithName:@"A0S_DEBITText"];
	m_A0P_KEYDT = [self getDoubleValueForSDMPropertyWithName:@"A0P_KEYDT"];
	m_A0P_KEYDTText = [self getStringValueForSDMPropertyWithName:@"A0P_KEYDTText"];
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
    m_Results = [AZAPP_AR01Result createAZAPP_AR01ResultEntriesForSDMEntries:entries];

}

+ (NSMutableArray *)createAZAPP_AR01ParametersEntriesForSDMEntries:(NSMutableArray *)sdmEntries
{
    NSMutableArray *entries = [NSMutableArray array];
    for (SDMODataEntry *entry in sdmEntries) {
        AZAPP_AR01Parameters *aZAPP_AR01ParametersObject = [[AZAPP_AR01Parameters alloc] initWithSDMEntry:entry];
        [entries addObject:aZAPP_AR01ParametersObject];
    }
    return entries;
}


+ (NSMutableArray *)parseAZAPP_AR01ParametersEntriesWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getSDMEntriesForEntitySchema:aZAPP_AR01ParametersEntitySchema andData:aData error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_AR01Parameters createAZAPP_AR01ParametersEntriesForSDMEntries:sdmEntries];
}

+ (NSMutableArray *)parseExpandedAZAPP_AR01ParametersEntriesWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
    NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_AR01ParametersEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    if (!sdmEntries) {
    	return nil;
    }
	return [AZAPP_AR01Parameters createAZAPP_AR01ParametersEntriesForSDMEntries:sdmEntries];
}

+ (AZAPP_AR01Parameters *)parseAZAPP_AR01ParametersEntryWithData:(NSData *)aData error:(NSError **)error
{
    NSMutableArray *aZAPP_AR01ParametersEntries = [AZAPP_AR01Parameters parseAZAPP_AR01ParametersEntriesWithData:aData error:error];
    if (!aZAPP_AR01ParametersEntries) {
    	return nil;
    }
    return (AZAPP_AR01Parameters *)[AZAPP_AR01Parameters getFirstObjectFromArray:aZAPP_AR01ParametersEntries];
}

+ (AZAPP_AR01Parameters *)parseExpandedAZAPP_AR01ParametersEntryWithData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError **)error
{
	NSMutableArray *sdmEntries = [BaseEntityType getExpandedSDMEntriesForEntitySchema:aZAPP_AR01ParametersEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
    NSMutableArray *aZAPP_AR01ParametersEntries = [AZAPP_AR01Parameters createAZAPP_AR01ParametersEntriesForSDMEntries:sdmEntries];
	return (AZAPP_AR01Parameters *)[AZAPP_AR01Parameters getFirstObjectFromArray:aZAPP_AR01ParametersEntries];
}


#pragma mark Entity Navigation Property loading methods
- (BOOL)loadResultsWithData:(NSData *)aData error:(NSError **)error
{
    self.Results = [AZAPP_AR01Result parseAZAPP_AR01ResultEntriesWithData:aData error:error];
    if (!self.Results) {
    	return NO;
    }
    return YES;
}


@end


#pragma mark - ZAPP_AR01 Service Proxy


@implementation ZAPP_AR01Service

@synthesize AZAPP_AR01Query = m_AZAPP_AR01Query;
@synthesize AZAPP_AR01ResultsQuery = m_AZAPP_AR01ResultsQuery;

- (NSString *)getServiceDocumentFilename
{
	return ZAPP_AR01_SERVICE_DOCUMENT;
}

- (NSString *)getServiceMetadataFilename
{
	return ZAPP_AR01_SERVICE_METADATA;
}

- (void)loadEntitySetQueries
{
	[super loadEntitySetQueries];
    m_AZAPP_AR01Query = [self getQueryForRelativePath:@"AZAPP_AR01"];
    m_AZAPP_AR01ResultsQuery = [self getQueryForRelativePath:@"AZAPP_AR01Results"];
}

- (void)loadEntitySchemaForAllEntityTypes
{
    [super loadEntitySchemaForAllEntityTypes];
    [AZAPP_AR01Result loadEntitySchema:m_serviceDocument];
    [AZAPP_AR01Parameters loadEntitySchema:m_serviceDocument];
}

- (void)loadLabels
{
    [super loadLabels];
    [AZAPP_AR01Result loadLabels:m_serviceDocument];
    [AZAPP_AR01Parameters loadLabels:m_serviceDocument];
}

 
#pragma mark Service Entity Set methods
- (NSMutableArray *)getAZAPP_AR01WithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_AR01Parameters parseExpandedAZAPP_AR01ParametersEntriesWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}

- (ODataQuery *)getAZAPP_AR01EntryQueryWithA0P_COCD:(NSString *)A0P_COCD andA0S_DEBITFrom:(NSString *)A0S_DEBITFrom andA0S_DEBITTo:(NSString *)A0S_DEBITTo andA0P_KEYDT:(NSString *)A0P_KEYDT
{
	A0P_COCD = [ODataQuery encodeURLParameter:A0P_COCD];
	A0S_DEBITFrom = [ODataQuery encodeURLParameter:A0S_DEBITFrom];
	A0S_DEBITTo = [ODataQuery encodeURLParameter:A0S_DEBITTo];
	A0P_KEYDT = [ODataQuery encodeURLParameter:A0P_KEYDT];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_AR01(A0P_COCD=%@,A0S_DEBITFrom=%@,A0S_DEBITTo=%@,A0P_KEYDT=%@)", A0P_COCD, A0S_DEBITFrom, A0S_DEBITTo, A0P_KEYDT];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (ODataQuery *)getAZAPP_AR01EntryQueryTypedWithA0P_COCD:(NSString *)A0P_COCD andA0S_DEBITFrom:(NSString *)A0S_DEBITFrom andA0S_DEBITTo:(NSString *)A0S_DEBITTo andA0P_KEYDT:(NSNumber *)A0P_KEYDT
{
	id <URITypeConverting> converter = [ODataURITypeConverter uniqueInstance];
	NSString *A0P_COCDUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:A0P_COCD]];
	NSString *A0S_DEBITFromUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:A0S_DEBITFrom]];
	NSString *A0S_DEBITToUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:A0S_DEBITTo]];
	NSString *A0P_KEYDTUri = [ODataQuery encodeURLParameter:[converter convertToEdmDoubleURI:A0P_KEYDT]];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_AR01(A0P_COCD=%@,A0S_DEBITFrom=%@,A0S_DEBITTo=%@,A0P_KEYDT=%@)", A0P_COCDUri, A0S_DEBITFromUri, A0S_DEBITToUri, A0P_KEYDTUri];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (AZAPP_AR01Parameters *)getAZAPP_AR01EntryWithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_AR01Parameters parseExpandedAZAPP_AR01ParametersEntryWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}

- (NSMutableArray *)getAZAPP_AR01ResultsWithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_AR01Result parseExpandedAZAPP_AR01ResultEntriesWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}

- (ODataQuery *)getAZAPP_AR01ResultsEntryQueryWithROWID:(NSString *)ROWID
{
	ROWID = [ODataQuery encodeURLParameter:ROWID];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_AR01Results(ROWID=%@)", ROWID];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (ODataQuery *)getAZAPP_AR01ResultsEntryQueryTypedWithROWID:(NSString *)ROWID
{
	id <URITypeConverting> converter = [ODataURITypeConverter uniqueInstance];
	NSString *ROWIDUri = [ODataQuery encodeURLParameter:[converter convertToEdmStringURI:ROWID]];
	NSString *relativePath = [NSString stringWithFormat:@"AZAPP_AR01Results(ROWID=%@)", ROWIDUri];
	ODataQuery *query = [self getQueryForRelativePath:relativePath];
	return query;
}

- (AZAPP_AR01Result *)getAZAPP_AR01ResultsEntryWithData:(NSData *)aData error:(NSError **)error
{
	return [AZAPP_AR01Result parseExpandedAZAPP_AR01ResultEntryWithData:aData andServiceDocument:self.sdmServiceDocument error:error];
}



#pragma mark Service Function Import methods 

@end
