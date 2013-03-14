//
//  NewTextController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NewTextController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
- (IBAction)clickedButton:(id)sender;

@end
