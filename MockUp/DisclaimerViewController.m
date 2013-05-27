//
//  TestViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DisclaimerViewController.h"


@interface DisclaimerViewController ()

@end

@implementation DisclaimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.Disclaimer.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    self.Disclaimer.layer.borderWidth = 1.0;
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self checkAvailability];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)checkAvailability
{
    if([SettingsUtilities getDemoStatus])
    {
        self.ECCStatus.image =  self.GWStatus.image = [UIImage imageNamed:@"Status_Green.png"];
        return;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://knowledge.nl4b.com"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSHTTPURLResponse *temp = (NSHTTPURLResponse*)urlResponse;
    if(!temp)
       self.ECCStatus.image =  self.GWStatus.image = [UIImage imageNamed:@"Status_Red.png"];
    else
    {
        if(temp.statusCode == 500)
            self.ECCStatus.image =  self.GWStatus.image = [UIImage imageNamed:@"Status_Green.png"];
        else
            self.ECCStatus.image =  self.GWStatus.image = [UIImage imageNamed:@"Status_Orange.png"];
    }

}
@end
