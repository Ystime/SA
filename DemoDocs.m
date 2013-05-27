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
    NSMutableArray *result = [NSMutableArray array];
    NSArray *types = [NSArray arrayWithObjects:@"Quotation",@"Order",@"Returns", nil];
    for(BusinessPartner *bp in [[DemoData getInstance]bupas])
    {
        if([bp.BusinessPartnerType isEqualToString:@"Customer"])
        {
            for(NSString *type in types)
            {
                int boel = arc4random()%2;
                if(boel == 1)
                {
                    int numberOfDocs = arc4random()%5;
                    for(int i =0;i<numberOfDocs;i++)
                    {
                        SalesDocument *tempsd1 = [[SalesDocument alloc]initWithSDMEntry:nil];
                        tempsd1.OrderID = [NSString stringWithFormat:@"%i",[[DemoData getInstance]getNextDocId]];
                        tempsd1.OrderType = type;
                        tempsd1.DocumentDate = [NSDate date];
                        tempsd1.CustomerID = bp.BusinessPartnerID;
                        tempsd1.SalesOrganization = @"1000";
                        tempsd1.DistributionChannel = @"10";
                        tempsd1.Division = @"10";
                        tempsd1.Currency = @"EUR";
                        tempsd1.RequestedDeliveryDate = [NSDate date];
                        tempsd1.CustomerPurchaseOrderNumber = [NSString stringWithFormat:@"%@%@%i",bp.BusinessPartnerID,tempsd1.OrderID,bp.ContactPersons.count];
                        tempsd1.Items = [[NSMutableArray alloc]init];
                        [result addObject:tempsd1];
                    }
                }
            }
 
        }
    }
    [DemoItems addDemoItemsToSalesDocuments:result];
    return result;
}

@end
