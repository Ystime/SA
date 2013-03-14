//
//  GooglePlacesParser.m
//  SalesRepApp
//
//  Created by Ystime on 18-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GooglePlacesSearchParser.h"

@implementation GooglePlacesSearchParser
@synthesize prospects;
NSXMLParser *parser;
SuspectAnnotation* prospect;
NSMutableString* currentElementValue;
NSString *lattitudeString;
NSString *longitudeString;
NSString *nameString;
NSString *referenceString;
NSString *vicinityString;

-(NSMutableArray*)findPlaces:(NSString*)searchURL
{
    parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:searchURL]];
    [parser setDelegate:self];
    if([parser parse] == NO)
        NSLog(@"ERROR");
    return prospects;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"PlaceSearchResponse"])
    {
        prospects = [[NSMutableArray alloc]init];
    }

}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc]initWithString:string];
    else {
        [currentElementValue appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"PlaceSearchResponse"])
        return;
    if([elementName isEqualToString:@"result"])
    {
        CLLocationCoordinate2D test = CLLocationCoordinate2DMake(lattitudeString.doubleValue, longitudeString.doubleValue);
        prospect = [[SuspectAnnotation alloc]initWithName:nameString coordinate:test reference:referenceString vicinity:vicinityString];
        [prospects addObject:prospect];
        lattitudeString = longitudeString = nameString = referenceString = nil;
        prospect = nil;
    }
    if([elementName isEqualToString:@"name"])
    {
        //aResult.name = [NSString stringb currentElementValue;
        nameString= [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        currentElementValue = nil; 
    }
    
    if([elementName isEqualToString:@"lat"])
    {
        //aResult.name = [NSString stringb currentElementValue;
        lattitudeString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        currentElementValue = nil;
    }    
    if([elementName isEqualToString:@"lng"])
    {
       longitudeString= [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        currentElementValue = nil;
    }
    if([elementName isEqualToString:@"vicinity"])
    {
        vicinityString= [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        currentElementValue = nil;
    }
    if([elementName isEqualToString:@"reference"])
    {
        referenceString= [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        currentElementValue = nil;
    }
    else {
        currentElementValue = nil;
   }

}
@end
