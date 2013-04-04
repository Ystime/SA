//
//  NewTextController.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 28-01-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "NewTextController.h"

@interface NewTextController ()

@end

@implementation NewTextController
@synthesize cvc;
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
            if([self.NoteText.text isEqualToString:@""] || [self.NoteTitle.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Missing text" message:@"Both fields have to be filled!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                if([[RequestHandler uniqueInstance]uploadNote:self.NoteText.text withTitle:self.NoteTitle.text forBusinessPartner:cvc.selectedBusinessPartner])
                {
                    [self dismissViewControllerAnimated:YES completion:^
                    {
                        [[RequestHandler uniqueInstance]loadNotesForBusinessPartner:cvc.selectedBusinessPartner withPrefix:nil];
                    }];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upload Failed" message:@"An error occured during the save of the note" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
            }
            break;
        case 2:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}
@end
