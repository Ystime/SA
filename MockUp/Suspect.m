//
//  Suspect.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 14-05-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "Suspect.h"

@implementation Suspect
@synthesize coordinate,mapItem;

-(id)initWithItem:(MKMapItem*)item
{
    mapItem = item;
    coordinate = mapItem.placemark.location.coordinate;
    return self;
}

-(NSString*)title
{
    return mapItem.name;
}

-(NSString*)subtitle
{
    return [mapItem.placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressStreetKey];
}
@end
