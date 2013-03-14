//
//  RecentDocumentsViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewController.h"

@interface RecentDocumentsViewController : UIViewController
- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;

@end
