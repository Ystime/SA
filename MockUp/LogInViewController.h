//
//  ViewController.h
//  Sales Rep App
//
//  Created by Administrator on 1/8/13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GlobalFunctions.h"
#import "LGViewHUD.h"

@interface LogInViewController : UIViewController <UIAlertViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *VersionLabel;
- (IBAction)logIn:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *Views;
@property (strong, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *GoButton;

@end
