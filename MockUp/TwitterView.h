//
//  TwitterView.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TweetCell.h"
#import "GlobalFunctions.h"



@interface TwitterView : UIView <UITableViewDelegate,UITableViewDataSource>

-(void)getTweets;
@property (strong)IBOutlet UITableView *tweetTable;

@end
