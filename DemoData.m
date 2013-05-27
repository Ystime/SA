//
//  DemoData.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoData.h"

@implementation DemoData
@synthesize bupas,salesDocs,name,materials,materialGroups,BWQuery1,BWQuery4,bupaNotes,bupaPictures,contactPictures,hierNodes;
static DemoData *instance = nil;

+(DemoData*)getInstance
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [DemoData new];
            instance.contactNumber = 123;
            instance.docNumber = 0;
            [instance loadDemoData]; 
        }
    }
    return instance;
}

-(void)loadDemoData
{

    DemoBUPA *temp = [[DemoBUPA alloc]init];
    bupas = [temp getDemoBupas];
    hierNodes = [temp createNodes];
    materials = [DemoMaterials loadDemoMaterials];
    materialGroups = [DemoMaterials loadDemoMaterialGroups];
    salesDocs = [DemoDocs loadDemoSalesDocuments];

    bupaNumber = bupas.count;
    bupaPictures = [DemoAttachments loadPics];
    bupaNotes = [DemoAttachments loadNotes];
    contactPictures = [DemoAttachments loadPassphotos];
    
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
    
    else if ([identifier isEqualToString:@"EQQuery"])
    {
        NSMutableDictionary *userInfoDict;
        userInfoDict = [NSMutableDictionary dictionaryWithObject:EQQuery forKey:kResponseItems];
        [userInfoDict setObject:[NSString stringWithFormat:@"99"] forKey:kQueryNumber];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadQueryCompletedNotification object:self userInfo:userInfoDict];
    }
}

-(int)getNextDocId
{
    docNumber +=1;
    return docNumber;
}

-(int)getNextBupaId{
    return (bupaNumber+=1);
}
-(int)getNextContactId{
    return (contactNumber+=1);
    
}

@end
