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
    NSMutableArray *mMedicineArray;
    NSMutableArray *mAlarmArray;
}

@property (nonatomic, retain) ModelUser *mUser;
@property (nonatomic, retain) NSMutableArray *mMedicineArray;
@property (nonatomic, retain) NSMutableArray *mAlarmArray;

typedef enum
{
    ALARMS = 0,
    MEDICINES,
    NUM_SECTIONS
} SectionPos;

@end
