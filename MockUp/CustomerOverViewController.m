//
//  CustomerOverViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 17-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "CustomerOverViewController.h"
#import "PictureView.h"

@interface CustomerOverViewController ()

@end

@implementation CustomerOverViewController
AFOpenFlowView *ContactFlow;
NSMutableArray *contacts;
NSMutableArray *contactsPhotos;
int selectedContact;
@synthesize selectedBUPA,cvc;




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
    for(UIView *view in self.ViewCollection)
    {
        view.layer.cornerRadius = 8.0;
        view.layer.masksToBounds = YES;
    }
    
    
    NSString *type = selectedBUPA.BusinessPartnerType;
    if([type isEqualToString:@"Prospect"] || [type isEqualToString:@"Competitor"])
    {
        self.BottomControl.hidden = YES;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"NoteView" owner:self options:nil];
        NoteView *subView = [subviewArray objectAtIndex:0];
        subView.cvc = cvc;
        [subView setNotes:cvc.notes];
        [self.bottomView addSubview:subView];
    }
    else if([type isEqualToString:@"Customer"])
    {
        self.BottomControl.hidden = NO;
        
        //Setup BW View
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BW_View" owner:self options:nil];
        BWView *subView = [subviewArray objectAtIndex:0];
        subView.covc = self;
        [self.bottomView insertSubview:subView belowSubview:self.BottomControl];
//        [self.bottomView addSubview:subView];
        
        //Setup Note View,but hide it because BW is visible
        NSArray *subviewArray2 = [[NSBundle mainBundle] loadNibNamed:@"NoteView" owner:self options:nil];
        NoteView *subView2 = [subviewArray2 objectAtIndex:0];
        subView2.cvc = cvc;
        subView2.hidden = YES;
        [subView2 setNotes:cvc.notes];
        [self.bottomView insertSubview:subView2 belowSubview:self.BottomControl];

//        [self.bottomView addSubview:subView2];
        
        [subView performSelectorInBackground:@selector(setupChartsForBusinessPartner:) withObject:selectedBUPA];
    }
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showContacts:) name:kLoadContactsCompletedNotification object:nil];
    
    [[RequestHandler uniqueInstance]loadContacts:selectedBUPA];
    self.picView.cvc = (CustomerViewController*)self.parentViewController;
    self.TweetView.searchTerm = selectedBUPA.BusinessPartnerName;
}

-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.picView performSelectorInBackground:@selector(showPictures) withObject:nil];
    NSString *searchTerm = selectedBUPA.Twitter.LongURL;
    if([searchTerm isEqualToString:@""]||searchTerm == nil)
        searchTerm = selectedBUPA.BusinessPartnerName;
    [self.TweetView performSelectorInBackground:@selector(getTweets:) withObject:selectedBUPA];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if(self.bottomView.subviews.count >0)
    {
        [[NSNotificationCenter defaultCenter]removeObserver:self.bottomView.subviews[0]];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self.picView];
    [self.TweetView getTweets:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setViewCollection:nil];
    [self setContactView:nil];
    [self setContactLabels:nil];
    [self setEmailButton:nil];
    [self setNoContactsLabel:nil];
    [self setTweetView:nil];
    [self setBottomView:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self.bottomView.subviews[0]];
}

-(void)showContacts:(NSNotification*)notification
{
    [ContactFlow removeFromSuperview];
    ContactFlow = nil;
    NSDictionary *userInfoDict = [notification userInfo];
    NSMutableArray *unsortedContacts = [userInfoDict objectForKey:kResponseItems];
    contacts = (NSMutableArray*)[unsortedContacts sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
                                 {
                                     
                                     NSString *first = [(ContactPerson*)a LastName];
                                     NSString *second = [(ContactPerson*)b LastName];
                                     NSString *firstUpper = [first uppercaseString];
                                     NSString *secondUpper = [second uppercaseString];
                                     return [firstUpper compare:secondUpper];
                                 }];
    ContactFlow = [[AFOpenFlowView alloc]initWithFrame:CGRectMake(0, 0, 250, 200)];
    ContactFlow.numberOfImages = contacts.count+1;
    
    for (int i = 0; i<contacts.count; i++) {
        [ContactFlow setImage:[UIImage imageWithImage:[UIImage imageNamed:@"group_icon.png"] scaledToSize:CGSizeMake(125, 125)]
                     forIndex:i];
    }
    [ContactFlow setImage:[UIImage imageWithImage:[UIImage imageNamed:@"add_contact.png"] scaledToSize:CGSizeMake(125, 125)] forIndex:contacts.count];
    ContactFlow.frame = self.ContactView.bounds;
    CGRect oldFrame = ContactFlow.frame;
    oldFrame.origin = CGPointMake(ContactFlow.frame.origin.x, ContactFlow.frame.origin.y-20);
    ContactFlow.frame = oldFrame;
    ContactFlow.viewDelegate = self;
    [self.ContactView insertSubview:ContactFlow atIndex:0];
    
    selectedContact = 0;
    [self openFlowView:ContactFlow selectionDidChange:selectedContact];
    if(contacts.count >0)
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showContactPhotos:) name:kPassPhotosLoaded object:nil];
        [[RequestHandler uniqueInstance]performSelectorInBackground:@selector(loadImagesforContacts:) withObject:contacts];
        self.EmailButton.hidden = NO;
    }
    else
        self.EmailButton.hidden = YES;
    
    UITapGestureRecognizer *tappedContact = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedContacts)];
    tappedContact.numberOfTapsRequired = 1;
    [ContactFlow addGestureRecognizer:tappedContact];
    
}

