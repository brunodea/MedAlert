//
//  ModelAlarm.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModelAlarm.h"


@implementation ModelAlarm

@synthesize mActive;
@synthesize mAlarmNote;
@synthesize mCreationDate;
@synthesize mInitDate;
@synthesize mMedicine;
@synthesize mUser;

@synthesize mMonday;
@synthesize mTuesday;
@synthesize mWednesday;
@synthesize mThursday;
@synthesize mFriday;
@synthesize mSaturday;
@synthesize mSunday;

@synthesize mType;
@synthesize mAlarmLabel;

-(id) initWithUser:(ModelUser *)user
          medicine:(ModelMedicine *)medicine
         alarmNote:(AlarmNote *)alarmNote
          initDate:(NSDate *)initDate
{
    [super init];
    
    if(self != nil)
    {
        mUser = user;
        mMedicine = medicine;
        mAlarmNote = alarmNote;
        mActive = YES;
        
        mInitDate = initDate;
        mCreationDate = [[NSDate alloc] init];
        
        mMonday = NO;
        mTuesday = NO;
        mWednesday = NO;
        mThursday = NO;
        mFriday = NO;
        mSaturday = NO;
        mSunday = NO;
    }
    
    
    return self;
}

-(void) dealloc
{
    [super dealloc];

//    [mUser dealloc];
//    [mMedicine dealloc];
//    [mAlarmNote dealloc];
//    [mInitDate dealloc];
    [mCreationDate dealloc];
}


-(NSInteger)days
{
    return 0x00000000;
}

-(void)copyAlarm:(ModelAlarm *)alarm
{
    mActive = alarm.mActive;
    mAlarmNote = alarm.mAlarmNote;
    mCreationDate = alarm.mCreationDate;
    mInitDate = alarm.mInitDate;
    mMedicine = alarm.mMedicine;
    mUser = alarm.mUser;
    
    mMonday = alarm.mMonday;
    mTuesday = alarm.mTuesday;
    mWednesday = alarm.mWednesday;
    mThursday = alarm.mThursday;
    mFriday = alarm.mFriday;
    mSaturday = alarm.mSaturday;
    mSunday = alarm.mSunday;
    
    mAlarmLabel = alarm.mAlarmLabel;
}

@end
