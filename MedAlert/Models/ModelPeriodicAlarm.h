//
//  ModelPeriodicAlarm.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import "ModelAlarm.h"

@interface ModelPeriodicAlarm : ModelAlarm {
    double mAlertInterval;
    NSInteger mAlarmID;
}

@property (nonatomic, assign) double mAlertInterval;
@property (nonatomic, assign) NSInteger mAlarmID;

@end
