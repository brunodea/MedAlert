//
//  PeriodicAlarmDAO.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PeriodicAlarmDAO.h"
#import "AlarmDAO.h"

@implementation PeriodicAlarmDAO

-(BOOL)insertPeriodicAlarm:(ModelPeriodicAlarm *)alarm
{
    AlarmDAO *adao = [[AlarmDAO alloc] init];
    if([adao insertAlarm:alarm] == NO)
    {
        [adao release];
        return NO;
    }
    [adao release];
    
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO periodic_alarm(alert_interval,id_alarm) VALUES(?,?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        sqlite3_bind_int(st, 1, [alarm mAlertInterval]);
        sqlite3_bind_int(st, 2, [alarm mAlarmID]);
        
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

-(ModelPeriodicAlarm *)periodicAlarmByID:(NSInteger)alarm_id
{
    ModelPeriodicAlarm *res = nil;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT alert_interval,id_alarm FROM periodic_alarm WHERE id=%d",alarm_id];
    
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    if(st != nil && sqlite3_step(st) == SQLITE_ROW)
    {
        NSNumber *alert_interval = (NSNumber *)sqlite3_column_int(st, 0);
        NSInteger id_alarm = sqlite3_column_int(st, 1);
        
        sqlite3_finalize(st);
        sqlite3_close([mMedAlertDB mDB]);
        
        res = [[ModelPeriodicAlarm alloc] init];
        res.mAlertInterval = [alert_interval doubleValue];
        res.mAlarmID = id_alarm;
        
        AlarmDAO *adao = [[AlarmDAO alloc] init];
        ModelAlarm *alarm = [adao alarmFromID:id_alarm];
        
        [res copyAlarm:alarm];
        [adao release];
    }
    
    return res;
}

@end
