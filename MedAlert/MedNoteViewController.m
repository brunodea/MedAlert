//
//  MedNoteViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 29/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedNoteViewController.h"

#import "MedicineDAO.h"

@implementation MedNoteViewController

@synthesize mSaveButton;
@synthesize mMedNameLabel;
@synthesize mNoteTextView;

@synthesize mMedicine;
@synthesize mUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mUser = nil;
        mMedicine = nil;
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
    mMedNameLabel.text = mMedicine.mName;
    mNoteTextView.text = mMedicine.mNote;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [mMedicine release];
    [mMedNameLabel release];
    [mUser release];
    [mNoteTextView release];
    [mSaveButton release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)saveButtonPressed:(id)sender
{
    if([[mNoteTextView text] isEqual:@""] == NO)
        mMedicine.mNote = [mNoteTextView text];
    
    MedicineDAO *mdao = [[MedicineDAO alloc] init];
    if([mdao updateMedicine:mMedicine ofUser:mUser] == YES)
    {
        UIAlertView *p = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"Nota adicionada com sucesso." delegate:nil
                                          cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [p show];
        [p release];
    }
    [mdao release];
}

//keyboard hide when touching the background
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mNoteTextView resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];     
}

@end
