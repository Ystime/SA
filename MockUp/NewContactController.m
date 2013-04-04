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
bool scanFlag,pictureFlag;
UIImage *contactImage;

@synthesize editContact,relBUPA;
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
    self.ContactImage.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.ContactImage.layer.borderWidth = 1.0;
    
    if(editContact)
    {
        for(UITextField *tf  in self.InputFieldCollection)
        {
            tf.enabled = NO;
        }
        [self setupLabels:editContact];
        [self.saveButton setTitle:@"Update" forState:UIControlStateNormal];
        self.saveButton.hidden = self.scanButton.hidden = YES;
    }
    else
    {
        self.saveButton.hidden = self.scanButton.hidden = NO;
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        editContact = [[ContactPerson alloc]init];
        editContact.PhoneNumber = [[Phone alloc]init];
        editContact.FaxNumber = [[Phone alloc]init];
        editContact.Email = [[URI alloc]init];
        editContact.Website = [[URI alloc]init];
    }
    scanFlag = NO;
    pictureFlag = NO;
}

-(void)setupLabels:(ContactPerson*)cp
{
    for(UITextField *input in self.InputFieldCollection)
    {
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
            [self saveContactPerson];
            break;
        case 2:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 3:
        {
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera] == NO)
                return ;
            UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
            cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            cameraUI.allowsEditing = NO;
            cameraUI.delegate = self;
            [self presentViewController:cameraUI animated:YES completion:^{scanFlag = NO;pictureFlag = YES;}];
        }
            break;
        default:
            break;
    }
}
- (IBAction)scanBusinessCard:(id)sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    scanFlag = YES;
    pictureFlag = NO;
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    if(scanFlag)
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
            [self dismissViewControllerAnimated:YES completion:^{scanFlag = NO;}];
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
    else if (pictureFlag)
    {
        UIImage *capturedImage = (UIImage *) [info objectForKey:
                                              UIImagePickerControllerOriginalImage];
        contactImage = [UIImage imageWithImage:capturedImage scaledToSize:CGSizeMake(640, 480)];
        self.ContactImage.image = contactImage;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        
    }
    
    pictureFlag = scanFlag = NO;
    
}

-(void)fillInContactInformation:(NSArray *)details
{
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

-(void)saveContactPerson
{
    for(UITextField *input in self.InputFieldCollection)
    {
        switch (input.tag) {
            case 1:
                editContact.Gender = input.text;
                break;
            case 2:
                editContact.FirstName = input.text;
                break;
            case 3:
                editContact.LastName = input.text;
                break;
            case 4:
                editContact.Email.URL =  input.text;
                break;
            case 5:
                editContact.PhoneNumber.PhoneNumber = input.text;
                break;
            case 6:
                editContact.PhoneNumber.PhoneNumber = input.text;
                break;
            default:
                break;
        }
    }
    
    editContact.RelatedPartnerID = self.relBUPA.BusinessPartnerID;
    editContact.ContactPersonID = @" ";
    
    if([editContact.LastName isEqualToString:@""]|| [editContact.FirstName isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Name" message:@"First and last name are required!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upload Failure" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        ContactPerson *success = [[RequestHandler uniqueInstance]createContactPerson:editContact forBusinessPartner:relBUPA];
        if(success && !(self.ContactImage.image == nil))
        {
            BusinessPartner *temp = relBUPA;
//            NSString *slug = [NSString stringWithFormat:@"Keyword='Passphoto',RelatedID='%@',Source='MediaForContactPerson',MediaType='Attachment',Filename='PassPhotoOf_%@.jpeg'",success.ContactPersonID,success.FullName];
            NSString *slug = [NSString stringWithFormat:@"Keyword='Passphoto',RelatedID='%@',Source='MediaForContactPerson',MediaType='Attachment'",success.ContactPersonID];
            if([[RequestHandler uniqueInstance]uploadPicture:self.ContactImage.image forSlug:slug])
            {
                [self dismissViewControllerAnimated:YES completion:^{
                    [[RequestHandler uniqueInstance]loadContacts:temp];
                }];
            }
            else
            {
                alert.message =@"Could not save picture. Contact details are saved!";
                [alert show];
            }
        }
        else
        {
            alert.message =@"Could not save contact person";
            [alert show];
        }
    }
    
}
@end
