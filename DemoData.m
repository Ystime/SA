//
//  DemoData.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoData.h"

@implementation DemoData
@synthesize bupas,salesDocs,name,materials,BWQuery1,BWQuery4;
static DemoData *instance = nil;

+(DemoData*)getInstance
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [DemoData new];
            [instance loadDemoData];
        }
    }
    return instance;
}

-(void)loadDemoData
{
    DemoBUPA *temp = [[DemoBUPA alloc]init];
    bupas = [temp getDemoBupas];
    salesDocs = [DemoDocs loadDemoSalesDocuments];
    materials = [DemoMaterials loadDemoMaterials];
}

-(void)addProspect:(BusinessPartner*)prospect;
{
    [bupas addObject:prospect];
}

-(void)postNotificationfor:(NSString*)identifier
{
    if([identifier isEqualToString:@"BUPA"])
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:bupas forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadBusinessPartnersCompletedNotification object:nil userInfo:dic];
    }
    else if([identifier isEqualToString:@"Docs"])
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:salesDocs forKey:kResponseItems];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadSalesDocumentsCompletedNotification object:nil userInfo:dic];
    }
    else if([identifier isEqualToString:@"BWQuery1"])
    {
        NSMutableDictionary *userInfoDict;
        userInfoDict = [NSMutableDictionary dictionaryWithObject:[DemoBW loadBWQuery1] forKey:kResponseItems];
        [userInfoDict setObject:[NSString stringWithFormat:@"1"] forKey:kQueryNumber];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadQueryCompletedNotification object:self userInfo:userInfoDict];
    }
    
    else if([identifier isEqualToString:@"BWQuery4"])
    {
        NSMutableDictionary *userInfoDict;
        userInfoDict = [NSMutableDictionary dictionaryWithObject:[DemoBW loadBWQuery4] forKey:kResponseItems];
        [userInfoDict setObject:[NSString stringWithFormat:@"4"] forKey:kQueryNumber];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadQueryCompletedNotification object:self userInfo:userInfoDict];
    }
}

@end
