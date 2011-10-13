//
//  PeriodicAlarmDAO.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "ModelPeriodicAlarm.h"

@interface PeriodicAlarmDAO : DAO {
    
}

-(BOOL)insertPeriodicAlarm:(ModelPeriodicAlarm *)alarm;
-(ModelPeriodicAlarm *)periodicAlarmByID:(NSInteger)alarm_id;

@end
