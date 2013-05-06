//
//  HeaderViewController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 19-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "HeaderViewController.h"
#import "CustomerViewController.h"
#import "DocumentViewController.h"
@interface HeaderViewController ()

@end

@implementation HeaderViewController
@synthesize sd,ndvc;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [UIView changeLayoutToDefaultProjectSettings:self.POField];
    //    self.POField.layer.borderWidth = 1.0;
    //    self.POField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [UIView changeLayoutToDefaultProjectSettings:self.view];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.DlvDatePicker.minimumDate = [NSDate dateWithTimeInterval:3600*24*7 sinceDate:[NSDate date]];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.POField.text = sd.CustomerPurchaseOrderNumber;
    self.ShipToLabel.text = ndvc.ShipToLabel.text;
    if(!(sd.RequestedDeliveryDate == nil))
        [self.DlvDatePicker setDate:sd.RequestedDeliveryDate];
    for(UILabel *label in self.Labels)
    {
        switch (label.tag) {
            case 1:
                label.text = ndvc.cvc.selectedBusinessPartner.BusinessPartnerName;
                break;
            case 2:
                label.text = [SettingsUtilities getUsernameFromUserSettings];
                break;
            case 3:
                label.text = sd.SalesOrganization;
                break;
            case 4:
                label.text = sd.Division;
                break;
            case 5:
                label.text = sd.DistributionChannel;
                break;
            case 6:
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

- (IBAction)topButtonClicked:(id)sender {
    if([sender tag] == 1)
    {
        if([self.ShipToLabel.text isEqualToString:@""])
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"No Ship-To" message:@"Select a Ship-To party!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else
        {
            sd.CustomerPurchaseOrderNumber = self.POField.text;
            sd.RequestedDeliveryDate = self.DlvDatePicker.date;
            ndvc.ShipToLabel.text = self.ShipToLabel.text;
            [ndvc setHeaderLabelView];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setNDVC:(UIViewController*)nv
{
    ndvc = (DocumentViewController*)nv;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"shipToChoice"])
    {
        SoldToController *stc = (SoldToController*)segue.destinationViewController;
        stc.hvc = self;
        UIStoryboardPopoverSegue *pop = (UIStoryboardPopoverSegue*)segue;
        _upc = pop.popoverController;
    }
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        [textField resignFirstResponder];
    return YES;
}

-(BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}
@end
