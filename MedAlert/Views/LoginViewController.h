//
//  LoginViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 01/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *signInButton;
    
    IBOutlet UISwitch *rememberMeSwitch;
    IBOutlet UILabel *rememberMeLabel;
    
}

@property (nonatomic, retain) IBOutlet UITextField *usernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;

@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UIButton *signInButton;

@property (nonatomic, retain) IBOutlet UISwitch *rememberMeSwitch;
@property (nonatomic, retain) IBOutlet UILabel *rememberMeLabel;

-(IBAction)doneButtonPressed:(id)sender;
-(IBAction)signInButtonPressed:(id)sender;
-(IBAction)usernameFinishedEdition:(id)sender;

@end
