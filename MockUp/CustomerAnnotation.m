//
//  CustomerAnnotation.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "CustomerAnnotation.h"

@implementation CustomerAnnotation
@synthesize bupa = _bupa;

@synthesize coordinate = _coordinate;


-(id)initWithBussinessPartner:(BusinessPartner*)bupa{
    if ((self = [super init])) {
        _bupa = bupa;
    }
    _coordinate = CLLocationCoordinate2DMake(_bupa.Address.GeoCode.Latitude.doubleValue, _bupa.Address.GeoCode.Longitude.doubleValue);
    return self;
}

- (NSString *)title {
    if ([_bupa.BusinessPartnerName isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _bupa.BusinessPartnerName;
}

- (NSString *)subtitle {
    
    return _bupa.Address.City;
}

@end
