//
//  AlarmConfViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 29/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlarmConfViewController.h"
#import "ModelMedicine.h"

@implementation AlarmConfViewController

@synthesize mIntervalTimePickerView;
@synthesize mInitialDatePickerView;
@synthesize mFinalDatePickerView;

@synthesize mAlarmLabelTextField;

@synthesize mContinueToInitDateButton;
@synthesize mContinueToFinalDateButton;
@synthesize mContinueToNoteButton;
@synthesize mSaveButton;

@synthesize mMedName;

@synthesize mNoteTextView;

@synthesize mHoursArray;
@synthesize mMinutesArray;
@synthesize mMedicinesArray;

@synthesize mInitialDateView;
@synthesize mFinishDateView;
@synthesize mAlarmNoteView;

@synthesize mCurrentPeriodicAlarm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mCurrentPeriodicAlarm = [[ModelPeriodicAlarm alloc] init];
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
    
    mAlarmLabelTextField.delegate = (id)self;
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(int i = 0; i <= 100; i++)
    {
        NSNumber *n = [[NSNumber alloc] initWithInt:i];
        [arr addObject:n];
        [n release];
    }
    
    mHoursArray = [[NSArray alloc] initWithArray:arr];
    
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    for(int i = 0; i <= 59; i++)
    {
        NSNumber *n = [[NSNumber alloc] initWithInt:i];
        [arr2 addObject:n];
        [n release];
    }
    
    mMinutesArray = [[NSArray alloc] initWithArray:arr2];
    
    [arr release];
    [arr2 release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [mAlarmLabelTextField release];
    [mSaveButton release];
    [mIntervalTimePickerView release];
    [mFinalDatePickerView release];
    [mContinueToInitDateButton release];
    [mContinueToFinalDateButton release];
    [mContinueToNoteButton release];
    [mNoteTextView release];
    
    [mHoursArray release];
    [mMinutesArray release];
    [mMedicinesArray release];
    
    [mCurrentPeriodicAlarm release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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
    [mAlarmLabelTextField resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];     
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return [mMedicinesArray count];
    else if(component == 1)
        return [mHoursArray count];
    else
        return [mMinutesArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        ModelMedicine *m = (ModelMedicine *)[mMedicinesArray objectAtIndex:row];
        return [NSString stringWithFormat:@"%@", [m mName]];
    }
    else if(component == 1)
        return [NSString stringWithFormat:@"%d h",[[mHoursArray objectAtIndex:row] integerValue]];
    else
        return [NSString stringWithFormat:@"%d min", [[mMinutesArray objectAtIndex:row] integerValue]];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        ModelMedicine *m = (ModelMedicine *)[mMedicinesArray objectAtIndex:row];
        mMedName.text = [m mName];
    }
}

-(IBAction)continueToInitDateButtonPressed:(id)sender
{
    if([[mAlarmLabelTextField text] isEqualToString:@""] == YES)
    {
        UIAlertView *problem = [[UIAlertView alloc] initWithTitle:@"Problema" 
                                                          message:@"Você esqueceu de dar um rotulo para seu Alarme."
                                                         delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [problem show];
        [problem release];
    }
    else
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = @"Data Inicial";
        vc.view = mInitialDateView;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

-(IBAction)continueToFinalDateButtonPressed:(id)sender
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"Data Final";
    vc.view = mFinishDateView;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
        
    NSInteger medi = [mIntervalTimePickerView selectedRowInComponent:0];
    NSInteger hi = [mIntervalTimePickerView selectedRowInComponent:1];
    NSInteger mini = [mIntervalTimePickerView selectedRowInComponent:2];
    
    ModelMedicine *medication = [mMedicinesArray objectAtIndex:medi];
    NSNumber *hours = [mHoursArray objectAtIndex:hi];
    NSNumber *minutes = [mMinutesArray objectAtIndex:mini];
    
    NSLog(@"%@ %dh %dmin",[medication mName],[hours integerValue],[minutes integerValue]);
}

-(IBAction) continueToNoteButtonPressed:(id)sender
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"Nota";
    vc.view = mAlarmNoteView;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init]; 
    [dateFormatter setDateStyle:NSDateFormatterNoStyle]; 
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle]; 
    [dateFormatter setDateFormat:(NSString*) @"dd/MM/yyyy HH:mm"]; 
    
    NSString *str = [dateFormatter stringFromDate:[mFinalDatePickerView date]];
    NSLog(@"%@", str);
    
    [dateFormatter release];
}

-(IBAction)saveButtonPressed:(id)sender
{
    NSString *alertTitle = @"Sucesso";
    NSString *alertMsg = @"Alarme adicionado com sucesso.";
    
    UIAlertView *succ = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [succ show];
    [succ release];
    
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
}

@end
