//
//  SalesItemCell.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 23-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "SalesItemCell.h"

@implementation SalesItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSalesItem:(SalesDocumentItem*)item
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self changeItem:item];
    }
    return self;
}

-(void)changeItem:(SalesDocumentItem*)item
{
    for(UILabel *label in self.Labels)
    {
        switch (label.tag) {
            case 1:
                label.text = item.Material;
                break;
            case 2:
                label.text = item.Description;
                break;
            case 3:
                label.text = [NSString stringWithFormat:@"%.2f",item.Quantity.doubleValue];
                break;
            case 4:
                label.text = item.UoM;
                break;
            case 5:
                label.text = [NSString stringWithFormat:@"%.2f €",item.NetValue.doubleValue];
                break;
                
            default:
                break;
        }
    }
    if([item.ItemNumber isEqualToString:@"Quotation"])
    {
        self.ActionImage.image = [UIImage imageNamed:@"QT.png"];
    }
    else if([item.ItemNumber isEqualToString:@"Sales Order"])
    {
        self.ActionImage.image = [UIImage imageNamed:@"SO.png"];
    }
    else if([item.ItemNumber isEqualToString:@"Return Order"])
    {
        self.ActionImage.image = [UIImage imageNamed:@"RO.png"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
