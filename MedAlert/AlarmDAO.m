//
//  AlarmDAO.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlarmDAO.h"
#import "UserDAO.h"
#import "MedicineDAO.h"
#import "AlarmNoteDAO.h"


@implementation AlarmDAO

-(BOOL) insertAlarm:(ModelAlarm *)alarm
{
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO user (is_active,created_on,inits_on,type,days,id_user,id_alarm_note) VALUES(?,?,?,?,?,?,?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        
        sqlite3_bind_int(st, 1, alarm.mActive);
        
        NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
        [date_formatter setDateFormat:@"HH:mm"];
        
        sqlite3_bind_text(st, 2, [[date_formatter stringFromDate:alarm.mCreationDate] UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 3, [[date_formatter stringFromDate:alarm.mInitDate] UTF8String], -1, SQLITE_TRANSIENT);
        
        [date_formatter release];
        
        sqlite3_bind_int(st, 4, 0); //type
        sqlite3_bind_int(st, 5, 0); //days
        sqlite3_bind_int(st, 6, [alarm.mUser mID]);
        sqlite3_bind_int(st, 7, [alarm.mAlarmNote mID]);
        
        if(sqlite3_step(st) != SQLITE_DONE) 
        {
            sqlite3_finalize(st);
            sqlite3_close(db);
            return NO;
        }
        
        sqlite3_finalize(st);
    }
    sqlite3_close(db);
    
    return YES;
}

-(ModelAlarm *) alarmFromID:(int)id_
{
    return nil;
    ModelAlarm *res = nil;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT is_active,created_on,inits_on,type,days,id_user, \
                     id_alarm_note FROM alarm WHERE id=%d",id_];
    
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    if(st != nil && sqlite3_step(st) == SQLITE_ROW)
    {
        BOOL isActive = (BOOL)sqlite3_column_int(st, 0);
        NSString *created_on = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 1)];
        NSString *inits_on = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 2)];
        int type = sqlite3_column_int(st, 3);
        int days = sqlite3_column_int(st, 4);
        int iduser = sqlite3_column_int(st, 5);
        int idalarmnote = sqlite3_column_int(st, 6);
        
        sqlite3_finalize(st);
        sqlite3_close([mMedAlertDB mDB]);
        
        res = [[[ModelAlarm alloc] init] autorelease];
        res.mActive = isActive;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        
        res.mCreationDate = [dateFormatter dateFromString:created_on];
        res.mInitDate = [dateFormatter dateFromString:inits_on];
        type = 0;
        days = 0;
        
        [dateFormatter release];
        
        UserDAO *udao = [[UserDAO alloc] init];
        res.mUser = [udao userFromID:iduser];
        [udao release];
        
        MedicineDAO *mdao = [[MedicineDAO alloc] init];
        res.mMedicines = [mdao medicinesOfAlarm:id_];
        [mdao release];
        
        AlarmNoteDAO *adao = [[AlarmNoteDAO alloc] init];
        res.mAlarmNote = [adao alarmNoteFromID:idalarmnote];
    }
    
    return res;
}

@end
