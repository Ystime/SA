//
//  ProductCatalogViewController.h
//  Sales Around
//
//  Created by IJsbrand van Rijn on 17-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "MaterialCollectionCell.h"

@interface ProductCatalogViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *MaterialCollectionView;
@property MainViewController *mvc;
@property (strong, nonatomic) IBOutlet UIPickerView *GroupPicker;
- (IBAction)closeCatalog:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *Views;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingPicIV;
@property UIPopoverController *pop;
@end
