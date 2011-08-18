//
//  MedConfViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelUser.h"

@interface MedConfViewController : UIViewController {
    IBOutlet UITextField *mMedNameTextField;
    IBOutlet UIButton *mDoneButton;
    IBOutlet UITextView *mTipTextView;
    
    ModelUser *mUser;
}

@property (nonatomic, retain) IBOutlet UITextField *mMedNameTextField;
@property (nonatomic, retain) IBOutlet UIButton *mDoneButton;
@property (nonatomic, retain) IBOutlet UITextView *mTipTextView;
@property (nonatomic, retain) ModelUser *mUser;

-(IBAction)doneButtonClicked:(id)sender;
-(IBAction)userIsTyping:(id)sender;

@end
