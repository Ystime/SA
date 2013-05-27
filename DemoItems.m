//
//  DemoItems.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 15-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoItems.h"

@implementation DemoItems


+(void)addDemoItemsToSalesDocuments2:(NSMutableArray*)documents
{
    NSArray *materials = [[DemoData getInstance]materials];
    NSArray *primes = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:5],[NSNumber numberWithInt:7],[NSNumber numberWithInt:11], nil];
    
    for(SalesDocument *sd in documents)
    {
        float totalValue = 0.0;
        int random = arc4random()%99999;
        //        for(int i =2;i<7;i++)
        for(NSNumber *number in primes)
        {
            int i = number.intValue;
            if(random % i == 0 || ([primes indexOfObject:number]==4 && sd.Items.count == 0))
            {
                SalesDocItem *item = [[SalesDocItem alloc]initWithSDMDictionary:nil];
                item.OrderID = sd.OrderID;
                item.Quantity = [NSNumber numberWithInt:arc4random()%100];
                Material *tempMat = materials[[primes indexOfObject:number]];
                item.Material = tempMat.MaterialNumber;
                item.Description = tempMat.Description;
                item.UoM = tempMat.UoM;
                float total = tempMat.Price.Price.floatValue * item.Quantity.floatValue;
                totalValue +=total;
                item.NetPrice = tempMat.Price.Price;
                item.NetValue = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",total]];
                [sd.Items addObject:item];
            }
        }
        sd.NetValue = [[NSDecimalNumber alloc]initWithFloat:totalValue];
    }
    
}

+(void)addDemoItemsToSalesDocuments:(NSMutableArray*)documents
{
    NSArray *materials = [[DemoData getInstance]materials];
    NSMutableArray *resultingDocuments;
    for(SalesDocument *sd in documents)
    {
        float totalValue = 0.0;
        for(Material *mat in materials)
        {
            int boelItem = arc4random()%3;
            if(boelItem == 0)
            {
                SalesDocItem *item = [[SalesDocItem alloc]initWithSDMDictionary:nil];
                item.OrderID = sd.OrderID;
                item.Quantity = [NSNumber numberWithInt:arc4random()%100];
                item.Material = mat.MaterialNumber;
                item.Description = mat.Description;
                item.UoM = mat.UoM;
                float total = mat.Price.Price.floatValue * item.Quantity.floatValue;
                totalValue +=total;
                item.NetPrice = mat.Price.Price;
                item.NetValue = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",total]];
                [sd.Items addObject:item];
                
            }
        }
        if (totalValue > 0.00)
        {
            sd.NetValue = [[NSDecimalNumber alloc]initWithFloat:totalValue];
            [resultingDocuments addObject:sd];
        }
    }
    documents = resultingDocuments;
}

@end
