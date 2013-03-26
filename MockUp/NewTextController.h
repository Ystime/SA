//
//  NewTextController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomerViewController.h"

@interface NewTextController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property CustomerViewController *cvc;
@property (strong, nonatomic) IBOutlet UITextView *NoteText;
@property (strong, nonatomic) IBOutlet UITextField *NoteTitle;
- (IBAction)clickedButton:(id)sender;

@end
