//
//  AlarmNoteDAO.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "AlarmNote.h"

@interface AlarmNoteDAO : DAO {
    
}

-(AlarmNote *) alarmNoteFromID:(int)id_;
-(BOOL) inserAlarmNote:(AlarmNote *)alarmNote;

@end
