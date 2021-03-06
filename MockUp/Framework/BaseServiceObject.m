/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: BaseServiceObject.m
 Abstract: The base class for the generated OData service class.
 
 
*/

#import "BaseServiceObject.h"
#import "SDMODataServiceDocumentParser.h"
#import "SDMODataMetaDocumentParser.h"
#import "SDMODataCollection.h"
#import "SDMODataLink.h"
#import "SDMODataDataParser.h"
#import "SDMODataFunctionImport.h"
#import "SDMFunctionImportResultParser.h"
#import "Logger.h"
#import "SDMODataXMLBuilder.h"
#import "SDMParserException.h"
#import "ErrorHandling.h"

#define DEFAULT_SERVICE_DOCUMENT @"ServiceDocument"
#define DEFAULT_SERVICE_METADATA @"ServiceMetadata"


@implementation BaseServiceObject
@synthesize sdmServiceDocument = m_serviceDocument;

- (id)init
{
    NSString *serviceDocPath = [[NSBundle mainBundle] pathForResource:[self getServiceDocumentFilename] ofType:@"xml"];
    NSString *serviceMetadataPath = [[NSBundle mainBundle] pathForResource:[self getServiceMetadataFilename] ofType:@"xml"];
    
    NSData *serviceDocData = [NSData dataWithContentsOfFile:serviceDocPath];
    NSData *serviceMetadataData = [NSData dataWithContentsOfFile:serviceMetadataPath];
    
    return [self initWithServiceDocument:serviceDocData andMedatadata:serviceMetadataData];
}

- (id)initWithServiceDocument:(NSData *)aServiceDocument andMedatadata:(NSData *)aMetadata
{
    if(self = [super init]){
#ifdef DEBUG
        [Logger enableSDMDetailedLogging];
#endif
        @try {
            SDMODataServiceDocumentParser *sdmDocParser = [[SDMODataServiceDocumentParser alloc] init];
            [sdmDocParser parse:aServiceDocument];
            m_serviceDocument = sdmDocParser.serviceDocument;
            
            //Load the object with metadata xml:
            SDMODataMetaDocumentParser *sdmMetadataParser = [[SDMODataMetaDocumentParser alloc] initWithServiceDocument:m_serviceDocument];
            [sdmMetadataParser parse:aMetadata];
        }
        @catch(SDMParserException *e) {
            NSString *exceptionMessage = e.detailedError ? e.detailedError : [e description];
            NSString *errorMessage = [NSString stringWithFormat:@"Exception during parsing Service Document or Metadata: %@", exceptionMessage];
            LOGERROR(errorMessage);
            return nil;
        }
    }
    
    [self loadEntitySetQueries];
    [self loadLabels];
    [self loadEntitySchemaForAllEntityTypes];
    
    return self;
}

- (NSString *)getServiceDocumentFilename
{
    return DEFAULT_SERVICE_DOCUMENT;
}

- (NSString *)getServiceMetadataFilename
{
    return DEFAULT_SERVICE_METADATA;
}

- (void)setServiceDocumentUrl:(NSString *)baseUrl
{
    m_serviceDocument.baseUrl = baseUrl;
    [self loadEntitySetQueries];
}

- (ODataQuery *)getServiceDocumentQuery
{
    return [self getQueryForRelativePath:@""];
}

- (void)loadEntitySetQueries
{
    
}

- (void)loadEntitySchemaForAllEntityTypes
{
    
}

-(void)loadLabels
{
    
}

- (ODataQuery *)getQueryForRelativePath:(NSString *)aRelativeResourcePath
{
    NSMutableString *absoluteUrl = [NSMutableString stringWithString:m_serviceDocument.baseUrl];
	if (![absoluteUrl hasSuffix:@"/"]) {
        [absoluteUrl appendString:@"/"];
    }
    [absoluteUrl appendString:aRelativeResourcePath];
    NSString *encodedAbsoluteUrl = [ODataQuery encodeURLLoosely:absoluteUrl];
    return [[ODataQuery alloc] initWithURL:[NSURL URLWithString:encodedAbsoluteUrl]];
}

- (BaseODataObject *)getFirstObjectFromArray:(NSArray *)array
{
	if (array.count > 0) {
		return [array objectAtIndex:0];
	}
	return nil;
}

