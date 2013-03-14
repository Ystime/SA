//
//  AlertCell.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "AlertCell.h"

@implementation AlertCell
@synthesize alertText,alertIcon;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
