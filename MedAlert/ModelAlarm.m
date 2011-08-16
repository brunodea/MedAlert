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
@synthesize mMedicines;
@synthesize mUser;

@synthesize mMonday;
@synthesize mTuesday;
@synthesize mWednesday;
@synthesize mThursday;
@synthesize mFriday;
@synthesize mSaturday;
@synthesize mSunday;

-(id) initWithUser:(ModelUser *)user
          medicines:(NSMutableArray *)medicines
         alarmNote:(AlarmNote *)alarmNote
          initDate:(NSDate *)initDate
{
    [super init];
    
    if(self != nil)
    {
        mUser = user;
        mMedicines = medicines;
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

//-(void) dealloc
//{
//    [super dealloc];
//    
//    [mCreationDate dealloc];
//    [mUser dealloc];
//    [mMedicine dealloc];
//    [mAlarmNote dealloc];
//    [mInitDate dealloc];
//    [mCreationDate dealloc];
//}


@end
