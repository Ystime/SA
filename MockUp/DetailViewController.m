//
//  DetailViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 11-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DetailViewController.h"
#import "MainViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize prospect,bupa,mvc;
LGViewHUD *createHUD;
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
    for(UIView *view  in self.views)
    {
        view.layer.cornerRadius = 8.0;
        view.layer.masksToBounds = YES;
        view.layer.borderWidth = 1.0;
        view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    }
    createHUD = [[LGViewHUD alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    createHUD.activityIndicatorOn = YES;
    createHUD.topText = @"Creating account";
    createHUD.bottomText = @"Please Wait!";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if(bupa != nil)
    {
        self.CompanyField.text  = bupa.BusinessPartnerName;
        self.StreetField.text = bupa.Address.Street;
        self.HouseNumberField.text = bupa.Address.HouseNumber;
        self.ZipField.text = bupa.Address.PostalCode;
        self.CityField.text = bupa.Address.City;
        self.PhoneField.text = bupa.PhoneNumber.PhoneNumber;
        self.EmailField.text = bupa.Email.URL;
        self.URLField.text = bupa.Website.URL;
        for(UITextField *tf in self.TextFieldCollection)
        {
            tf.enabled = NO;
        }
        self.SaveAsLabel.text = @"UPDATING NOT POSSIBLE YET!";
        self.TitleLabel.text = @"Update Existing Account";
        self.SaveAsLabel.textColor = [UIColor redColor];
        //self.CompetitorButton.hidden = YES;
        [self.ProspectButton setImage:nil forState:UIControlStateNormal];
        [self.ProspectButton setTitle:@"Update" forState:UIControlStateNormal];
        self.ProspectButton.tag = 3;
        [self.CompetitorButton setImage:nil forState:UIControlStateNormal];
        [self.CompetitorButton setTitle:@"Overview" forState:UIControlStateNormal];
        self.CompetitorButton.tag = 4;
        
    }
    else if (prospect !=nil)
    {
        self.TitleLabel.text = @"Create new account";
        GooglePlacesDetail *gpd = [[GooglePlacesDetail alloc]init];
        prospect = [gpd findDetails:prospect.reference];
        self.CompanyField.text  = [NSString stringWithFormat:@"%@ %@",prospect.name,prospect.city];
        self.StreetField.text = prospect.street;
        self.HouseNumberField.text = prospect.house_no;
        self.ZipField.text = prospect.postal;
        self.CityField.text = prospect.city;
        self.PhoneField.text = prospect.telephone;
        self.URLField.text = prospect.website;
    }
    else
    {
        
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    /*Clear all variables*/
    for(UITextField *tf in self.TextFieldCollection)
    {
        [tf setText:nil];
    }
    [self setProspect:nil];
    [self setBupa:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
    [self setViews:nil];
    [self setCompanyField:nil];
    [self setStreetField:nil];
    [self setHouseNumberField:nil];
    [self setZipField:nil];
    [self setCityField:nil];
    [self setPhoneField:nil];
    [self setEmailField:nil];
    [self setURLField:nil];
    [self setTextFieldCollection:nil];
    [self setProspectButton:nil];
    [self setCompetitorButton:nil];
    [self setSaveAsLabel:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}


- (IBAction)clickedCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAs:(id)sender
{
    if(bupa == nil)
    {
        bupa = [[BusinessPartner alloc]init];
        bupa.Address = [[Address alloc]init];
        bupa.Email = [[URI alloc]init];
        bupa.Website = [[URI alloc]init];
        bupa.Twitter =  [[URI alloc]init];
        bupa.PhoneNumber = [[Phone alloc]init];
        bupa.FaxNumber = [[Phone alloc]init];
        bupa.Address.GeoCode = [[GeoCode alloc]init];
        
    }
    bupa.BusinessPartnerName = self.CompanyField.text;
    bupa.Address.Street = self.StreetField.text;
    bupa.Address.HouseNumber = self.HouseNumberField.text;
    bupa.Address.PostalCode = self.ZipField.text;
    bupa.Address.City = self.CityField.text;
    bupa.PhoneNumber.PhoneNumber = self.PhoneField.text;
    bupa.Email.URL = self.EmailField.text;
    bupa.Website.URL = self.URLField.text;
    bupa.BusinessPartnerID = @"x";
    bupa.Address.CountryCodeISO = @"NL";
    bupa.Address.Country = @"NL";
    [createHUD showInView:self.view];
    switch ([sender tag]) {
        case 1:
            bupa.BusinessPartnerType = @"Prospect";
            break;
        case 2:
            bupa.BusinessPartnerType = @"Competitor";
            break;
        default:
            break;
    }
    [self createNewAccount:bupa];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"CustomerOverview"])
    {
        CustomerViewController *cvc = segue.destinationViewController;
        cvc.selectedBusinessPartner = bupa;
    }
}


-(void)createNewAccount:(BusinessPartner*)newBupa
{
    BusinessPartner* result = [[RequestHandler uniqueInstance]createBusinessPartner:newBupa];
    [createHUD hideWithAnimation:YES];
    
    UIAlertView *resultCreation;
    if(result)
    {
        resultCreation = [[UIAlertView alloc]initWithTitle:@"Creation succes!" message:@"Creation of new account completed!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        resultCreation.tag = 1;
    }
    else
    {
        resultCreation = [[UIAlertView alloc]initWithTitle:@"Creation failed!" message:@"Creation of new account failed!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        resultCreation.tag = 2;
    }
    [resultCreation show];
}

#pragma mark -  Alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1:
        {
            BusinessPartner *temp = bupa;
            [self dismissViewControllerAnimated:NO completion:
             ^{
                 [mvc performSegueWithIdentifier:@"CustomerOverview" sender:temp];
                 [[RequestHandler uniqueInstance]loadBusinessPartners];
             }
             ];
        }
            break;
        case 2:
//            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
    
}



@end
