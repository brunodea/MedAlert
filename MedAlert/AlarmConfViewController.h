//
//  AlarmConfViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 29/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelPeriodicAlarm.h"


@interface AlarmConfViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
    IBOutlet UITextField *mAlarmLabelTextField;
    
    IBOutlet UIPickerView *mIntervalTimePickerView;
    IBOutlet UIDatePicker *mInitialDatePickerView;
    IBOutlet UIDatePicker *mFinalDatePickerView;
    
    IBOutlet UIButton *mContinueToInitDateButton;
    IBOutlet UIButton *mContinueToFinalDateButton;
    IBOutlet UIButton *mContinueToNoteButton;
    IBOutlet UIButton *mSaveButton;
    
    IBOutlet UILabel *mMedName;
    
    IBOutlet UITextView *mNoteTextView;
    
    NSArray *mHoursArray;
    NSArray *mMinutesArray;
    NSArray *mMedicinesArray;
    
    IBOutlet UIView *mInitialDateView;
    IBOutlet UIView *mFinishDateView;
    IBOutlet UIView *mAlarmNoteView;
    
    ModelPeriodicAlarm *mCurrentPeriodicAlarm;
}

@property (nonatomic, retain) IBOutlet UITextField *mAlarmLabelTextField;

@property (nonatomic, retain) IBOutlet UIPickerView *mIntervalTimePickerView;
@property (nonatomic, retain) IBOutlet UIDatePicker *mInitialDatePickerView;
@property (nonatomic, retain) IBOutlet UIDatePicker *mFinalDatePickerView;

@property (nonatomic, retain) IBOutlet UIButton *mContinueToInitDateButton;
@property (nonatomic, retain) IBOutlet UIButton *mContinueToFinalDateButton;
@property (nonatomic, retain) IBOutlet UIButton *mContinueToNoteButton;
@property (nonatomic, retain) IBOutlet UIButton *mSaveButton;

@property (nonatomic, retain) IBOutlet UILabel *mMedName;

@property (nonatomic, retain) IBOutlet UITextView *mNoteTextView;

@property (nonatomic, retain) NSArray *mHoursArray;
@property (nonatomic, retain) NSArray *mMinutesArray;
@property (nonatomic, retain) NSArray *mMedicinesArray;

@property (nonatomic, retain) IBOutlet UIView *mInitialDateView;
@property (nonatomic, retain) IBOutlet UIView *mFinishDateView;
@property (nonatomic, retain) IBOutlet UIView *mAlarmNoteView;

@property (nonatomic, retain) ModelPeriodicAlarm *mCurrentPeriodicAlarm;

-(IBAction) continueToInitDateButtonPressed:(id)sender;
-(IBAction) continueToFinalDateButtonPressed:(id)sender;
-(IBAction) continueToNoteButtonPressed:(id)sender;
-(IBAction) saveButtonPressed:(id)sender;

@end
