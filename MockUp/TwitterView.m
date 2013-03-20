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
    [self storeAccountWithAccessToken:@"1150698265-fnX1ZkdQhuCyAkG07dpAH0pqgg718qMLmIiwRfs" secret:@"BVSK0AWdmXc8ywrFx79hWPaLXhRgDSP3bpYFZ8g"];
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount;
                 for(ACAccount *ac in arrayOfAccounts)
                 {
                     if([ac.username isEqualToString:@"ijvRijn"])
                     {
                         twitterAccount = ac;
                     }
                 }                 
                 NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
                 
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
                      NSLog(@"%i",urlResponse.statusCode);
                      if(!error && urlResponse.statusCode!=400)
                      {
                          tweets  = [NSJSONSerialization
                                     JSONObjectWithData:responseData
                                     options:NSJSONReadingMutableLeaves
                                     error:&error];
                          if (tweets.count > 1) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [self.tweetTable reloadData];
                                  [self performSelectorInBackground:@selector(loadPictures) withObject:nil];
                              });
                          }
                      }
                      else if (urlResponse.statusCode == 400)
                      {
                          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Check Credentials" message:@"Please check twitter credentials for user ijvrijn! (Password is 'scheerdemo')" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                          [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                      }
                      
                  }];
             }
         } else {
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
//
- (void)storeAccountWithAccessToken:(NSString *)token secret:(NSString *)secret
{
    ACAccountStore *_store = [[ACAccountStore alloc]init];
    //  Each account has a credential, which is comprised of a verified token and secret
    ACAccountCredential *credential =
    [[ACAccountCredential alloc] initWithOAuthToken:token tokenSecret:secret];
    
    //  Obtain the Twitter account type from the store
    ACAccountType *twitterAcctType =
    [_store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //  Create a new account of the intended type
    ACAccount *newAccount = [[ACAccount alloc] initWithAccountType:twitterAcctType];
    
    //  Attach the credential for this user
    newAccount.credential = credential;
    
    //  Finally, ask the account store instance to save the account
    //  Note: that the completion handler is not guaranteed to be executed
    //  on any thread, so care should be taken if you wish to update the UI, etc.
    [_store saveAccount:newAccount withCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            // we've stored the account!
            NSLog(@"the account was saved!");
        }
        else {
            //something went wrong, check value of error
            NSLog(@"the account was NOT saved");
            
            // see the note below regarding errors...
            //  this is only for demonstration purposes
            if ([[error domain] isEqualToString:ACErrorDomain]) {
                
                // The following error codes and descriptions are found in ACError.h
                switch ([error code]) {
                    case ACErrorAccountMissingRequiredProperty:
                        NSLog(@"Account wasn't saved because "
                              "it is missing a required property.");
                        break;
                    case ACErrorAccountAuthenticationFailed:
                        NSLog(@"Account wasn't saved because "
                              "authentication of the supplied "
                              "credential failed.");
                        break;
                    case ACErrorAccountTypeInvalid:
                        NSLog(@"Account wasn't saved because "
                              "the account type is invalid.");
                        break;
                    case ACErrorAccountAlreadyExists:
                        NSLog(@"Account wasn't added because "
                              "it already exists.");
                        break;
                    case ACErrorAccountNotFound:
                        NSLog(@"Account wasn't deleted because"
                              "it could not be found.");
                        break;
                    case ACErrorPermissionDenied:
                        NSLog(@"Permission Denied");
                        break;
                    case ACErrorUnknown:
                    default: // fall through for any unknown errors...
                        NSLog(@"An unknown error occurred.");
                        break;
                }
            } else {
                // handle other error domains and their associated response codes...
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    }];
}

@end
