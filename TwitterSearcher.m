//
//  TwitterSearcher.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 12-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "TwitterSearcher.h"
#import "JSON.h"

@implementation TwitterSearcher
- (void)grabData:(BusinessPartner *)selectedBupa
{
    // Setup an error to catch stuff in
	NSError *error = NULL;
	

    
    // Build the string to search against the twitter search api
    NSString *fromString = selectedBupa.Twitter.LongURL;        
    if(!(fromString == nil || [fromString isEqualToString:@""]))
        fromString = [NSString stringWithFormat:@"from:%@",fromString];
    else
        fromString = selectedBupa.BusinessPartnerName;
    NSString *urlString = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@&rpp=50&lang=nl",[self changeStringForSearch:fromString]];
    
	NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *resultaat = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:resultaat encoding:NSUTF8StringEncoding];
    NSDictionary *results = [jsonString JSONValue];
    NSDictionary *tweets = [results objectForKey:@"results"];
	if(tweets) {
        NSDictionary *dictToBePassed = [NSDictionary dictionaryWithObject:tweets forKey:@"array"];
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter postNotificationName:@"twitterSearchDone"
										  object:nil
										userInfo:dictToBePassed];
	}
	else {
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter postNotificationName:@"twitterFail"
										  object:nil
										userInfo:nil];
	}
}

-(NSString*)changeStringForSearch:(NSString *)searchTerm
{
    NSError *error = NULL;

    //Create the regular expression to match against whitespace or % or ^
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\s|%|^)"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&error];
	
	//Create the regular expression to match against hash tags
	NSRegularExpression *regexHash = [NSRegularExpression regularExpressionWithPattern:@"#"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
	
	// create the new string by replacing the matching of the regex pattern with the template pattern(whitespace)
	NSString *tempString = [regex stringByReplacingMatchesInString:searchTerm options:0
                                                             range:NSMakeRange(0, [searchTerm length])
                                                      withTemplate:@"%20"];
	
	// create the new string by replacing the matching of the regex pattern with the template pattern(whitespace)
	NSString *hashTempString = [regexHash stringByReplacingMatchesInString:tempString options:0
                                                                     range:NSMakeRange(0, [searchTerm length])
                                                              withTemplate:@"%23"];
	return hashTempString;
}
@end
