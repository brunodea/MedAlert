//
//  LoginViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 01/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "SignInViewController.h"
#import "ProfileViewController.h"
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
//        UIAlertView *loginCorrect = [[UIAlertView alloc] initWithTitle:@"Login válido." message:@"Você existe!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [loginCorrect show];
        
        user.mRemeberMe = [rememberMeSwitch isOn];
        [udao adjustInfoOfUser:user];
        ProfileViewController *pvc = [[ProfileViewController alloc] init];
        pvc.title = @"Profile";
        [self.navigationController pushViewController:pvc animated:YES];
        [pvc release];
    }
    else
    {
        UIAlertView *loginIncorrect = [[UIAlertView alloc] initWithTitle:@"Login inválido." message:@"Login e/ou senha incorretos." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [loginIncorrect show];
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
        passwordTextField.text = [udao passwordOfLogin:[usernameTextField text]];
    [udao release];
}

@end
