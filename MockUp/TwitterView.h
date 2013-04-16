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
#import "TwitterSearcher.h"


@interface TwitterView : UIView <UITableViewDelegate,UITableViewDataSource>

-(void)getTweets:(BusinessPartner*)bupa;
@property (strong)IBOutlet UITableView *tweetTable;
@property (strong)IBOutlet UILabel *errorLabel;
@property (strong, nonatomic)NSString *searchTerm;
@property (strong, nonatomic)TwitterSearcher *searcher;
@end
