//
//  AlarmNoteDAO.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlarmNoteDAO.h"


@implementation AlarmNoteDAO

-(AlarmNote *)alarmNoteFromID:(int)id_
{
    AlarmNote *res = nil;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT note FROM alarm_note WHERE id=%d",id_];
    
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    if(st != nil && sqlite3_step(st) == SQLITE_ROW)
    {
        NSString *note = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 0)];
        res = [[[AlarmNote alloc] init] autorelease];
        res.mNote = note;
        res.mID = id_;
    }
    
    sqlite3_finalize(st);
    sqlite3_close([mMedAlertDB mDB]);
    
    return res;
}

-(BOOL)inserAlarmNote:(AlarmNote *)alarmNote
{
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO alarm_note(note) VALUES(?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        sqlite3_bind_text(st, 1, [[alarmNote mNote] UTF8String], -1, SQLITE_TRANSIENT);
        
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

@end
