//
//  InfoViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 11-03-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()
@end

@implementation InfoViewController
BusinessPartner *bupa;
NSString* prevID;
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
    [UIView changeLayoutToDefaultProjectSettings:self.view];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
        self.NameLabel.text = bupa.BusinessPartnerName;
        self.AddressLabel.text = bupa.Address.Street;
        self.ZipLabel.text = [NSString stringWithFormat:@"%@ %@",bupa.Address.PostalCode,bupa.Address.City];
        self.URLView.text = bupa.Website.URL;
    if ([bupa.BusinessPartnerName hasPrefix:@"Scheer"]) {
        self.CompanyImage.image = [UIImage imageNamed:@"Scheer.png"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBupa:(BusinessPartner *)_bupa
{
    bupa = _bupa;
}

@end
