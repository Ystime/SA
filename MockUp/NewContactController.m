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
NSString *role;
UIPopoverController *upc;
ZBarReaderViewController *reader;
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
    role = @"";
    self.ContactImage.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.ContactImage.layer.borderWidth = 1.0;
    
    if(editContact)
    {
        self.TitleLabel.text = @"Change contact details";
        for(UITextField *tf  in self.InputFieldCollection)
        {
            tf.enabled = NO;
        }
        [self setupLabels:editContact];
        [self.saveButton setTitle:@"Update" forState:UIControlStateNormal];
        self.GenderControl.userInteractionEnabled = NO;
        NSInteger gender = editContact.Gender.integerValue;
        if(gender ==1 )
        {
            self.GenderControl.selectedSegmentIndex = 0;
            [self.GenderControl setEnabled:NO forSegmentAtIndex:1];
        }
        else if(gender ==2)
        {
            self.GenderControl.selectedSegmentIndex = 1;
            [self.GenderControl setEnabled:NO forSegmentAtIndex:0];
        }
        self.ContactImage.image = self.passphoto;
        self.saveButton.hidden = self.scanButton.hidden = YES;
    }
    else
    {
        self.TitleLabel.text = @"Create new contact";
        self.saveButton.hidden = self.scanButton.hidden = NO;
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        editContact = [[ContactPerson alloc]init];
        editContact.PhoneNumber = [[Phone alloc]init];
        editContact.FaxNumber = [[Phone alloc]init];
        editContact.Email = [[URI alloc]init];
        editContact.Website = [[URI alloc]init];
        editContact.Twitter = [[URI alloc]init];
        self.GenderControl.userInteractionEnabled = YES;

    }
    scanFlag = NO;
    pictureFlag = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.saveButton.hidden = NO;
    [self.savingIndicator stopAnimating];
}

-(void)setupLabels:(ContactPerson*)cp
{
    for(UITextField *input in self.InputFieldCollection)
    {
        switch (input.tag) {
            case 1:
               input.text = cp.Function;
                break;
            case 2:
                input.text = cp.FirstName;
                break;
            case 3:
                input.text = cp.LastName;
                break;
            case 4:
                input.text = cp.Email.LongURL;
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
            self.saveButton.hidden = YES;
            [self.savingIndicator startAnimating];
            [self performSelectorInBackground:@selector(saveContactPerson) withObject:nil];
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
    reader = [ZBarReaderViewController new];

    reader.readerDelegate = self;
    reader.showsZBarControls = NO;
    reader.cameraOverlayView = [self setOverlayPickerView];
    scanFlag = YES;
    pictureFlag = NO;
    [self presentViewController:reader animated:YES completion:^{

    }];
}

- (UIView *)setOverlayPickerView{
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [v setBackgroundColor:[UIColor clearColor]];
    UIToolbar *myToolBar = [[UIToolbar alloc] init];
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissOverlayView:)];
    UIBarButtonItem *cameraButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePictureOfCard)];
    cameraButton.style = UIBarButtonItemStyleBordered;
//    UIBarButtonItem *fixed=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [myToolBar setItems:[NSArray arrayWithObjects:backButton,cameraButton,nil]];
    [myToolBar setBarStyle:UIBarStyleDefault];
    CGRect toolBarFrame;
    toolBarFrame = CGRectMake(0, 724, 1024, 44);
    [myToolBar setFrame:toolBarFrame];
    [v addSubview:myToolBar];
    return  v;
}

- (void)dismissOverlayView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)takePictureOfCard
{
    NSLog(@"It Works!");
    [reader takePicture];
    pictureFlag = YES;
    scanFlag  = NO;
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
            editContact.Email.LongURL = names.lastObject;
        }
        else if ([detail hasPrefix:@"ROLE"])
        {
            NSArray *names = [detail componentsSeparatedByString:@":"];
            editContact.Function = names.lastObject;
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
                editContact.Function = input.text;
                break;
            case 2:
                editContact.FirstName = input.text;
                break;
            case 3:
                editContact.LastName = input.text;
                break;
            case 4:
                editContact.Email.LongURL =  input.text;
                editContact.Email.URIType = @"smtp";
                break;
            case 5:
                editContact.PhoneNumber.PhoneNumber = input.text;
                editContact.PhoneNumber.PhoneType = @"landline";
                break;
            case 6:
//                editContact.Function = input.text;
                break;
            default:
                break;
        }
    }
    editContact.Gender = [NSString stringWithFormat:@"%i",self.GenderControl.selectedSegmentIndex+1];
    editContact.RelatedPartnerID = self.relBUPA.BusinessPartnerID;
    editContact.ContactPersonID = @" ";
    
    if([editContact.LastName isEqualToString:@""]|| [editContact.FirstName isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Name" message:@"First and last name are required!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    }
    else if(![self validateEmailAdress:editContact.Email.LongURL])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Email" message:@"Emailaddress is invalid! Use format john@smnl.nl!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upload Failure" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        ContactPerson *success = [[RequestHandler uniqueInstance]createContactPerson:editContact forBusinessPartner:relBUPA];
        if(success && !(self.ContactImage.image == nil))
        {
            BusinessPartner *temp = relBUPA;
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
                [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];;
            } 
        }
        else
        {
            [self performSelectorOnMainThread:@selector(saveCompleted) withObject:nil waitUntilDone:NO];
        }
    }
    self.saveButton.hidden = NO;
    [self.savingIndicator stopAnimating];
    
}

-(void)saveCompleted
{

    BusinessPartner *temp = relBUPA;
    [self dismissViewControllerAnimated:YES completion:^{
        [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadContacts:) withObject:temp];
    }];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag < self.InputFieldCollection.count)
    {
        for(UIView *view in self.InputFieldCollection)
        {
            if(view.tag == textField.tag+1)
                [view becomeFirstResponder];
        }
    }
    else
        [textField resignFirstResponder];
    return YES;
}

-(BOOL)validateEmailAdress:(NSString*)emailadres
{
    if([emailadres isEqualToString:@""] ||emailadres == nil)
        return YES;
    if([emailadres rangeOfString:@"@"].location == NSNotFound)
        return NO;
    NSArray *subs = [emailadres componentsSeparatedByString:@"@"];
    if(!subs.count == 2)
        return NO;
    NSString *domain = subs[1];
    NSArray *subsDomain = [domain componentsSeparatedByString:@"."];
    if(subsDomain.count < 2 || subsDomain.count > 3)
        return NO;
    for(NSString* sub in subsDomain)
    {
        if (sub.length < 2)
            return NO;
    }
    return YES;
}


-(BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [upc dismissPopoverAnimated:YES];
    if(indexPath.row == 1)
    {
        [self scanBusinessCard:nil];
    }
}

@end
