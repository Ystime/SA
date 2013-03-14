//
//  prospectLocation.h
//  SalesRepApp
//
//  Created by Ystime on 15-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SuspectAnnotation : NSObject <MKAnnotation>

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* street;
@property (nonatomic,strong) NSString* house_no;
@property (nonatomic,strong) NSString* postal;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* region;
@property (nonatomic,strong) NSString* country;
@property (nonatomic,strong) NSString* telephone;
@property (nonatomic,strong) NSString* website;
@property (nonatomic,strong) NSString* reference;
@property (nonatomic,strong) NSString* vicinity;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

-(id)initWithName:(NSString*)_name coordinate:(CLLocationCoordinate2D)_coordinate reference:(NSString*)_reference vicinity:(NSString*)_vicinity;
-(void)toString;
-(void)setCoordinateLat:(double)lat Long:(double)longi;
@end
