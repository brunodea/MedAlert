//
//  MedNoteViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 29/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModelMedicine.h"
#import "ModelUser.h"

@interface MedNoteViewController : UIViewController {
    IBOutlet UITextView *mNoteTextView;
    IBOutlet UIButton *mSaveButton;
    IBOutlet UILabel *mMedNameLabel;
    
    ModelMedicine *mMedicine;
    ModelUser *mUser;
}

@property (nonatomic, retain) IBOutlet UITextView *mNoteTextView;
@property (nonatomic, retain) IBOutlet UIButton *mSaveButton;
@property (nonatomic, retain) IBOutlet UILabel *mMedNameLabel;

@property (nonatomic, retain) ModelMedicine *mMedicine;
@property (nonatomic, retain) ModelUser *mUser;

-(IBAction) saveButtonPressed:(id)sender;

@end
