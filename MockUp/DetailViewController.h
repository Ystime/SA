//
//  DetailViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 11-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GlobalFunctions.h"
#import "SuspectAnnotation.h"
#import "GooglePlacesDetail.h"
#import "LGViewHUD.h"
@class MainViewController;
@interface DetailViewController : UIViewController <UIAlertViewDelegate>

/*Outlet Collection*/
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *views;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *TextFieldCollection;

/*Single Outlets*/
@property (strong, nonatomic) IBOutlet UITextField *CompanyField;
@property (strong, nonatomic) IBOutlet UITextField *StreetField;
@property (strong, nonatomic) IBOutlet UITextField *HouseNumberField;
@property (strong, nonatomic) IBOutlet UITextField *ZipField;
@property (strong, nonatomic) IBOutlet UITextField *CityField;
@property (strong, nonatomic) IBOutlet UITextField *PhoneField;
@property (strong, nonatomic) IBOutlet UITextField *EmailField;
@property (strong, nonatomic) IBOutlet UITextField *URLField;
@property (strong, nonatomic) IBOutlet UITextField *TwitterField;
@property (strong, nonatomic) IBOutlet UITextField *HashtagField;
@property (strong, nonatomic) IBOutlet UIButton *ProspectButton;
@property (strong, nonatomic) IBOutlet UIButton *CompetitorButton;
@property (strong, nonatomic) IBOutlet UILabel *SaveAsLabel;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;

/*Objects*/
@property (strong, nonatomic) SuspectAnnotation *prospect;
@property (strong, nonatomic) BusinessPartner *bupa;
@property (strong, nonatomic) MainViewController *mvc;

/*Button actions*/
- (IBAction)clickedCancel:(id)sender;
- (IBAction)saveAs:(id)sender;



@end
