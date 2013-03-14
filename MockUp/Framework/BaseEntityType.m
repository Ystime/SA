/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: BaseEntityType.m
 Abstract: The base class for all OData entities. Inherits from BaseODataObject.
 
 
 */

#import "BaseEntityType.h"
#import "SDMODataDataParser.h"
#import "SDMParserException.h"
#import "Logger.h"
#import "ErrorHandling.h"

@implementation BaseEntityType

@synthesize baseUrl = m_baseUrl;

- (id)initWithSDMEntry:(SDMODataEntry *)aSDMEntry
{
    self = [super initWithSDMDictionary:aSDMEntry.fields];
    if (self) {
        m_SDMEntry = aSDMEntry;
        m_baseUrl = [NSURL URLWithString:aSDMEntry.entryID];
        [self loadNavigationPropertyQueries];
        [self loadNavigationPropertyData];
        [self loadMediaLinkProperties];
    }
    return self;
}

- (SDMODataEntry *)buildSDMEntryFromPropertiesAndReturnError:(NSError * __autoreleasing *)error;
{
    return nil;
}

- (ODataQuery *)getRelatedLinkForNavigationName:(NSString *)aNavigationName
{
    const SDMODataRelatedLink *relatedLink = [m_SDMEntry getRelatedLinkByNavigationPropertyName:aNavigationName];
    return [[ODataQuery alloc] initWithURL:[NSURL URLWithString:relatedLink.href]];
}

- (NSMutableArray *)getInlinedRelatedEntriesForNavigationName:(NSString *)aNavigationName
{
    const SDMODataRelatedLink *relatedLink = [m_SDMEntry getRelatedLinkByNavigationPropertyName:aNavigationName];
    return [NSMutableArray arrayWithArray:[m_SDMEntry getInlinedRelatedEntriesForRelatedLink:relatedLink.href]];
}

- (NSString *)getTargetCollectionFromNavigationProperty:(NSString *)aNavigationProperty
{
    const SDMODataRelatedLink *relativeLink = [m_SDMEntry getRelatedLinkByNavigationPropertyName:aNavigationProperty];
    return relativeLink.targetCollection;
}

- (void)loadNavigationPropertyQueries
{
    
}

- (void)loadNavigationPropertyData
{
    
}

- (void)loadMediaLinkProperties
{
	
}

- (void)addRelativeLinksToSDMEntryFromDictionary:(NSMutableDictionary *)aDictionary
{
    NSString *relLinkBaseUrl = @"http://schemas.microsoft.com/ado/2007/08/dataservices/related/";
    NSMutableDictionary *allRelativeLinks = [NSMutableDictionary dictionary];
    // Iterate all key-values in the dictionary and for each add a relative link to the SDMODataEntry object
    for (NSString *key in [aDictionary allKeys]) {
        NSArray *inlinedSDMEntriesArray = [aDictionary objectForKey:key];
        if ([inlinedSDMEntriesArray count] > 0) {
            NSString *relLinkUrl = [relLinkBaseUrl stringByAppendingString:key];
            // add links
            SDMODataRelatedLink *link = [[SDMODataRelatedLink alloc] initWithHRef:relLinkUrl 
                                                                       andLinkRel:relLinkUrl 
                                                                      andLinkType:@"application/atom+xml;type=feed" 
                                                                     andLinkTitle:key];
            // add sdmEntries to dictionary
            [m_SDMEntry addLink:link];
            [allRelativeLinks setValue:inlinedSDMEntriesArray forKey:relLinkUrl];
        }
    }
    
    if ([allRelativeLinks count] > 0) {
        [m_SDMEntry setInlinedRelatedEntries:allRelativeLinks];
    }
}

- (MediaLink *)getFirstMediaLinkFromArray:(NSArray *)mediaLinks
{
	if (mediaLinks.count > 0) {
		SDMODataMediaResourceLink *mediaLink = [mediaLinks objectAtIndex:0];
        ODataQuery *mediaLinkQuery = [[ODataQuery alloc] initWithURL:[NSURL URLWithString:mediaLink.href]];
		MediaLink *link = [[MediaLink alloc] initWithQuery:mediaLinkQuery andContentType:mediaLink.type];
		return link;
	}
	else {
		return nil;
	}
}