-(void)showContactPhotos:(NSNotification*)notification
{
    contactsPhotos = [NSMutableArray array];
    NSDictionary *tempPicDic = [notification.userInfo objectForKey:kResponseItems];
    for(int i=0;i<contacts.count;i++)
    {
        ContactPerson *cp = contacts[i];
        UIImage *tempPass = [tempPicDic objectForKey:cp.ContactPersonID];
        if(tempPass)
               [ContactFlow setImage:[UIImage imageWithImage:tempPass scaledToSize:CGSizeMake(125, 125)] forIndex:i];
        else
            tempPass = [UIImage imageNamed:@"group_icon.png"];
        [contactsPhotos insertObject:tempPass atIndex:i];
    }
//    for(NSString *key in contactsPhotos.allKeys)
//    {
//        for(int i = 0;i<contacts.count;i++)
//        {
//            ContactPerson *temp = contacts[i];
//            if([temp.ContactPersonID isEqualToString:key])
//            {
//                [ContactFlow setImage:[UIImage imageWithImage:[contactsPhotos objectForKey:key] scaledToSize:CGSizeMake(150,150)] forIndex:i];
//                break;
//            }
//        }
}

-(void)tappedContacts
{
    NSLog(@"Gesture Recogned");
    if(selectedContact < contacts.count)
        [self performSegueWithIdentifier:@"contactDetails" sender:contacts[selectedContact]];
    else
        [cvc performSegueWithIdentifier:@"newContacts" sender:nil];
}

#pragma mark - Open Flow Delegate
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    selectedContact = index;
    if(index == contacts.count)
    {
        self.EmailButton.hidden = YES;
        for(UILabel *label in self.contactLabels)
        {
            switch (label.tag) {
                case 1:
                    label.text = @"";
                    break;
                case 2:
                    label.text = @"";
                    break;
                case 3:
                    label.text = @"Add Contact";
                    break;
                    
                default:
                    break;
            }
        }
    }
    else
    {
        ContactPerson *temp = [contacts objectAtIndex:index];
        for(UILabel *label in self.contactLabels)
        {
            if([temp.Email.URL isEqualToString:@""])
                self.EmailButton.hidden = YES;
            else
                self.EmailButton.hidden = NO;
            switch (label.tag) {
                case 1:
                    label.text = [NSString stringWithFormat:@"%@ %@",temp.FirstName,temp.LastName];
                    break;
                case 2:
                    label.text = [NSString stringWithFormat:@"Email: %@",temp.Email.URL];
                    break;
                case 3:
                    label.text = [NSString stringWithFormat:@"Tel.: %@",temp.PhoneNumber.PhoneNumber];
                    break;
                    
                default:
                    break;
            }
        }
    }
}

#pragma mark - Sending Email


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendEmail:(id)sender {
    ContactPerson *contact = [contacts objectAtIndex:selectedContact];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        NSArray *toRecipients = [NSArray arrayWithObjects:contact.Email.URL,nil];
        [mailer setToRecipients:toRecipients];
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"No Email account has been set on your device!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - prepare for segueing
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"contactDetails"])
    {
        NewContactController *ncc = (NewContactController*)segue.destinationViewController;
        ncc.editContact = (ContactPerson*)sender;
        ncc.passphoto = contactsPhotos[selectedContact];
    }
    else if([segue.identifier isEqualToString:@"CustomerInfo"])
    {
        InfoViewController *ivc = (InfoViewController*)segue.destinationViewController;
        [ivc setBupa:selectedBUPA withLogo:self.cvc.bupaLogo];
    }
}
- (IBAction)changeBottomView:(id)sender {
    UISegmentedControl *control = (UISegmentedControl*)sender;
    for(int i=0;i<self.bottomView.subviews.count;i++)
    {
        UIView *temp = self.bottomView.subviews[i];
        if(i == control.selectedSegmentIndex || [temp isKindOfClass:[UISegmentedControl class]])
            temp.hidden = NO;
        else
            temp.hidden = YES;
    }
}


#pragma mark - Pie Chart shit

@end
