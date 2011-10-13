//
//  ModelStaticAlarm.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModelStaticAlarm.h"


@implementation ModelStaticAlarm

@synthesize mTime;
@synthesize mAlarmID;

-(id)init
{
    [super init];
    if(self != nil)
        mType = 1;
    return self;
}

@end
