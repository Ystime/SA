//
//  MainViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GlobalFunctions.h"
#import "CustomerCell.h"
#import "CustomerAnnotation.h"
#import "ExtrasViewController.h"
#import "AFOpenFlowView.h"
#import "GooglePlacesSearchParser.h"
#import "DetailViewController.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "CustomerViewController.h"
#import "DemoBUPA.h"
@class ExtrasView;

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,UITextFieldDelegate,AFOpenFlowViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *CustomerTable;
@property (strong, nonatomic) IBOutlet UITextField *CustomerSearchField;
@property (strong, nonatomic) IBOutlet UITextField *ProspectSearchField;
@property (strong, nonatomic) IBOutlet UIView *FlowView;
@property (strong, nonatomic) IBOutlet UIView *ActionView;
@property (strong, nonatomic) IBOutlet UIView *NewProductsView;
@property (strong, nonatomic) IBOutlet UIButton *MapTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *MyPositionButton;
@property (strong, nonatomic) IBOutlet StyledPullableView *ExtrasView;
@property (strong, nonatomic) IBOutlet ExtrasView *ExtrasSubView;
@property (strong, nonatomic) IBOutlet UIImageView *filterImage;
@property (strong, nonatomic) IBOutlet UIView *FilterIconView;
@property (strong, nonatomic) IBOutlet UILabel *FlowLabel;
@property (strong, nonatomic) IBOutlet UILabel *handleLabel;
@property (strong, nonatomic) IBOutlet UILabel *filterHandle;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingParents;

/*Public objects of this class*/
@property (strong, nonatomic) NSMutableArray *BusinessPartners;
@property (strong, nonatomic) NSMutableArray *VisibleBusinessPartners;

- (IBAction)changeMapType:(id)sender;
- (IBAction)centerMyPosition:(id)sender;
- (IBAction)showExtras:(id)sender;
- (IBAction)clickedFilterIcon:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *shiftingViews;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *OwnView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *PullSubViews;

@property (strong, nonatomic) IBOutlet StyledPullableView *FilterPullView;

@end
