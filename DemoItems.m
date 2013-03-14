//
//  DemoItems.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 15-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoItems.h"

@implementation DemoItems
+(void)addDemoItemsToSalesDocuments:(NSMutableArray*)documents
{
    for(SalesDocument *sd in documents)
    {
        SalesDocumentItem *item1 = [[SalesDocumentItem alloc]initWithSDMEntry:nil];
        item1.OrderID = sd.OrderID;
        item1.Quantity = [NSNumber numberWithFloat:3.0];
        item1.UoM = @"Piece(s)";
        item1.Material = @"Y000000001";
        item1.Description = @"SAP Servers";
        item1.NetPrice = [NSDecimalNumber decimalNumberWithString:@"2999"];
        item1.NetValue = [NSDecimalNumber decimalNumberWithString:@"8997"];
        
        SalesDocumentItem *item2 = [[SalesDocumentItem alloc]initWithSDMEntry:nil];
        item2.OrderID = sd.OrderID;
        item2.Quantity = [NSNumber numberWithFloat:2.0];
        item2.UoM = @"Pallet(s)";
        item2.Material = @"Y000000002";
        item2.Description = @"Business cards";
        item2.NetPrice = [NSDecimalNumber decimalNumberWithString:@"295"];
        item2.NetValue = [NSDecimalNumber decimalNumberWithString:@"590"];
        
        [sd.Items addObject:item1];
        [sd.Items addObject:item2];
        sd.NetValue = [NSDecimalNumber decimalNumberWithString:@"9587.0"];
    }
}
@end
