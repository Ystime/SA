//
//  DemoData.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalFunctions.h"
#import "DemoBW.h"
#import "DemoBUPA.h"
#import "DemoDocs.h"
#import "DemoMaterials.h"

@interface DemoData : NSObject
{
    NSMutableArray *bupas;
    NSMutableArray *salesDocs;
    NSMutableArray *materials;
    NSMutableArray *BWQuery1;
    NSMutableArray *BWQuery4;
    NSString *name;
}

@property (nonatomic,retain) NSMutableArray *bupas;
@property (nonatomic,retain) NSMutableArray *salesDocs;
@property (nonatomic,retain) NSMutableArray *materials;
@property (nonatomic,retain) NSMutableArray *BWQuery1;
@property (nonatomic,retain) NSMutableArray *BWQuery4;


@property (nonatomic,retain) NSString *name;

+(DemoData*)getInstance;
-(void)loadDemoData;
-(void)addProspect:(BusinessPartner*)prospect;
-(void)postNotificationfor:(NSString*)identifier;

@end
