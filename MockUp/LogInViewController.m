//
//  ViewController.m
//  Sales Rep App
//
//  Created by Administrator on 1/8/13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController
LGViewHUD *loggingIn;
BOOL firsttry;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    for(UIView *view in self.Views)
    {
        [UIView changeLayoutToDefaultProjectSettings:view];
    }
    [UIView changeLayoutToDefaultProjectSettings:self.GoButton];
    loggingIn = [[LGViewHUD alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    loggingIn.topText = @"Logging In";
    loggingIn.bottomText = @"Please Wait!";
    loggingIn.activityIndicatorOn = YES;
    firsttry = YES;
    self.UsernameTextField.text = [SettingsUtilities getUsernameFromUserSettings];
    self.PasswordTextField.text = [SettingsUtilities getPasswordFromUserSettings];
    if(!([self.UsernameTextField.text isEqualToString:@""]||[self.PasswordTextField.text isEqualToString:@""]))
    {
        for(UIView *view in self.Views)
        {
            [view setHidden:YES];
        }
    }
}

- (void)viewDidUnload
{
    [self setVersionLabel:nil];
    [self setViews:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)logIn:(id)sender
{
    [self performSelectorOnMainThread:@selector(becomeFirstResponder) withObject:nil waitUntilDone:YES];
    if([SettingsUtilities getDemoStatus])
    {
        //Load demo data and make login seem succesfull
        [DemoData getInstance];
        [self logInSucces];
        return;
    }
    [loggingIn showInView:self.view];
    [self performSelectorInBackground:@selector(tryLoggingIn) withObject:nil];
}

-(void)tryLoggingIn
{
    NSError *error;
    BOOL loggedIn = [[RequestHandler uniqueInstance]executeLoginWithUsername:self.UsernameTextField.text andPassword:self.PasswordTextField.text error:&error];
    if(loggedIn)
        [self performSelectorOnMainThread:@selector(logInSucces) withObject:nil waitUntilDone:NO];
    else
    {
        [loggingIn hideWithAnimation:HUDAnimationNone];
        
        UIAlertView *failLoginAlert = [[UIAlertView alloc]initWithTitle:@"Login Failed!" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        switch (error.code) {
            case 1001:
                failLoginAlert.message = @"Service seems to be empty! Please contact your admin!";
                break;
            case 1002:
                failLoginAlert.message = @"Login failed! Re-enter your credentials!";
                break;
            case 1005:
                failLoginAlert.message = @"Metadata could not be parsed! Please contact your admin!";
                break;
            default:
                failLoginAlert.message = @"An unknown error has occured! Please contact your admin!";
                break;
        }
        failLoginAlert.delegate = self;
        [failLoginAlert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    }
}

-(void)logInSucces
{
    [self performSegueWithIdentifier:@"GoToMainView" sender:self];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(firsttry)
    {
        for(UIView *view in self.Views)
        {
            [view setHidden:NO];
        }
    }
}

-(void)shiftView:(UIView*)temp vertical:(float)pixels
{
    CGRect oldFrame = temp.frame;
    oldFrame.origin.x += pixels;
    temp.frame = oldFrame;
}

#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self shiftView:self.view vertical:352];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self shiftView:self.view vertical:(-352)];
}



@end
