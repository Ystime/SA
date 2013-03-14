//
//  TweetCell.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextView *TweetView;
@property (strong, nonatomic) IBOutlet UILabel *UserField;
@property (strong, nonatomic) IBOutlet UIImageView *UserImage;
-(void)setPicture;
@end
