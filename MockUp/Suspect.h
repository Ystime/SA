//
//  Suspect.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 14-05-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@interface Suspect : NSObject <MKAnnotation>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic)MKMapItem *mapItem;
-(id)initWithItem:(MKMapItem*)item;

@end
