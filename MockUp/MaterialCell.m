//
//  MaterialCell.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 12-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "MaterialCell.h"

@implementation MaterialCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withMaterial:(Material*)material
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setMaterial:material];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMaterial:(Material*)material
{
    self.DescriptionView.text = material.Description;
    for(UILabel *label in self.Labels)
    {
        switch (label.tag) {
            case 1:
                label.text = material.MaterialNumber;
                break;
            case 2:
                label.text = material.EANCode;
                break;
            case 3:
                label.text = material.UoM;
                break;
            case 4:
                label.text = [NSString stringWithFormat:@"%i",material.MinimumOrderQuantity.integerValue];
                break;
            case 5:
                label.text = [NSString stringWithFormat:@"%.2f",material.Price.Price.floatValue];
                break;
            default:
                break;
        }
    }
}

@end
