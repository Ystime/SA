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
    temp1.UoM = @"Box(12pc)";
    temp1.Description = @"Verkade reep Wit";
    temp1.EANCode = @"1234567890";
    temp1.Price.Price = [NSDecimalNumber decimalNumberWithString:@"0.75"];
    temp1.Price.Currency = @"€";
    
    Material *temp2 = [[Material alloc]initWithSDMDictionary:nil];
    temp2.MaterialNumber = @"Y000000002";
    temp2.UoM = @"Box(12pc)";
    temp2.Description = @"Verkade reep Cappuccino";
    temp2.EANCode = @"2345678901";
    temp2.Price.Price = [NSDecimalNumber decimalNumberWithString:@"0.75"];
    temp2.Price.Currency = @"€";
    
    Material *temp3 = [[Material alloc]initWithSDMDictionary:nil];
    temp3.MaterialNumber = @"Y000000003";
    temp3.UoM = @"Box(12pc)";
    temp3.Description = @"Verkade reep Hazelnoot";
    temp3.EANCode = @"3456789012";
    temp3.Price.Price = [NSDecimalNumber decimalNumberWithString:@"0.75"];
    temp3.Price.Currency = @"€";
    
    Material *temp4 = [[Material alloc]initWithSDMDictionary:nil];
    temp4.MaterialNumber = @"Y000000004";
    temp4.UoM = @"Box(12pc)";
    temp4.Description = @"Verkade reep Amandel";
    temp4.EANCode = @"4567890123";
    temp4.Price.Price = [NSDecimalNumber decimalNumberWithString:@"0.75"];
    temp4.Price.Currency = @"€";
    
    Material *temp5 = [[Material alloc]initWithSDMDictionary:nil];
    temp5.MaterialNumber = @"Y000000005";
    temp5.UoM = @"Box(6pc)";
    temp5.Description = @"Eieren multi zak 50";
    temp5.EANCode = @"5678901234";
    temp5.Price.Price = [NSDecimalNumber decimalNumberWithString:@"1.00"];
    temp5.Price.Currency = @"€";
    
    Material *temp6 = [[Material alloc]initWithSDMDictionary:nil];
    temp6.MaterialNumber = @"Y000000006";
    temp6.UoM = @"Box(6pc)";
    temp6.Description = @"Eieren puur zak 50";
    temp6.EANCode = @"1234567890";
    temp6.Price.Price = [NSDecimalNumber decimalNumberWithString:@"1.00"];
    temp6.Price.Currency = @"€";
    
    Material *temp7 = [[Material alloc]initWithSDMDictionary:nil];
    temp7.MaterialNumber = @"Y000000007";
    temp7.UoM = @"Box(6pc)";
    temp7.Description = @"Eieren Melk zak 50";
    temp7.EANCode = @"2345678901";
    temp7.Price.Price = [NSDecimalNumber decimalNumberWithString:@"1.00"];
    temp7.Price.Currency = @"€";
    
    Material *temp8 = [[Material alloc]initWithSDMDictionary:nil];
    temp8.MaterialNumber = @"Y000000008";
    temp8.UoM = @"Piece";
    temp8.Description = @"Paashaas groot";
    temp8.EANCode = @"3456789012";
    temp8.Price.Price = [NSDecimalNumber decimalNumberWithString:@"1.00"];
    temp8.Price.Currency = @"€";
    
    Material *temp9 = [[Material alloc]initWithSDMDictionary:nil];
    temp9.MaterialNumber = @"Y000000009";
    temp9.UoM = @"Piece";
    temp9.Description = @"Paashaas klein";
    temp9.EANCode = @"4567890123";
    temp9.Price.Price = [NSDecimalNumber decimalNumberWithString:@"1.50"];
    temp9.Price.Currency = @"€";
    
    Material *temp10 = [[Material alloc]initWithSDMDictionary:nil];
    temp10.MaterialNumber = @"Y000000010";
    temp10.UoM = @"Box(24pc)";
    temp10.Description = @"Milkyway";
    temp10.EANCode = @"5678901234";
    temp10.Price.Price = [NSDecimalNumber decimalNumberWithString:@"3.75"];
    temp10.Price.Currency = @"€";
    
    Material *temp11 = [[Material alloc]initWithSDMDictionary:nil];
    temp11.MaterialNumber = @"Y000000011";
    temp11.UoM = @"Box(24pc)";
    temp11.Description = @"Snicker";
    temp11.EANCode = @"1234567890";
    temp11.Price.Price = [NSDecimalNumber decimalNumberWithString:@"8.50"];
    temp11.Price.Currency = @"€";
    
    Material *temp12 = [[Material alloc]initWithSDMDictionary:nil];
    temp12.MaterialNumber = @"Y000000012";
    temp12.UoM = @"Box(24pc)";
    temp12.Description = @"Mars";
    temp12.EANCode = @"2345678901";
    temp12.Price.Price = [NSDecimalNumber decimalNumberWithString:@"8.00"];
    temp12.Price.Currency = @"€";
    
    Material *temp13 = [[Material alloc]initWithSDMDictionary:nil];
    temp13.MaterialNumber = @"Y000000013";
    temp13.UoM = @"Box(24pc)";
    temp13.Description = @"Bounty";
    temp13.EANCode = @"3456789012";
    temp13.Price.Price = [NSDecimalNumber decimalNumberWithString:@"6.75"];
    temp13.Price.Currency = @"€";

    
    return (materials = [NSMutableArray arrayWithObjects:temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,nil]);
}

+(NSMutableArray*)loadDemoMaterialGroups
{
    NSArray *mats = [[DemoData getInstance]materials];
    MaterialGroup *temp0 = [[MaterialGroup alloc]initWithSDMDictionary:nil];
    temp0.MaterialGroupID = @"All";
    temp0.Description = @"All Materials";
    temp0.MaterialSet = [NSMutableArray arrayWithArray:mats];
    
    MaterialGroup *temp1 = [[MaterialGroup alloc]initWithSDMDictionary:nil];
    temp1.MaterialGroupID = @"SG1";
    temp1.MaterialSet = [NSMutableArray arrayWithObjects:mats[0],mats[1],mats[2],mats[3], nil];
    temp1.Description = @"Verkade";
    
    MaterialGroup *temp2 = [[MaterialGroup alloc]initWithSDMDictionary:nil];
    temp2.MaterialGroupID = @"SG2";
    temp2.MaterialSet = [NSMutableArray arrayWithObjects:mats[4],mats[5],mats[6],nil];
    temp2.Description = @"Paaseitjes";
    
    MaterialGroup *temp3 = [[MaterialGroup alloc]initWithSDMDictionary:nil];
    temp3.MaterialGroupID = @"SG3";
    temp3.MaterialSet = [NSMutableArray arrayWithObjects:mats[9],mats[10],mats[11],mats[12],nil];
    temp3.Description = @"Mars producten";
    
    return ([NSMutableArray arrayWithObjects:temp0,temp1,temp2,temp3,nil]);
}
@end
