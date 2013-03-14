//
//  GooglePlacesDetail.m
//  SalesRepApp
//
//  Created by Ystime on 20-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GooglePlacesDetail.h"
#import "address_component.h"

@implementation GooglePlacesDetail
@synthesize prospect;

NSXMLParser *parser;
NSMutableString* currentElementValue;
address_component *ac;
double lat;


-(SuspectAnnotation*)findDetails:(NSString *)reference
{

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/xml?reference=%@&sensor=true&key=AIzaSyBGHEoD8uMDk7Fwq_Bk6l1jp8Gsxl9bL5Y",reference]];
    parser = [[NSXMLParser alloc]initWithContentsOfURL:url];   

    [parser setDelegate:self];
    if([parser parse])
    {
        
    }
    else
    {
        NSLog(@"ERROR ERROR! Link:%@",url);
    }
    return prospect;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"result"])
        {
            prospect = [[SuspectAnnotation alloc]init];
        }
    
    if([elementName isEqualToString:@"address_component"])
    {
        ac = [[address_component alloc]init];
    }

}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc]initWithString:string];
    else {
        [currentElementValue appendString:string];
    }
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if([elementName isEqualToString:@"PlaceDetailsResponse"])
      {
//          [prospect toString];
          return; 
      }
    if([elementName isEqualToString:@"name"])
    {
        prospect.name = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([elementName isEqualToString:@"lat"])
    {
        lat = [[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] doubleValue];
    }
    if([elementName isEqualToString:@"lng"])
    {
        [prospect setCoordinateLat:lat Long:[[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] doubleValue]];
        lat = 0;
    }
    if([elementName isEqualToString:@"international_phone_number"])
    {
        prospect.telephone = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([elementName isEqualToString:@"website"])
    {
        prospect.website = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([elementName isEqualToString:@"long_name"])
    {
        ac.longname = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([elementName isEqualToString:@"short_name"])
    {
        ac.shortname = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([elementName isEqualToString:@"type"])
    {
        if(ac.type.length == 0)
            ac.type = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([elementName isEqualToString:@"address_component"])
    {
        if([ac.type isEqualToString:@"street_number"])
            prospect.house_no = ac.longname;
        if([ac.type isEqualToString:@"route"])
            prospect.street = ac.longname;
        if([ac.type isEqualToString:@"locality"])
            prospect.city = ac.longname;
        if([ac.type isEqualToString:@"administrative_area_level_1"])
            prospect.region = ac.longname;
        if([ac.type isEqualToString:@"country"])
            prospect.country = ac.longname;
        if([ac.type isEqualToString:@"postal_code"])
            prospect.postal = ac.longname;
        ac = NULL;
    }
    currentElementValue = nil;
    
}
@end
