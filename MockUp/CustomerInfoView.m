//
//  CustomerInfoView.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 22-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "CustomerInfoView.h"

@implementation CustomerInfoView

-(void)viewDidLoad
{
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    
}

-(void)setBUPA:(BusinessPartner*)bupa
{
    self.name.text = bupa.BusinessPartnerName;
    self.street.text = [NSString stringWithFormat:@"%@ %@",bupa.Address.Street,bupa.Address.HouseNumber];
    self.zip.text = [NSString stringWithFormat:@"%@ %@",bupa.Address.PostalCode,bupa.Address.City];
    self.phone.text = [NSString stringWithFormat:@"Phone: %@",bupa.PhoneNumber.PhoneNumber];
    self.URL.text =[NSString stringWithFormat:@"Homepage:\n www.nu.nl%@",bupa.Website.URL];
    
    /*Loading the images for the customer*/
//    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"twitter.png"],[UIImage imageNamed:@"searchglass_icon.png"],[UIImage imageNamed:@"home_icon.png"],[UIImage imageNamed:@"send-email.png"], nil];
//    self.imageBUPA.animationImages = images;
//    self.imageBUPA.animationRepeatCount = 0;
//    self.imageBUPA.animationDuration = 2;
//    [self.imageBUPA startAnimating];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
