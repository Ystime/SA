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
int indexPic = -1;

typedef enum swipeDir {kLeft,kRight}swipeDir;

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
    //Remove remaining 'self' observers
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(picturesProcessed:) name:kPicturesProcesssed object:nil];
    [UIView changeLayoutToDefaultProjectSettings:self.view];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload
{
    NSLog(@"VIEW IS REMOVED");
}

-(void)dealloc
{
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
    if(indexPath.row < keys.count)
    {
        Cell.thumbLabel.text = [GlobalFunctions getTitleFromKeyword:keys[indexPath.row]];
        Cell.thumbPic.image = [UIImage makeRoundedImage:[picDic objectForKey:keys[indexPath.row]] radius:8.0];
    }
    else //Create the Add Cell
    {
        Cell.thumbLabel.text = @"Add new Picture";
        Cell.thumbPic.image = [UIImage makeRoundedImage:[UIImage imageNamed:@"add_photo.png"] radius:8.0];
    }
    Cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    Cell.layer.cornerRadius = 8.0;

    return Cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return keys.count+1;
}

#pragma mark - Collection DataSource

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.selectLabel.hidden && indexPath.row !=keys.count)
       [self.selectLabel setHidden:YES];
    if(indexPath.row < keys.count)
    {
        indexPic = indexPath.row;
        thumbCell *temp = (thumbCell*)[thumbCollection cellForItemAtIndexPath:indexPath];
        self.mainPicture.image =  [UIImage makeRoundedImage:temp.thumbPic.image radius:16.0];
        thumbCell *cell = (thumbCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.layer.borderWidth = 2.0;
    }
    else //Add cell was selected
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera] == NO)
            return ;
        UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        cameraUI.allowsEditing = NO;
        cameraUI.delegate = (CustomerViewController*)self.parentViewController;
        [self.parentViewController presentViewController:cameraUI animated:YES completion:nil];
    }

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
    if([notification.userInfo objectForKey:kResponseError])
    {
        
    }
    else
    {
        picDic = [notification.userInfo objectForKey:kResponseItems];
        [self showPicturesfromDictionary:picDic];
    }
}

-(void)showPVCWithPictureForKey:(NSString*)picKey
{
    self.selectLabel.hidden = YES;
    self.mainPicture.image = [UIImage makeRoundedImage:[picDic objectForKey:picKey] radius:16.0];
    if(thumbCollection.indexPathsForSelectedItems.count >0)
        [self collectionView:thumbCollection didDeselectItemAtIndexPath:thumbCollection.indexPathsForSelectedItems[0]];
    indexPic = [keys indexOfObject:picKey];
    NSIndexPath *path =[NSIndexPath indexPathForRow:indexPic inSection:0];
    [thumbCollection selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];    
}
- (IBAction)swipeRight:(id)sender {
    NSLog(@"LEFT SWIPE!");
    if(indexPic-1 >-1)
    {
        [self showPVCWithPictureForKey:keys[indexPic-1]];
    }
}
- (IBAction)swipeLeft:(id)sender {
        NSLog(@"RIGHT SWIPE!");
    if(indexPic+1 < keys.count)
    {
        [self showPVCWithPictureForKey:keys[indexPic+1]];
    }
}

@end
