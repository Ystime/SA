//
//  PictureView.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-03-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"
#import "AFOpenFlowView.h"
#import "CustomerOverViewController.h"

@interface PictureView : UIView <AFOpenFlowViewDelegate>
@property CustomerViewController *cvc;
@property IBOutlet UILabel *picName;
-(void)showPictures;
@end
