//
//  SignInViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 22/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignInViewController.h"
#import "MedAlertDB.h"

@interface SignInViewController (hidden)
    -(BOOL)areSignInFieldsOk;
@end

@implementation SignInViewController

@synthesize nameTF;
@synthesize loginTF;
@synthesize passwordTF;
@synthesize password2TF;

@synthesize doneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    nameTF.delegate = (id)self;
    nameTF.returnKeyType = UIReturnKeyDone;
    
    loginTF.delegate = (id)self;
    loginTF.returnKeyType = UIReturnKeyDone;
    
    passwordTF.delegate = (id)self;
    passwordTF.returnKeyType = UIReturnKeyDone;
    
    password2TF.delegate = (id)self;
    password2TF.returnKeyType = UIReturnKeyDone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [nameTF release];
    [loginTF release];
    [passwordTF release];
    [password2TF release];
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
    [nameTF resignFirstResponder];
    [loginTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    [password2TF resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];     
}

//retorna YES se esta tudo ok.
-(BOOL)areSignInFieldsOk
{    
    BOOL hasProblem = NO;
    
    NSString *alertTitle = @"Erro no cadastro";
    NSString *alertMsg = nil;
    NSString *alertCancelButtonTitle = @"Ok";
    
    if([[nameTF text] isEqualToString:@""] || [[loginTF text] isEqualToString:@""] || 
       [[passwordTF text] isEqualToString:@""] || [[password2TF text] isEqualToString:@""])
    {
        hasProblem = YES;
        alertMsg = @"Nenhum campo pode ser vazio.";
    }
    
    else if([[passwordTF text] isEqualToString:[password2TF text]] == NO)
    {
        hasProblem = YES;
        alertMsg = @"Senha e senha redigitada não são as mesmas.";
    }
    
    else if([[MedAlertDB instance] exists:[loginTF text]] == YES)
    {
        hasProblem = YES;
        alertMsg = [NSString stringWithFormat:@"Usuário %@ já existe.", [loginTF text]];
    }
    
    if(hasProblem)
    {        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil 
                                              cancelButtonTitle:alertCancelButtonTitle otherButtonTitles:nil, nil];
        [error show];
        return NO;
    }
    
    return YES;
}

-(IBAction)signInButtonPressed:(id)sender
{
    if([self areSignInFieldsOk] == YES)
    {
        NSString *alertTitle = nil;
        NSString *alertMsg = nil;
        if([[MedAlertDB instance] insertUser:[nameTF text]:[loginTF text]:[passwordTF text]] == YES)
        {
            alertTitle = @"Sucesso";
            alertMsg = @"Cadastro realizado com sucesso.";
        }
        else
        {
            alertTitle = @"Erro";
            alertMsg = @"Cadastro não pôde ser realizado.";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil 
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}


@end
