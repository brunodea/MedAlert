//
//  MedConfViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedConfViewController.h"
#import "ModelMedicine.h"
#import "MedicineDAO.h"


@implementation MedConfViewController

@synthesize mMedNameTextField;
@synthesize mDoneButton;
@synthesize mUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mUser = nil;
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
    
    mMedNameTextField.delegate = (id)self;
    mMedNameTextField.returnKeyType = UIReturnKeyDone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [mMedNameTextField release];
    
    [mUser release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(BOOL) isFormOk
{
    if(mMedNameTextField.text == @"")
    {
        UIAlertView *p = [[UIAlertView alloc] initWithTitle:@"Erro." message:@"Nome de medicamento não pode ser nulo." delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [p show];
        
        return NO;
    }
    
    return YES;
}

-(IBAction) doneButtonClicked:(id)sender
{
    if([self isFormOk] == NO)
        return;
    NSString *alertTitle = @"Erro";
    NSString *alertMsg = @"Medicamento já existe.";
    
    ModelMedicine *m = [[ModelMedicine alloc] init];
    m.mName = mMedNameTextField.text;
    
    MedicineDAO *mdao = [[MedicineDAO alloc] init];
    if([mdao insertMedicine:m] == YES)
    {
        alertTitle = @"Sucesso";
        alertMsg = @"Medicamento adicionado com sucesso.";
        mMedNameTextField.text = @"";
        
        if(mUser != nil)
        {
            NSInteger medicine_id = [mdao medicineIDByName:[m mName]];
        
            if(medicine_id >= 0)
            {
                [mdao insertMedicine:medicine_id RelativeToUser:[mUser mID]];
            }
        }
    }
    
    UIAlertView *p = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil
                                      cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [p show];
    
    [m release];
    [mdao release];
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
    [mMedNameTextField resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];     
}

@end
