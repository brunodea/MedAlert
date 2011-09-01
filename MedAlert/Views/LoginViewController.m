//
//  LoginViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 01/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "SignInViewController.h"
#import "ProfileTableViewController.h"
#import "UserDAO.h"
#import "ModelUser.h"

@implementation LoginViewController

@synthesize usernameTextField;
@synthesize passwordTextField;

@synthesize loginButton;
@synthesize signInButton;

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
    return YES;
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
    UserDAO *udao = [[UserDAO alloc] init];
    ModelUser *user = [udao userWithLogin:[usernameTextField text] andPassword:[passwordTextField text]];
    if(user != nil)
    {
        user.mRemeberMe = [rememberMeSwitch isOn];
        [udao adjustInfoOfUser:user];
        ProfileTableViewController *pvc = [[ProfileTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        pvc.title = [NSString stringWithFormat:@"Profile - %@",[user mName]];
        pvc.mUser = user;
        [self.navigationController pushViewController:pvc animated:YES];
        [pvc release];
        
        self.usernameTextField.text = @"";
        self.passwordTextField.text = @"";
        [self.rememberMeSwitch setOn:NO];
    }
    else
    {
        UIAlertView *loginIncorrect = [[UIAlertView alloc] initWithTitle:@"Login inválido." message:@"Login e/ou senha incorretos." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [loginIncorrect show];
        [loginIncorrect release];
    }
    [udao release];
}

-(IBAction)signInButtonPressed:(id)sender
{
    SignInViewController *siVC = [[SignInViewController alloc] init];
    siVC.title = @"Cadastro";
    [self.navigationController pushViewController:siVC animated:YES];
    [siVC release];
}

-(IBAction)usernameFinishedEdition:(id)sender
{
    UserDAO *udao = [[UserDAO alloc] init];
    if([udao rememberThePasswordOfLogin:[usernameTextField text]])
    {
        passwordTextField.text = [udao passwordOfLogin:[usernameTextField text]];
        [rememberMeSwitch setOn:YES animated:YES];
    }
    [udao release];
}

@end
