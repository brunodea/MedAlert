//
//  LoginViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 01/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "MedAlertDB.h"

@implementation LoginViewController


@synthesize usernameTextField;
@synthesize passwordTextField;

@synthesize loginButton;

@synthesize rememberMeSwitch;
@synthesize rememberMeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    passwordTextField.secureTextEntry = YES;
    
    usernameTextField.delegate = (id)self;
    usernameTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.delegate = (id)self;
    passwordTextField.returnKeyType = UIReturnKeyDone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [usernameTextField release];
    [passwordTextField release];
    [rememberMeLabel release];
    [rememberMeSwitch release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Helps the keyboard to hide.
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//keyboard hide when touching the background
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];     
}


-(IBAction)doneButtonPressed:(id)sender
{
    NSLog(@"doneButtonPressed, sender:%@", sender);
    [[MedAlertDB instance] isValid:[usernameTextField text]:[passwordTextField text]];
}







@end
