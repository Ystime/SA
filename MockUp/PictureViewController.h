//
//  PictureViewController.h
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 22-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "thumbCell.h"
#import "CustomerViewController.h"

@interface PictureViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UIImageView *mainPicture;
@property (strong, nonatomic) IBOutlet UILabel *mainPictureTitle;
@property (strong, nonatomic) IBOutlet UICollectionView *thumbCollection;
-(void)showPVCWithPictureForKey:(NSString*)picKey;

@end
