//
//  DemoDocs.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoDocs.h"

@implementation DemoDocs

-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+(NSMutableArray*)loadDemoSalesDocuments
{
    SalesDocument *tempsd1 = [[SalesDocument alloc]initWithSDMEntry:nil];
    tempsd1.OrderID = @"1";
    tempsd1.OrderType = @"B";
    tempsd1.DocumentDate = [NSDate date];
    tempsd1.CustomerID = @"1";
    tempsd1.SalesOrganization = @"1000";
    tempsd1.DistributionChannel = @"10";
    tempsd1.Division = @"10";
    tempsd1.Currency = @"EUR";
    tempsd1.RequestedDeliveryDate = [NSDate date];
    tempsd1.CustomerPurchaseOrderNumber = @"PO-12532";
    tempsd1.Items = [[NSMutableArray alloc]init];
    
    SalesDocument *tempsd2 = [[SalesDocument alloc]initWithSDMEntry:nil];
    tempsd2.OrderID = @"2";
    tempsd2.OrderType = @"C";
    tempsd2.DocumentDate = [NSDate date];
    tempsd2.CustomerID = @"1";
    tempsd2.SalesOrganization = @"1000";
    tempsd2.DistributionChannel = @"10";
    tempsd2.Division = @"10";
    tempsd2.Currency = @"EUR";
    tempsd2.RequestedDeliveryDate = [NSDate date];
    tempsd2.CustomerPurchaseOrderNumber = @"PO-12532";
    tempsd2.Items = [[NSMutableArray alloc]init];
    
    SalesDocument *tempsd3 = [[SalesDocument alloc]initWithSDMEntry:nil];
    tempsd3.OrderID = @"3";
    tempsd3.OrderType = @"B";
    tempsd3.DocumentDate = [NSDate date];
    tempsd3.CustomerID = @"2";
    tempsd3.SalesOrganization = @"1000";
    tempsd3.DistributionChannel = @"10";
    tempsd3.Division = @"10";
    tempsd3.Currency = @"EUR";
    tempsd3.RequestedDeliveryDate = [NSDate date];
    tempsd3.CustomerPurchaseOrderNumber = @"PO-12532";
    tempsd3.Items = [[NSMutableArray alloc]init];
    
    SalesDocument *tempsd4 = [[SalesDocument alloc]initWithSDMEntry:nil];
    tempsd4.OrderID = @"4";
    tempsd4.OrderType = @"C";
    tempsd4.DocumentDate = [NSDate date];
    tempsd4.CustomerID = @"2";
    tempsd4.SalesOrganization = @"1000";
    tempsd4.DistributionChannel = @"10";
    tempsd4.Division = @"10";
    tempsd4.Currency = @"EUR";
    tempsd4.RequestedDeliveryDate = [NSDate date];
    tempsd4.CustomerPurchaseOrderNumber = @"PO-12532";
    tempsd4.Items = [[NSMutableArray alloc]init];
    
    SalesDocument *tempsd5 = [[SalesDocument alloc]initWithSDMEntry:nil];
    tempsd5.OrderID = @"5";
    tempsd5.OrderType = @"H";
    tempsd5.DocumentDate = [NSDate date];
    tempsd5.CustomerID = @"2";
    tempsd5.SalesOrganization = @"1000";
    tempsd5.DistributionChannel = @"10";
    tempsd5.Division = @"10";
    tempsd5.Currency = @"EUR";
    tempsd5.RequestedDeliveryDate = [NSDate date];
    tempsd5.CustomerPurchaseOrderNumber = @"PO-12532";
    tempsd5.Items = [[NSMutableArray alloc]init];
    
    
    
    NSMutableArray *result = [NSMutableArray arrayWithObjects:tempsd1,tempsd2,tempsd3,tempsd4,tempsd5, nil];
    [DemoItems addDemoItemsToSalesDocuments:result];
    return result;
}

@end
