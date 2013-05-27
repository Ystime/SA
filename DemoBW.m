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


+(NSMutableArray*)loadBWQueryEQForCustomer:(NSString*)customer
{
    NSMutableArray *results = [NSMutableArray array];
    NSMutableArray *salesDocs = [[DemoData getInstance]salesDocs];
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    for(SalesDocument *sd  in salesDocs)
    {
        if([customer isEqualToString:sd.CustomerID])
        {
            ZAPP_ORDER03Result *result = [temp objectForKey:sd.OrderType];
            if(!result)
            {
                result = [[ZAPP_ORDER03Result alloc]initWithSDMDictionary:nil];
                result.NetValue = [NSDecimalNumber decimalNumberWithString:@"0"];
                result.DocumentCategory = sd.OrderType;
                if([sd.OrderType isEqualToString:@"Quotation"])
                    result.DocumentCategoryId =@"B";
                else if([sd.OrderType isEqualToString:@"Order"])
                    result.DocumentCategoryId =@"C";
                if([sd.OrderType isEqualToString:@"Returns"])
                    result.DocumentCategoryId =@"H";
            }
            result.NetValue = [result.NetValue decimalNumberByAdding:sd.NetValue];
            result.NetValueStringFormat = [NSString stringWithFormat:@"%.2f EUR",result.NetValue.floatValue];
            [temp setObject:result forKey:sd.OrderType];
        }
    }
    for(NSString *key in temp.allKeys)
    {
        [results addObject:[temp objectForKey:key]];
    }
    return results;
}

@end
