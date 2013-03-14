//
//  RecentDocumentsViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "RecentDocumentsViewController.h"

@interface RecentDocumentsViewController ()

@end

@implementation RecentDocumentsViewController

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
	// Do any additional setup after loading the view.
    for(UIView *view in self.ViewCollection)
    {
        [UIView changeLayoutToDefaultProjectSettings:view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
