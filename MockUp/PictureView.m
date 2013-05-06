//
//  PictureView.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 07-03-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "PictureView.h"

@implementation PictureView
AFOpenFlowView *pictureFlow;
NSMutableArray *keys;
NSString *selectedKey;
@synthesize cvc,picName,loadingSign;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)showPictures
{
    if(cvc.bupaPictures)
    {
        [self showPicturesFromDictionary:cvc.bupaPictures];
        [loadingSign stopAnimating];
    }
    else
    {
        [loadingSign startAnimating];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(picturesProcessed:) name:kPicturesProcesssed object:nil];
}

-(void)picturesProcessed:(NSNotification*)notification
{
    [loadingSign stopAnimating];
    [self showPicturesFromDictionary:cvc.bupaPictures];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)showPicturesFromDictionary:(NSDictionary*)dic
{
    if(pictureFlow)
        [pictureFlow removeFromSuperview];
    pictureFlow = [[AFOpenFlowView alloc]initWithFrame:CGRectMake(0, 0, 359, 321)];
    
    keys = [NSMutableArray arrayWithArray:dic.allKeys];
    pictureFlow.numberOfImages = keys.count+1;
    pictureFlow.viewDelegate = self;
    for(int i = 0;i<keys.count;i++)
    {
        UIImage *temp = [dic objectForKey:keys[i]];
        temp = [UIImage imageWithImage:temp scaledToSize:CGSizeMake(200, 200)];
        [pictureFlow setImage:temp forIndex:i];
    }
    [pictureFlow setImage:[UIImage imageWithImage:[UIImage imageNamed:@"add_photo.png"] scaledToSize:CGSizeMake(200, 200)] forIndex:keys.count];
    if(!keys)
        keys = [NSMutableArray arrayWithObject:@"Add Picture"];
    else
        [keys insertObject:@"Add Picture" atIndex:keys.count];
    [self addSubview:pictureFlow];
    [self openFlowView:pictureFlow selectionDidChange:0];
    if(keys.count >0)
    {
        UITapGestureRecognizer *tapPic = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picViewTapped)];
        tapPic.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapPic];
    }
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    selectedKey = keys[index];
    picName.text =[GlobalFunctions getTitleFromKeyword:selectedKey];
}

-(void)picViewTapped
{
    if([picName.text isEqualToString:keys.lastObject])
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera] == NO)
            return ;
        UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;

        cameraUI.allowsEditing = NO;
        cameraUI.delegate = cvc;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(picturesProcessed:) name:kPicturesProcesssed object:nil];
        [self.cvc presentViewController:cameraUI animated:YES completion:nil];
    }
    else
        [cvc showPictureViewForKey:selectedKey];
}

@end
