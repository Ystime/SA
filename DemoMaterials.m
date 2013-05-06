//
//  DemoMaterials.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 15-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoMaterials.h"

@implementation DemoMaterials
+(NSMutableArray*)loadDemoMaterials
{
    NSMutableArray* materials;
    
    Material *temp1 = [[Material alloc]initWithSDMDictionary:nil];
    temp1.MaterialNumber = @"Y000000001";
    temp1.UoM = @"Pieces";
    temp1.Description = @"SAP Server";
    temp1.EANCode = @"1234567890";
    temp1.Price = [NSDecimalNumber decimalNumberWithString:@"10000"];

    
    Material *temp2 = [[Material alloc]initWithSDMDictionary:nil];
    temp2.MaterialNumber = @"Y000000002";
    temp2.UoM = @"Pallets";
    temp2.Description = @"Business Cards";
    temp2.EANCode = @"2345678901";
    temp2.Price = [NSDecimalNumber decimalNumberWithString:@"350"];
    
    Material *temp3 = [[Material alloc]initWithSDMDictionary:nil];
    temp3.MaterialNumber = @"Y000000003";
    temp3.UoM = @"Pieces";
    temp3.Description = @"Gateway Manual";
    temp3.EANCode = @"3456789012";
    temp3.Price = [NSDecimalNumber decimalNumberWithString:@"75"];
    
    Material *temp4 = [[Material alloc]initWithSDMDictionary:nil];
    temp4.MaterialNumber = @"Y000000004";
    temp4.UoM = @"Pieces";
    temp4.Description = @"External Hard Disk";
    temp4.EANCode = @"4567890123";
    temp4.Price = [NSDecimalNumber decimalNumberWithString:@"99"];
    
    
    Material *temp5 = [[Material alloc]initWithSDMDictionary:nil];
    temp5.MaterialNumber = @"Y000000005";
    temp5.UoM = @"Hours";
    temp5.Description = @"SAP Consultant";
    temp5.EANCode = @"5678901234";
    temp5.Price = [NSDecimalNumber decimalNumberWithString:@"125"];
    
    return (materials = [NSMutableArray arrayWithObjects:temp1,temp2,temp3,temp4,temp5, nil]);
}

+(NSMutableArray*)loadDemoMaterialGroups
{
    MaterialGroup *temp0 = [[MaterialGroup alloc]initWithSDMDictionary:nil];
    temp0.MaterialGroupID = @"All";
    temp0.Description = @"All Materials";
    
    MaterialGroup *temp1 = [[MaterialGroup alloc]initWithSDMDictionary:nil];
    temp1.MaterialGroupID = @"MG1";
    temp1.MaterialSet = [NSMutableArray arrayWithObjects:@"Y000000001",@"Y000000004", nil];
    temp1.Description = @"Hardware";
    
    MaterialGroup *temp2 = [[MaterialGroup alloc]initWithSDMDictionary:nil];
    temp2.MaterialGroupID = @"MG2";
    temp2.MaterialSet = [NSMutableArray arrayWithObjects:@"Y000000003",nil];
    temp2.Description = @"Manuals";
    
    return ([NSMutableArray arrayWithObjects:temp0,temp1,temp2,nil]);
}
@end
