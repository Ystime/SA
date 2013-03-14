//
//  CustomerAnnotation.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GlobalFunctions.h"
@interface CustomerAnnotation : NSObject <MKAnnotation>
{
    BusinessPartner *_bupa;
    CLLocationCoordinate2D _coordinate;

}
@property (copy)BusinessPartner *bupa;
@property CLLocationCoordinate2D coordinate;

-(id)initWithBussinessPartner:(BusinessPartner*)bupa;
@end
