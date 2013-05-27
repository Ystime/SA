//
//  DemoBW.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-03-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWRequests.h"

@interface DemoBW : NSObject
+(NSMutableArray*)loadBWQuery1;
+(NSMutableArray*)loadBWQueryEQ;
+(NSMutableArray*)loadSecondEQ;
+(NSMutableArray*)loadBWQueryEQForCustomer:(NSString*)customer;

@end
