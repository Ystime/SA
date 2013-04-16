//
//  NewPictureViewController.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 15-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"

@interface NewPictureViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *Image;
@property (strong, nonatomic) IBOutlet UITextField *TitleField;
@property (strong, nonatomic) IBOutlet UIPickerView *CategoryPicker;
@property (strong)UIImage *takenPicture;
- (IBAction)clickedSave:(id)sender;
- (IBAction)clickedCancel:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *views;
@property (strong) BusinessPartner *bupa;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *uploadSign;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@end
