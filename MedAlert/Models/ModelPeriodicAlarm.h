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

@interface ModelPeriodicAlarm : Model {
    double mAlertInterval;
    ModelAlarm *mAlarm;
}

@property (nonatomic, assign) double mAlertInterval;
@property (nonatomic, retain) ModelAlarm *mAlarm;

@end
