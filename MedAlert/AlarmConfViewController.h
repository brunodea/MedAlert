//
//  AlarmConfViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 29/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlarmConfViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
    IBOutlet UITextField *mAlarmLabelTextField;
    IBOutlet UIPickerView *mPickerView;
    IBOutlet UIButton *mSaveButton;
    IBOutlet UILabel *mMedName;
    
    NSArray *mHoursArray;
    NSArray *mMinutesArray;
    NSArray *mMedicinesArray;
}

@property (nonatomic, retain) IBOutlet UITextField *mAlarmLabelTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *mPickerView;
@property (nonatomic, retain) IBOutlet UIButton *mSaveButton;
@property (nonatomic, retain) IBOutlet UILabel *mMedName;

@property (nonatomic, retain) NSArray *mHoursArray;
@property (nonatomic, retain) NSArray *mMinutesArray;
@property (nonatomic, retain) NSArray *mMedicinesArray;



-(IBAction)saveButtonPressed:(id)sender;

@end
