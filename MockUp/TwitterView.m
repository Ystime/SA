//
//  TwitterView.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "TwitterView.h"

@implementation TwitterView
NSArray *tweets;
NSMutableDictionary *twitPics;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)getTweets
{
    tweets = nil;
    tweets = [[NSMutableArray alloc]init];
    
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 
                 NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
//                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json?q=%23freebandnames"];
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"20" forKey:@"count"];
                 [parameters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      tweets  = [NSJSONSerialization
                                 JSONObjectWithData:responseData
                                 options:NSJSONReadingMutableLeaves
                                 error:&error];
                      
                      if (tweets.count != 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self.tweetTable reloadData];
                              [self performSelectorInBackground:@selector(loadPictures) withObject:nil];
                          });
                      }
                      
                  }];
             }
         } else {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Twitter Account!" message:@"To show actual tweets a twitter account has to be set on your device!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alert show];
         }
     }];    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    
    TweetCell *cell = [self.tweetTable
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TweetCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else{
        cell.UserImage.image = [UIImage imageNamed:@"twitter.png"];
    }
    
    NSDictionary *tweet = tweets[[indexPath row]];
    
    cell.TweetView.text = tweet[@"text"];
    NSString *user = [NSString stringWithFormat:@"@%@",[[tweet objectForKey:@"user"] objectForKey:@"screen_name"]];
    cell.UserField.text = user;
    UIImage *temp = [GlobalFunctions loadImage:[[tweet objectForKey:@"user"] objectForKey:@"screen_name"]];
    cell.UserImage.image = temp;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}


#pragma mark - Load pictures twitteraars

-(void)loadPictures
{
    for(int i = 0;i<tweets.count;i++)
    {
        NSDictionary *tweet = tweets[i];
        NSString *user = [[tweet objectForKey:@"user"] objectForKey:@"screen_name"];
        UIImage *temp = [GlobalFunctions loadImage:user];

        if(temp == nil)
        {
            NSURL *picURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1/users/profile_image?screen_name=%@&size=bigger",user]];
            NSData *picData = [NSData dataWithContentsOfURL:picURL];
            UIImage *pic = [UIImage imageWithData:picData];
            [GlobalFunctions saveImage:pic withName:user];
        }
    }
    [self.tweetTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
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
