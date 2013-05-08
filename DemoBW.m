//
//  DemoBW.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-03-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoBW.h"
#import "DemoData.h"
@implementation DemoBW

+(NSMutableArray*)loadBWQuery1
{
    NSMutableArray *results = [NSMutableArray array];
    
    /*Randomly decide how many different pie slices*/
    int number = arc4random()%5;

    for(int i = 0;i <= number;i++)
    {
        AZAPP_ORDER01Result *result = [[AZAPP_ORDER01Result alloc]initWithSDMEntry:nil];
        
        /*Randomly generate a value*/
        int temp = arc4random()%10000000;
        float value = temp/100.0;
        result.A006EI3ULWC7I23DQTK2PB6GHO_F = [NSString stringWithFormat:@"%.2f EUR",value];
        
        /*Assign doc type*/
        switch (i) {
            case 0:
                result.A0DOC_CATEG_T = @"Quotation";
                break;
            case 1:
                result.A0DOC_CATEG_T = @"Inquiry";
                break;
            case 2:
                result.A0DOC_CATEG_T = @"Invoice";
                break;
            case 3:
                result.A0DOC_CATEG_T = @"Order";
                break;
            case 4:
                result.A0DOC_CATEG_T = @"Returns";
                break;
            default:
                break;
        }
        [results addObject:result];
    }
    return results;
}

+(NSMutableArray*)loadBWQuery4
{
    NSMutableArray *results = [NSMutableArray array];
    AZAPP_AR01Result *result = [[AZAPP_AR01Result alloc]initWithSDMEntry:nil];
    result.A006EI3ULWC7I23F67E6D3SD18_F = [NSString stringWithFormat:@"%.2f EUR",[DemoBW getRandomValue:64.0]];
    result.A006EI3ULWC7I23F67E6D3SVZW_F = [NSString stringWithFormat:@"%.2f EUR",[DemoBW getRandomValue:2.0]];
    result.A006EI3ULWC7I23F67E6D3TEYK_F = [NSString stringWithFormat:@"%.2f EUR",[DemoBW getRandomValue:4.0]];
    result.A006EI3ULWC7I23F67E6D3TXX8_F = [NSString stringWithFormat:@"%.2f EUR",[DemoBW getRandomValue:8.0]];
    result.A006EI3ULWC7I23F67E6D3UGVW_F = [NSString stringWithFormat:@"%.2f EUR",[DemoBW getRandomValue:16.0]];
    result.A006EI3ULWC7I23F67E6D3UZUK_F = [NSString stringWithFormat:@"%.2f EUR",[DemoBW getRandomValue:32.0]];
    [results addObject:result];
    return results;
}

+(NSMutableArray*)loadBWQueryEQ
{
    int number = arc4random()%4;
    NSMutableArray *results = [NSMutableArray array];
    
    for(int i=0;i<=number;i++)
    {
        ZAPP_ORDER03Result *result = [[ZAPP_ORDER03Result alloc]initWithSDMDictionary:nil];
        float value = (arc4random()%1000000)/100;
        NSString *netValue = [NSString stringWithFormat:@"%.2f",value];
        result.NetValue = [NSDecimalNumber decimalNumberWithString:netValue];
        result.NetValueStringFormat = [NSString stringWithFormat:@"%@ EUR",netValue];
        switch (i) {
            case 0:
                result.DocumentCategory = @"Inquiry";
                result.DocumentCategoryId = @"A";
                break;
            case 1:
                result.DocumentCategory = @"Quotation";
                result.DocumentCategoryId = @"B";
                break;
            case 2:
                result.DocumentCategory = @"Order";
                result.DocumentCategoryId = @"C";
                break;
            case 3:
                result.DocumentCategory = @"Return Order";
                result.DocumentCategoryId = @"H";
                break;
            default:
                break;
        }
        [results addObject:result];
    }
    return results;
}


+(float)getRandomValue:(float)multiplier
{
    int temp = arc4random() % 12500000;
    float value = temp/(100.0*multiplier);
    return (value-(25000/multiplier));
}
@end
