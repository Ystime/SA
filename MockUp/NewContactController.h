//
//  NewContactController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"
#import "ZBarSDK.h"

@interface NewContactController : UIViewController <ZBarReaderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
- (IBAction)clickedButton:(id)sender;
@property ContactPerson *editContact;
@property BusinessPartner *relBUPA;
@property UIImage *passphoto;
@property (strong, nonatomic) IBOutlet UIImageView *ContactImage;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *InputFieldCollection;
- (IBAction)scanBusinessCard:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *GenderControl;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *savingIndicator;

@end
