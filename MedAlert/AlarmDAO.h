//
//  AlarmDAO.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "ModelAlarm.h"
#import "ModelMedicine.h"

@interface AlarmDAO : DAO {
}

-(BOOL) insertAlarm:(ModelAlarm *)alarm;
-(ModelAlarm *) alarmFromID:(int)id_;

@end
