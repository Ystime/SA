//
//  TestViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"

@interface DisclaimerViewController : UIViewController
- (IBAction)doneClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *GWStatus;
@property (strong, nonatomic) IBOutlet UIImageView *ECCStatus;
@property (strong, nonatomic) IBOutlet UITextView *Disclaimer;

@end