- (NSMutableArray *)getSDMEntriesForFunctionImportName:(NSString *)aFunctionImportName andData:(NSData *)aData error:(NSError * __autoreleasing *)error
{
    NSMutableArray *sdmEntries = nil;
    if (aData) {
        @try {
            SDMODataFunctionImport *functionImport = [[m_serviceDocument getFunctionImports] objectForKey:aFunctionImportName];
            if (functionImport) {
                SDMFunctionImportResultParser *parser = [[SDMFunctionImportResultParser alloc] initWithFunctionImport:functionImport];
                [parser parse:aData];
                sdmEntries = parser.entries;
                if (!sdmEntries) {
                    sdmEntries = [NSMutableArray array];
                    NSString *noticeMessage = [NSString stringWithFormat:@"The response contains no entries"];
                    LOGNOTICE(noticeMessage);
#ifdef DEBUG
                    NSString *responseString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
                    LOGNOTICE(responseString);
#endif
                }
            }
            else {
            	NSString *localizedMessage = NSLocalizedString(@"FunctionImport %@ not found in the service metadata", @"FunctionImport %@ not found in the service metadata");
                NSString *errorMessage = [NSString stringWithFormat:localizedMessage, aFunctionImportName];
                LOGERROR(errorMessage);
                if (error) {
                    *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:SCHEMA_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
                }
            }
        }
        @catch(SDMParserException *e) {
            NSString *exceptionMessage = e.detailedError ? e.detailedError : [e description];
            NSString *localizedMessage = NSLocalizedString(@"Exception during parsing response data. Error: %@", @"Exception during parsing response data. Error: %@");
            NSString *errorMessage = [NSString stringWithFormat:localizedMessage, exceptionMessage];
            LOGERROR(errorMessage);
            if (error) {
                *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:RESPONSE_PARSER_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
            }
#ifdef DEBUG
            NSString *responseString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
            LOGERROR(responseString);
#endif
        }
    }
    return sdmEntries;
}


- (SDMODataPropertyValueObject *)getSDMPropertyEDMValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    return [[anEntry getFields] objectForKey:@"element"];
}

- (NSString *)getStringValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueString *SDMValue = (SDMODataPropertyValueString *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getValue];
}


- (NSDate *)getDateTimeValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueDateTime *SDMValue = (SDMODataPropertyValueDateTime *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getDateValue];
}


- (NSDecimalNumber *)getDecimalValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueDecimal *SDMValue = (SDMODataPropertyValueDecimal *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getDecimalValue];
}


- (NSNumber *)getIntValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueInt *SDMValue = (SDMODataPropertyValueInt *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getIntValue];
}


- (NSNumber *)getBooleanValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueBoolean *SDMValue = (SDMODataPropertyValueBoolean *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getBooleanValue];
}


- (NSNumber *)getSingleValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueSingle *SDMValue = (SDMODataPropertyValueSingle *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getSingleValue];   
}

- (NSNumber *)getDoubleValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueDouble *SDMValue = (SDMODataPropertyValueDouble *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getDoubleValue];
}


- (NSString *)getGuidValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueGuid *SDMValue = (SDMODataPropertyValueGuid *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getValue];
}


- (NSString *)getDateTimeOffsetValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueDateTimeOffset *SDMValue = (SDMODataPropertyValueDateTimeOffset *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getValue];
}


- (NSMutableData *)getBinaryValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueBinary *SDMValue = (SDMODataPropertyValueBinary *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getBinaryData];
}


- (SDMDuration *)getTimeValueForFunctionImportSDMEntry:(SDMODataEntry *)anEntry
{
    SDMODataPropertyValueTime *SDMValue = (SDMODataPropertyValueTime *)[self getSDMPropertyEDMValueForFunctionImportSDMEntry:anEntry];
    return [SDMValue getTimeValue];   
}

- (NSString *)getXMLFromEntity:(BaseEntityType *)anEntity andOperation:(const enum TEN_ENTRY_OPERATIONS) operation error:(NSError * __autoreleasing *)error
{
    SDMODataEntry *newEntry = [anEntity buildSDMEntryFromPropertiesAndReturnError:error];
    
    // if an error occured while constructing the SDMODataEntry, return nil
    if (!newEntry) {
        return nil;
    }
    if ([newEntry isValid]) {
        SDMODataEntryXML *entryXml = nil;
        @try {
            entryXml = sdmBuildODataEntryXML(newEntry, operation, m_serviceDocument, YES);
#ifdef DEBUG
            NSString *noticeMsg = [NSString stringWithFormat:@"xml:\n %@\nmethod: %@", entryXml.xml, entryXml.method];
            LOGNOTICE(noticeMsg);
#endif
            return [entryXml xml];
        }
        @catch (SDMParserException *e) {
        	NSString *localizedMessage = NSLocalizedString(@"Exception during building entry xml: %@", @"Exception during building entry xml: %@");
            NSString *exceptionMsg = [NSString stringWithFormat:localizedMessage, e.detailedError];
            LOGERROR(exceptionMsg);
            if (error) {
                *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:SDM_ENTRY_XML_BUILDER_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:exceptionMsg forKey:NSLocalizedDescriptionKey]];
            }
        }
    }
    else {
        NSString *errorMsg = @"The entry is not a valid entry";
        LOGERROR(errorMsg);
        if (error) {
            *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:SDM_ENTRY_INVALID_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMsg forKey:NSLocalizedDescriptionKey]];
        }
        
    }
    return nil;
}

- (NSString *)getXMLForCreateRequest:(BaseEntityType *)anEntity error:(NSError * __autoreleasing *)error
{
    return [self getXMLFromEntity:anEntity andOperation:ENTRY_OPERATION_CREATE error:error];
}

- (NSString *)getXMLForUpdateRequest:(BaseEntityType *)anEntity error:(NSError * __autoreleasing *)error
{
    return [self getXMLFromEntity:anEntity andOperation:ENTRY_OPERATION_UPDATE_FULL error:error];
}

@end
