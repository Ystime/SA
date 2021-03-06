//
//  CustomerViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"
@class CustomerOverViewController;
#import "DocumentViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "StyledPullableView.h"
#import "NewContactController.h"
#import "PictureViewController.h"
#import "SalesOverViewController.h"
#import "NewTextController.h"
#import "NewPictureViewController.h"
#import "MainViewController.h"

@interface CustomerViewController : UIViewController<PullableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

/*Variable Objects*/
@property (strong, nonatomic) BusinessPartner *selectedBusinessPartner;
@property MainViewController *mvc;
@property (strong, nonatomic) NSMutableArray *SalesDocuments;
@property (strong, nonatomic) NSMutableArray *SDItems;
@property (strong, nonatomic) NSMutableArray *materials;
@property (strong, nonatomic) NSMutableDictionary *bupaPictures;
@property (strong, nonatomic) NSMutableDictionary *notes;
@property (strong, nonatomic) NSDictionary *materialPictures;
@property (strong) UIImage *bupaLogo;

/*Flags*/
@property BOOL creatingDoc;
@property  BOOL documentsLoaded;

extern NSString * const kCVCLoadedDocs;

/*Outlets*/
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet StyledPullableView *PullUpView;
@property (strong, nonatomic) IBOutlet UIView *InsidePullView;
@property (strong, nonatomic) IBOutlet UILabel *PullHandle;



/*Outlet collections*/
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *TopButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *BottomButtons;


/*IBActions*/
- (IBAction)clickedTab:(id)sender;
- (IBAction)clickedBottomButton:(id)sender;

/*Functions*/
-(void)showDocumentViewWithSalesDocument:(SalesDocument*)sd;
-(void)showPictureViewForKey:(NSString*)key;
-(void)setViewInContainer:(UIViewController*)newViewController;


@end
