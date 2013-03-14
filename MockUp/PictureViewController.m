//
//  PictureViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 22-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()
@property (strong, nonatomic) IBOutlet UILabel *selectLabel;

@end

@implementation PictureViewController
@synthesize mainPicture,thumbCollection;
NSDictionary *picDic;
NSArray *keys;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    keys = [NSArray array];
    picDic = [NSDictionary dictionary];
    CustomerViewController *cvc = (CustomerViewController*)self.parentViewController;
    picDic = cvc.bupaPictures;
    if(picDic)
        [self showPicturesfromDictionary:picDic];
    else
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(picturesProcessed:) name:kPicuresProcesssed object:nil];
    

    [UIView changeLayoutToDefaultProjectSettings:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Collection DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"thumb";
    thumbCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(Cell == nil)
    {
        Cell = [[thumbCell alloc]init];
    }
    Cell.thumbLabel.text = keys[indexPath.row];
    Cell.thumbPic.image = [UIImage makeRoundedImage:[picDic objectForKey:keys[indexPath.row]] radius:8.0];
    Cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    Cell.layer.cornerRadius = 8.0;

    return Cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return keys.count;
}

#pragma mark - Collection DataSource

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.selectLabel.hidden)
       [self.selectLabel setHidden:YES];
    thumbCell *temp = (thumbCell*)[thumbCollection cellForItemAtIndexPath:indexPath];
    self.mainPicture.image =  [UIImage makeRoundedImage:temp.thumbPic.image radius:16.0];
    thumbCell *cell = (thumbCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderWidth = 2.0;

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    thumbCell *cell = (thumbCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderWidth = 0.0;

}

-(void)showPicturesfromDictionary:(NSDictionary*)dic
{
    picDic = dic;
    keys = [picDic allKeys];
    if(keys.count == 0)
        self.selectLabel.text =@"No pictures were found for this customer!";
    [thumbCollection reloadData];
    
}

-(void)picturesProcessed:(NSNotification*)notification
{
    picDic = notification.userInfo;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self showPicturesfromDictionary:picDic];
}

-(void)showPVCWithPictureForKey:(NSString*)picKey
{
    self.selectLabel.hidden = YES;
    self.mainPicture.image = [UIImage makeRoundedImage:[picDic objectForKey:picKey] radius:16.0];
    if(thumbCollection.indexPathsForSelectedItems.count >0)
        [self collectionView:thumbCollection didDeselectItemAtIndexPath:thumbCollection.indexPathsForSelectedItems[0]];
    int row = [keys indexOfObject:picKey];
    NSIndexPath *path =[NSIndexPath indexPathForRow:row inSection:0];
    [thumbCollection selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];    
}
@end
