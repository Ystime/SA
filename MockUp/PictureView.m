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
NSArray *keys;
@synthesize cvc,picName;
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
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(picturesProcessed:) name:kPicuresProcesssed object:nil];
}

-(void)picturesProcessed:(NSNotification*)notification
{
    NSError *error = [notification.userInfo objectForKey:kResponseError];
    if(error)
    {
        
    }
    else
    {
        [self showPicturesFromDictionary:[notification.userInfo objectForKey:kResponseItems]];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)showPicturesFromDictionary:(NSDictionary*)dic
{
    if(pictureFlow)
        [pictureFlow removeFromSuperview];
    pictureFlow = [[AFOpenFlowView alloc]initWithFrame:CGRectMake(0, 0, 359, 321)];
    keys = dic.allKeys;
    pictureFlow.numberOfImages = keys.count;
    pictureFlow.viewDelegate = self;
    for(int i = 0;i<keys.count;i++)
    {
        UIImage *temp = [dic objectForKey:keys[i]];
        temp = [UIImage imageWithImage:temp scaledToSize:CGSizeMake(200, 200)];
        [pictureFlow setImage:temp forIndex:i];
    }
    [self addSubview:pictureFlow];
    [pictureFlow setSelectedCover:0];
    self.picName.text = keys[0];
    if(keys.count >0)
    {
        UITapGestureRecognizer *tapPic = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picViewTapped)];
        tapPic.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tapPic];
    }
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    picName.text = keys[index];
}

-(void)picViewTapped
{
    [cvc showPictureViewForKey:self.picName.text];
}

@end
