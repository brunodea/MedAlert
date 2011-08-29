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

@synthesize mPickerView;
@synthesize mAlarmLabelTextField;
@synthesize mSaveButton;
@synthesize mMedName;

@synthesize mHoursArray;
@synthesize mMinutesArray;
@synthesize mMedicinesArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mMedicinesArray = nil;
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
    for(int i = 0; i <= 24; i++)
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
    [mPickerView release];
    
    [mHoursArray release];
    [mMinutesArray release];
    
    [mMedicinesArray release];
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

-(IBAction)saveButtonPressed:(id)sender
{
    
}

@end
