//
//  ProfileTableViewController.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModelUser.h"
#import "ModelMedicine.h"

@interface ProfileTableViewController : UITableViewController {
    ModelUser *mUser;
    NSArray *mMedicineArray;
}

@property (nonatomic, retain) ModelUser *mUser;
@property (nonatomic, retain) NSArray *mMedicineArray;

@end
