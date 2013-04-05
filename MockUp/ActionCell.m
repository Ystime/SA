//
//  ActionCell.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 05-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "ActionCell.h"

@implementation ActionCell

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
