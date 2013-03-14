//
//  TweetCell.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell
@synthesize TweetView,UserField,UserImage;

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

-(void)setPicture
{
    NSURL *picURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1/users/profile_image?screen_name=%@&size=bigger",UserField.text]];
    NSData *picData = [NSData dataWithContentsOfURL:picURL];
    UserImage.image = [UIImage imageWithData:picData];

}

@end
