//
//  ModelPeriodicAlarm.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModelPeriodicAlarm.h"


@implementation ModelPeriodicAlarm

@synthesize mAlertInterval;
@synthesize mAlarmID;

-(id)init
{
    [super init];
    if(self != nil)
        mType = 0;
    return self;
}

@end
