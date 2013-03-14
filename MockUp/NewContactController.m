//
//  NewContactController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "NewContactController.h"

@interface NewContactController ()

@end

@implementation NewContactController
@synthesize editContact;
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
	// Do any additional setup after loading the view.
    for(UIView *temp  in self.ViewCollection)
    {
        temp.layer.cornerRadius = 8.0;
        temp.layer.masksToBounds = YES;
        
    }
    if(editContact)
    {
        [self setupLabels:editContact];
    }
    else
    {

    }
}

-(void)setupLabels:(ContactPerson*)cp
{
    for(UITextField *input in self.InputFieldCollection)
    {
        input.enabled = NO;
        switch (input.tag) {
            case 1:
                input.text = cp.Gender;
                break;
            case 2:
                input.text = cp.FirstName;
                break;
            case 3:
                input.text = cp.LastName;
                break;
            case 4:
                input.text = cp.Email.URL;
                break;
            case 5:
                input.text = cp.PhoneNumber.PhoneNumber;
                break;
            case 6:
                input.text = cp.PhoneNumber.PhoneNumber;
                break;
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setViewCollection:nil];
    [super viewDidUnload];
}
- (IBAction)clickedButton:(id)sender {
    switch ([sender tag]) {
        case 1:
            break;
        case 2:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 3:
            break;
        default:
            break;
    }
}
- (IBAction)scanBusinessCard:(id)sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSString *temp = symbol.data;
    NSArray *splitDetails = [temp componentsSeparatedByString:@"\n"];
    if([[splitDetails objectAtIndex:0]isEqualToString:@"BEGIN:VCARD"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self fillInContactInformation:splitDetails];
        
    }
    else
    {
        LGViewHUD *hud = [[LGViewHUD alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
        hud.topText = @"QR vCard";
        hud.bottomText = @"not recognized!";
        hud.image = [UIImage imageNamed:@"unknown.png"];
        [hud showInView:reader.view];
    }
    
    NSLog(@"%@",symbol.data);
}

-(void)fillInContactInformation:(NSArray *)details
{
    editContact = [[ContactPerson alloc]initWithSDMDictionary:nil];
    for(NSString *detail in details)
    {
        if ([detail hasPrefix:@"N:"])
        {
            NSString *detailName = [detail substringFromIndex:2];
            NSArray *names = [detailName componentsSeparatedByString:@";"];
            if(names.count ==2)
            {
                editContact.FirstName = [names objectAtIndex:1];
                editContact.LastName = [names objectAtIndex:0];
            }
            else if (names.count == 1)
                editContact.LastName = [names objectAtIndex:0];
        }
        else if([detail hasPrefix:@"TEL"])
        {
            NSArray *names = [detail componentsSeparatedByString:@":"];
            editContact.PhoneNumber.PhoneNumber = names.lastObject;
        }
        else if ([detail hasPrefix:@"EMAIL"])
        {
            NSArray *names = [detail componentsSeparatedByString:@":"];
            editContact.Email.URL = names.lastObject;
        }
    }
    [self setupLabels:editContact];
}
@end
