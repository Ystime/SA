//
//  MaterialCollectionCell.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 12-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "MaterialCollectionCell.h"

@implementation MaterialCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithMaterial:(Material*)material
{
    self = [super init];
    if (self) {
        [self setMaterial:material];
    }
    return self;
}


-(void)setMaterial:(Material*)material
{
    self.MaterialName.text = material.Description;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
