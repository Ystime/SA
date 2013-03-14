//
//  SalesHeaderCell.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 23-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "SalesHeaderCell.h"

@implementation SalesHeaderCell

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
                if([sd.OrderType isEqualToString:@"A"])
                    label.text = @"Inquiry";
                else if([sd.OrderType isEqualToString:@"B"])
                    label.text = @"Quotation";
                else if([sd.OrderType isEqualToString:@"C"])
                    label.text = @"Order";
                else if([sd.OrderType isEqualToString:@"H"])
                    label.text = @"Return";
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
}

-(NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-MM-yyyy"];
    return [df stringFromDate:date];
}

@end
