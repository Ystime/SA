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
#import "DemoAttachments.h"

@interface DemoData : NSObject
{
    NSMutableArray *bupas;
    NSMutableDictionary *bupaPictures;
    NSMutableDictionary *contactPictures;
    NSMutableDictionary *bupaNotes;
    NSMutableArray *salesDocs;
    NSMutableArray *materials;
    NSMutableArray *materialGroups;
    NSMutableArray *BWQuery1;
    NSMutableArray *BWQuery4;
    NSMutableArray *EQQuery;
    NSMutableArray *hierNodes;
    NSString *name;
    int docNumber;
    int bupaNumber;
    int contactNumber;
}

@property (nonatomic,retain) NSMutableArray *bupas;
@property (nonatomic,retain) NSMutableArray *hierNodes;
@property (nonatomic,retain) NSMutableDictionary *bupaPictures;
@property (nonatomic,retain) NSMutableDictionary *contactPictures;

@property (nonatomic,retain) NSMutableDictionary *bupaNotes;
@property (nonatomic,retain) NSMutableArray *salesDocs;
@property int docNumber;
@property int bupaNumber;
@property int contactNumber;


@property (nonatomic,retain) NSMutableArray *materials;
@property (nonatomic,retain) NSMutableArray *materialGroups;

@property (nonatomic,retain) NSMutableArray *BWQuery1;
@property (nonatomic,retain) NSMutableArray *BWQuery4;
@property (nonatomic,retain) NSMutableArray *EQQuery;


@property (nonatomic,retain) NSString *name;

+(DemoData*)getInstance;
-(void)loadDemoData;
-(void)addProspect:(BusinessPartner*)prospect;
-(void)postNotificationfor:(NSString*)identifier;
-(int)getNextDocId;
-(int)getNextBupaId;
-(int)getNextContactId;


@end
