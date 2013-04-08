//
//  SalesHeaderCell.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 23-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "SalesHeaderCell.h"

@implementation SalesHeaderCell
@synthesize Dlv_Icon,Inv_Icon;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSalesDocument:(SalesDocument *)sd
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self changeSalesDocument:sd];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)changeSalesDocument:(SalesDocument*)sd
{
    for(UILabel *label in self.LabelCollection)
    {
        switch (label.tag) {
            case 0:
                label.text = sd.OrderID;
                break;
            case 1:
                label.text = sd.CustomerPurchaseOrderNumber;
                break;
            case 2:
                label.text = [self stringFromDate:sd.RequestedDeliveryDate];
                break;
            case 3:
                label.text = sd.OrderType;
                break;
            case 4:
                label.text = [NSString stringWithFormat:@"%0.2f €",sd.NetValue.doubleValue];
                break;
            case 5:
                label.text = sd.Status.Delivery_Status;
                break;
            case 6:
                label.text = sd.Status.Invoice_Status;
                break;
            default:
                break;
        }
    }
    if([sd.Status.Invoice_Status isEqualToString:@"COMPLETELY_INVOICED"])
        Inv_Icon.image = [UIImage imageNamed:@"inv_full.png"];
    else if([sd.Status.Invoice_Status isEqualToString:@"PARTIALLY_INVOICED"])
        Inv_Icon.image = [UIImage imageNamed:@"inv_part.png"];
    else if([sd.Status.Invoice_Status isEqualToString:@"NOT_YET_INVOICED"])
        Inv_Icon.image = [UIImage imageNamed:@"inv_not.png"];
    else
        Inv_Icon.image = nil;
    
    
    if([sd.Status.Delivery_Status isEqualToString:@"COMPLETELY_DELIVERED"])
        Dlv_Icon.image = [UIImage imageNamed:@"dlv_full.png"];
    else if([sd.Status.Delivery_Status isEqualToString:@"PARTIALLY_DELIVERED"])
        Dlv_Icon.image = [UIImage imageNamed:@"dlv_part.png"];
    else if([sd.Status.Delivery_Status isEqualToString:@"NOT_YET_DELIVERED"])
        Dlv_Icon.image = [UIImage imageNamed:@"dlv_not.png"];
    else
        Dlv_Icon.image = nil;
}

-(NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-MM-yyyy"];
    return [df stringFromDate:date];
}

@end
