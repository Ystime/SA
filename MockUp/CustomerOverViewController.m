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
int selectedContact;
@synthesize selectedBUPA;




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
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"NoteView" owner:self options:nil];
        NoteView *subView = [subviewArray objectAtIndex:0];
        [self.bottomView addSubview:subView];
    }
    else if([type isEqualToString:@"Customer"])
    {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BW_View" owner:self options:nil];
        BWView *subView = [subviewArray objectAtIndex:0];
        [self.bottomView addSubview:subView];
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
    [self.TweetView performSelectorInBackground:@selector(getTweets) withObject:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if(self.bottomView.subviews.count >0)
    {
        [[NSNotificationCenter defaultCenter]removeObserver:self.bottomView.subviews[0]];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self.picView];

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
    if(unsortedContacts.count > 0)
    {
        contacts = (NSMutableArray*)[unsortedContacts sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
                                     {
                                         
                                         NSString *first = [(ContactPerson*)a LastName];
                                         NSString *second = [(ContactPerson*)b LastName];
                                         NSString *firstUpper = [first uppercaseString];
                                         NSString *secondUpper = [second uppercaseString];
                                         return [firstUpper compare:secondUpper];
                                     }];
        ContactFlow = [[AFOpenFlowView alloc]initWithFrame:CGRectMake(0, 0, 250, 200)];
        ContactFlow.numberOfImages = contacts.count;
        
        for (int i = 0; i<contacts.count; i++) {
            [ContactFlow setImage:[UIImage imageWithImage:[UIImage imageNamed:@"group_icon.png"] scaledToSize:CGSizeMake(150, 150)]
                         forIndex:i];
        }
        
        ContactFlow.frame = self.ContactView.bounds;
        ContactFlow.viewDelegate = self;
        [self.ContactView insertSubview:ContactFlow atIndex:0];
        
        selectedContact = 0;
        [self openFlowView:ContactFlow selectionDidChange:selectedContact];
        self.EmailButton.hidden = NO;
    }
    else
    {
        self.NoContactsLabel.hidden = NO;
    }
    
    UITapGestureRecognizer *tappedContact = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedContacts)];
    tappedContact.numberOfTapsRequired = 2;
    [ContactFlow addGestureRecognizer:tappedContact];
}

-(void)tappedContacts
{
    NSLog(@"Gesture Recogned");
    [self performSegueWithIdentifier:@"contactDetails" sender:contacts[selectedContact]];
}

#pragma mark - Open Flow Delegate
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    selectedContact = index;
    ContactPerson *temp = [contacts objectAtIndex:index];
    for(UILabel *label in self.contactLabels)
    {
        switch (label.tag) {
            case 1:
                label.text = [NSString stringWithFormat:@"%@ %@",temp.FirstName,temp.LastName];
                break;
            case 2:
                label.text = [NSString stringWithFormat:@"Email: %@",temp.Email.URL];
                break;
            case 3:
                label.text = [NSString stringWithFormat:@"Phone: %@",temp.PhoneNumber.PhoneNumber];
                break;
                
            default:
                break;
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
    }
    else if([segue.identifier isEqualToString:@"CustomerInfo"])
    {
        InfoViewController *ivc = (InfoViewController*)segue.destinationViewController;
        [ivc setBupa:selectedBUPA];
    }
}
@end
