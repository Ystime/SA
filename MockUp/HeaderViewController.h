//
//  HeaderViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 19-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewController.h"
@interface HeaderViewController : UITableViewController
- (IBAction)topButtonClicked:(id)sender;
@property (strong,nonatomic)SalesDocument *sd;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *Labels;
@property (strong, nonatomic) IBOutlet UITextField *POField;
@property (strong, nonatomic) IBOutlet UIDatePicker *DlvDatePicker;
-(void)setNDVC:(UIViewController*)nv;
@end
