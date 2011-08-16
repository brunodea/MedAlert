//
//  MedConfViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MedConfViewController : UIViewController {
    IBOutlet UITextField *mMedName;
    IBOutlet UIButton *mDoneButton;
}

@property (nonatomic, retain) IBOutlet UITextField *mMedName;
@property (nonatomic, retain) IBOutlet UIButton *mDoneButton;

-(IBAction)doneButtonClicked:(id)sender;

@end
