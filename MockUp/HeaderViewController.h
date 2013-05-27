//
//  HeaderViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 19-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewController.h"
#import "SoldToController.h"
@interface HeaderViewController : UITableViewController<UITextFieldDelegate>
- (IBAction)topButtonClicked:(id)sender;
@property (strong,nonatomic)SalesDocument *sd;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *Labels;
@property (strong, nonatomic) IBOutlet UITextField *POField;
@property (strong, nonatomic) IBOutlet UIDatePicker *DlvDatePicker;
@property (strong, nonatomic) IBOutlet UILabel *ShipToLabel;
@property (strong, nonatomic) IBOutlet UILabel *CustomerLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *DoneButton;
@property DocumentViewController *ndvc;
@property UIPopoverController *upc;
@property BOOL cartMode;
@property (strong, nonatomic) IBOutlet UITableViewCell *CustomerCell;
-(void)setNDVC:(UIViewController*)nv;
-(void)refreshLabels;
@end
