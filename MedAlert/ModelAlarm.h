//
//  ModelAlarm.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import "ModelUser.h"
#import "ModelMedicine.h"
#import "AlarmNote.h"

@interface ModelAlarm : Model {
    BOOL mActive;
    ModelUser *mUser;
    NSMutableArray *mMedicines;
    AlarmNote *mAlarmNote;
    
    NSDate *mCreationDate;
    NSDate *mInitDate;
    
    BOOL mMonday;
    BOOL mTuesday;
    BOOL mWednesday;
    BOOL mThursday;
    BOOL mFriday;
    BOOL mSaturday;
    BOOL mSunday;
}

@property (nonatomic, retain) ModelUser *mUser;
@property (nonatomic, retain) NSMutableArray *mMedicines;
@property (nonatomic, retain) AlarmNote *mAlarmNote;
@property (nonatomic, retain) NSDate *mCreationDate;
@property (nonatomic, retain) NSDate *mInitDate;

@property (nonatomic, assign) BOOL mMonday;
@property (nonatomic, assign) BOOL mTuesday;
@property (nonatomic, assign) BOOL mWednesday;
@property (nonatomic, assign) BOOL mThursday;
@property (nonatomic, assign) BOOL mFriday;
@property (nonatomic, assign) BOOL mSaturday;
@property (nonatomic, assign) BOOL mSunday;

@property (nonatomic, assign) BOOL mActive;

@end
