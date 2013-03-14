//
//  NewContactController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"
#import "ZBarSDK.h"

@interface NewContactController : UIViewController <ZBarReaderDelegate>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *ViewCollection;
- (IBAction)clickedButton:(id)sender;
@property ContactPerson *editContact;
@property (strong, nonatomic) IBOutlet UIImageView *ContactImage;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *InputFieldCollection;
- (IBAction)scanBusinessCard:(id)sender;

@end
