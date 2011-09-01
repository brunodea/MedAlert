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
@synthesize mTipTextView;
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
    if([mMedNameTextField.text length] == 0)
    {
        UIAlertView *p = [[UIAlertView alloc] initWithTitle:@"Erro." message:@"Nome de medicamento não pode ser vazio." delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [p show];
        [p release];
        return NO;
    }
    
    return YES;
}

-(IBAction) doneButtonClicked:(id)sender
{
    if([self isFormOk] == NO)
        return;
    NSString *alertTitle = @"Sucesso";
    NSString *alertMsg =  @"Medicamento adicionado com sucesso.";
    
    ModelMedicine *m = [[ModelMedicine alloc] init];
    m.mName = mMedNameTextField.text;
    
    MedicineDAO *mdao = [[MedicineDAO alloc] init];
    [mdao insertMedicine:m];
    
    mMedNameTextField.text = @"";
        
    if(mUser != nil)
    {
        NSInteger medicine_id = [mdao medicineIDByName:[m mName]];
    
        if(medicine_id >= 0)
        {
            if([mdao insertMedicine:medicine_id RelativeToUser:[mUser mID]] == NO)
            {
                alertTitle = @"Erro";
                alertMsg = @"Você já tem este medicamento.";
            }
            else
            {
                [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
            }
        }
    }
    
    UIAlertView *p = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil
                                      cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [p show];
    [p release];
    
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

-(IBAction)userIsTyping:(id)sender
{
    MedicineDAO *mdao = [[MedicineDAO alloc] init];
    NSMutableArray *ms = [mdao medicinesLike:mMedNameTextField.text WithLimit:100];
    
    NSString *res = @"";
    
    for(ModelMedicine *m in ms) 
    {
        res = [res stringByAppendingString:[m.mName stringByAppendingString:@"\n"]];
    }
    if(res == @"")
        res = @"Nenhuma dica";
    
    mTipTextView.text = res;
    
    [mdao release];
}

@end
