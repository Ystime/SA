//
//  InfoViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 11-03-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerViewController.h"

@interface InfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *CompanyImage;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *AddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *ZipLabel;
@property (strong, nonatomic) IBOutlet UILabel *PhoneLabel;
@property (strong, nonatomic) IBOutlet UITextView *URLView;
-(void)setBupa:(BusinessPartner *)_bupa;

@end