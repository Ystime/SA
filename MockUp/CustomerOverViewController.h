//
//  CustomerOverViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 17-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import "GlobalFunctions.h"
#import "CustomerViewController.h"
#import "AFOpenFlowView.h"
#import "TwitterView.h"
#import "BWView.h"
#import "NoteView.h"
#import "InfoViewController.h"
@class PictureView;

@interface CustomerOverViewController : UIViewController<AFOpenFlowViewDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property (strong, nonatomic) IBOutlet UIView *ContactView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *contactLabels;
- (IBAction)sendEmail:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *EmailButton;
@property (strong, nonatomic) IBOutlet UILabel *NoContactsLabel;
@property (strong, nonatomic) IBOutlet TwitterView *TweetView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet PictureView *picView;
@property (strong, nonatomic)BusinessPartner *selectedBUPA;
@property (strong) CustomerViewController *cvc;

@end
