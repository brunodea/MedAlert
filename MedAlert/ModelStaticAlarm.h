//
//  ModelStaticAlarm.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import "ModelAlarm.h"

@interface ModelStaticAlarm : ModelAlarm {
    NSDate *mTime; //HH:mm:ss
    NSInteger mAlarmID;
}

@property (nonatomic, retain) NSDate *mTime;
@property (nonatomic, assign) NSInteger mAlarmID;

@end
