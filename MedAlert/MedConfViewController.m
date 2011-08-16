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

@synthesize mMedName;
@synthesize mDoneButton;

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
    
    mMedName.delegate = (id)self;
    mMedName.returnKeyType = UIReturnKeyDone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL) isFormOk
{
    if(mMedName.text == @"")
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
    ModelMedicine *m = [[ModelMedicine alloc] init];
    m.mName = mMedName.text;
    
    MedicineDAO *mdao = [[MedicineDAO alloc] init];
    if([mdao insertMedicine:m] == YES)
    {
        UIAlertView *p = [[UIAlertView alloc] initWithTitle:@"Adicionado." message:@"Medicamento adicionado com sucesso." delegate:nil
                                          cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [p show];
    }
    
    [m release];
    [mdao release];
}

@end
