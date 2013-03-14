//
//  DemoBUPA.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoData.h"

@interface DemoBUPA : NSObject
-(NSMutableArray*)getDemoBupas;
-(void)addBupa:(BusinessPartner*)bupa;
-(void)addContact:(ContactPerson*)cont toBUPA:(NSString*)bupaID;
-(void)createBUPAS;
@end