- (NSMutableArray *)createSDMEntriesForNavigationPropertyEntries:(NSArray *)anEntriesArray
{
    NSMutableArray *entries = [NSMutableArray array];
    for (BaseEntityType *anEntry in anEntriesArray) {
        SDMODataEntry *entry = [anEntry buildSDMEntryFromPropertiesAndReturnError:nil];
        if (entry) {
            [entries addObject:entry];
        }
    }
    return entries;
}

- (MediaLink *)getMediaLinkForReading
{
	return [self getFirstMediaLinkFromArray:[m_SDMEntry getMediaLinksForReading]];
}

- (MediaLink *)getMediaLinkForEditing
{
	return [self getFirstMediaLinkFromArray:[m_SDMEntry getMediaLinksForEditing]];
}

+ (NSMutableArray *)getSDMEntriesForEntitySchema:(SDMODataEntitySchema *)anEntitySchema andData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error
{
    NSMutableArray *sdmEntries = nil;
    if (aData) {
        @try {
            if (anEntitySchema) {
                SDMODataDataParser *dataParser = [[SDMODataDataParser alloc] initWithEntitySchema:anEntitySchema andServiceDocument:aServiceDocument];
                [dataParser parse:aData];
                sdmEntries = dataParser.entries;
                if (!sdmEntries) {
                    sdmEntries = [NSMutableArray array];
                    NSString *noticeMessage = NSLocalizedString(@"The response contains no entries", @"The response contains no entries");
                    LOGNOTICE(noticeMessage);
#ifdef DEBUG
                    NSString *responseString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
                    LOGNOTICE(responseString);
#endif
                }
            }
            else {
                NSString *errorMessage = NSLocalizedString(@"EntitySchema object must not be nil", @"EntitySchema object must not be nil");
                LOGERROR(errorMessage);
                if (error) {
                    *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:SCHEMA_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
                }
            }
        }
        @catch(SDMParserException *e) {
            NSString *exceptionMessage = e.detailedError ? e.detailedError : [e description];
            NSString *localizedMessage = NSLocalizedString(@"Exception during parsing response data. Error:", @"Exception during parsing response data. Error:");
            NSString *errorMessage = [NSString stringWithFormat:@"%@ %@", localizedMessage, exceptionMessage];
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
    else {
        LOGERROR(@"Response data is nil");
        if (error) {
            *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:RESPONSE_PARSER_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"Empty response data", @"Empty response data") forKey:NSLocalizedDescriptionKey]];
        }
    }
    return sdmEntries;
}

+ (NSMutableArray *)getSDMEntriesForEntitySchema:(SDMODataEntitySchema *)anEntitySchema andData:(NSData *)aData error:(NSError * __autoreleasing *)error
{
    return [BaseEntityType getSDMEntriesForEntitySchema:anEntitySchema andData:aData andServiceDocument:nil error:error];
}

+ (NSMutableArray *)getExpandedSDMEntriesForEntitySchema:(SDMODataEntitySchema *)anEntitySchema andData:(NSData *)aData andServiceDocument:(SDMODataServiceDocument *)aServiceDocument error:(NSError * __autoreleasing *)error
{
    return [BaseEntityType getSDMEntriesForEntitySchema:anEntitySchema andData:aData andServiceDocument:aServiceDocument error:error];
}


+ (BaseODataObject *)getFirstObjectFromArray:(NSArray *)array
{
    if (array.count > 0) {
		return [array objectAtIndex:0];
	}
	return nil;
    
}

+ (SDMODataEntry *)createEmptySDMODataEntryWithSchema:(SDMODataEntitySchema *)aSchema error:(NSError * __autoreleasing *)error
{
    if (aSchema) {
        return [[SDMODataEntry alloc] initWithEntitySchema:aSchema];
    }
    else {
        NSString *errorMessage = NSLocalizedString(@"EntitySchema object must not be nil", @"EntitySchema object must not be nil");
        LOGERROR(errorMessage);
        if (error) {
            *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:SCHEMA_ERROR_CODE userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
        }
        return nil;
    }
}

@end