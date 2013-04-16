//
//  RDItemCell.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 16-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "RDItemCell.h"

@implementation RDItemCell
SalesDocItem *cellItem;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setDocItem:(SalesDocItem *)item
{
    cellItem = item;
    self.itemMaterial.text = item.Material;
    self.itemDescription.text = item.Description;
    self.itemQuantity.text = [NSString stringWithFormat:@"%.2f",item.Quantity.floatValue];
    self.itemUOM.text = item.UoM;
    self.itemNetPrice.text = [NSString stringWithFormat:@"%.2f",item.NetPrice.floatValue];
    self.itemTotalPrice.text = [NSString stringWithFormat:@"%.2f",item.NetValue.floatValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
