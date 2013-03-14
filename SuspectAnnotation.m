//
//  prospectLocation.m
//  SalesRepApp
//
//  Created by Ystime on 15-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SuspectAnnotation.h"

@implementation SuspectAnnotation
@synthesize name,street,house_no,postal,city,coordinate,region,country,telephone,website,reference,vicinity;


-(id)initWithName:(NSString*)_name coordinate:(CLLocationCoordinate2D)_coordinate reference:(NSString*)_reference vicinity:(NSString*)_vicinity
{
    coordinate = _coordinate;
    name = _name;
    reference = _reference;
    vicinity = _vicinity;
    return self;
    
}

-(NSString*)title
{
    if([name isKindOfClass:[NSNull class]])
    {
        return @"Unknown name";
    }
    else {
        return name;
    }
}

-(NSString*)subtitle
{
    return vicinity;
}

-(void)toString
{
    NSLog(@"This is prospect:%@ in city:%@ with number:%@",name,city,telephone);
}

-(void)setCoordinateLat:(double)lat Long:(double)longi
{
    coordinate = CLLocationCoordinate2DMake(lat, longi);
}

@end
