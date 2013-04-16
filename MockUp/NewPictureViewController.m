//
//  NewPictureViewController.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 15-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "NewPictureViewController.h"

@interface NewPictureViewController ()

@end

@implementation NewPictureViewController
@synthesize takenPicture,uploadSign;
NSArray *categories;
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
    for(UIView *view in self.views)
    {
        [UIView changeLayoutToDefaultProjectSettings:view];
    }
    categories = [NSArray arrayWithObjects:@"Store Front",@"Promotion Place",@"Loading Point",@"Product Placement",@"None",nil];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.Image.image = takenPicture;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedSave:(id)sender {
    int selectedRow = [self.CategoryPicker selectedRowInComponent:0];
    NSString *temp = categories[selectedRow];
    NSString *keyWord;
    if(selectedRow <(categories.count-1))
        keyWord = [NSString stringWithFormat:@"%@_%%_%@_%%_%@",temp,self.TitleField.text,[NSDate date]];
    else
        keyWord = [NSString stringWithFormat:@"%@_%%_%@",self.TitleField.text,[NSDate date]];

    NSString *slug = [NSString stringWithFormat:@"Keyword='%@',RelatedID='%@',Source='MediaForBusinessPartner',MediaType='Attachment',Filename='PhotoTakenOn:%@.jpeg'",keyWord,self.bupa.BusinessPartnerID,[NSDate date]];
    [self.saveBtn setHidden:YES];
    [uploadSign startAnimating];
    [self performSelectorInBackground:@selector(uploadPictureWithSlug:) withObject:slug];

}

-(void)uploadPictureWithSlug:(NSString*)slug
{
    if([[RequestHandler uniqueInstance]uploadPicture:takenPicture forSlug:slug])
    {
        [self dismissViewControllerAnimated:YES completion:^{
            [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadImagesforBusinessPartner:) withObject:self.bupa];
        }];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upload Failed" message:@"The upload of the taken picture failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    [self.saveBtn setHidden:NO];
    [uploadSign stopAnimating];
}
- (IBAction)clickedCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Picker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return categories.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return categories[row];
}
@end
