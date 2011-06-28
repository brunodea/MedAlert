//
//  SignInViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 22/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SignInViewController : UIViewController {
    IBOutlet UITextField *nameTF;
    IBOutlet UITextField *loginTF;
    IBOutlet UITextField *passwordTF;
    IBOutlet UITextField *password2TF;
    
    IBOutlet UIButton *doneButton;
}

@property (nonatomic, retain) IBOutlet UITextField *nameTF;
@property (nonatomic, retain) IBOutlet UITextField *loginTF;
@property (nonatomic, retain) IBOutlet UITextField *passwordTF;
@property (nonatomic, retain) IBOutlet UITextField *password2TF;

@property (nonatomic, retain) IBOutlet UIButton *doneButton;

@end
