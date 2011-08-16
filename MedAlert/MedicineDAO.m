//
//  MedicineDAO.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedicineDAO.h"
#import "MedAlertDB.h"

@implementation MedicineDAO

-(id)init
{
    [super init];
    if(self != nil)
    {
        mMedAlertDB = [MedAlertDB instance];
    }
    
    return self;
}

-(NSMutableArray *)medicinesOfUser:(int)user_id
{
    NSMutableArray *res = [[[NSArray alloc] init] autorelease];
    NSString *sql = [NSString stringWithFormat:@"SELECT medicine_id FROM medicine_user WHERE user_id=%d",user_id];
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    NSMutableArray *medicines_id = [NSMutableArray array];
    while(st != nil && sqlite3_step(st) == SQLITE_ROW)
    {
        NSNumber *mid = [[NSNumber alloc] initWithInt:(int)sqlite3_column_int(st, 0)];
        [medicines_id addObject:mid];
        [mid release];
    }
    sqlite3_finalize(st);
    
    NSUInteger size = [medicines_id count];
    for(NSUInteger i = 0; i < size; i++)
    {
        NSInteger v = (NSInteger)[medicines_id objectAtIndex:i];
        NSString *s = [NSString stringWithFormat:@"SELECT name FROM medicine WHERE id=%d",v];
        st = [mMedAlertDB query:s];
        if(sqlite3_step(st) == SQLITE_ROW)
        {
            NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 0)];
            ModelMedicine *medicine = [[ModelMedicine alloc] init];
            medicine.mName = name;
            medicine.mID = v;
            [res addObject:medicine];
            [medicine release];
        }
        sqlite3_finalize(st);
    }
    sqlite3_close([mMedAlertDB mDB]);
    
    return res;
}

-(NSMutableArray *)medicinesOfAlarm:(int)alarm_id
{
    NSMutableArray *res = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT medicine_id FROM alarm_medicine WHERE alarm_id=%d",alarm_id];
    NSMutableArray *medicines_id = [NSMutableArray array];
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    while(st != nil && sqlite3_step(st) == SQLITE_ROW)
    {
        NSNumber *mid = [[NSNumber alloc] initWithInt:(int)sqlite3_column_int(st, 0)];
        [medicines_id addObject:mid];
        [mid release];
    }
    sqlite3_finalize(st);
    
    NSUInteger size = [medicines_id count];
    for(NSUInteger i = 0; i < size; i++)
    {
        NSInteger v = (NSInteger)[medicines_id objectAtIndex:i];
        NSString *s = [NSString stringWithFormat:@"SELECT name FROM medicine WHERE id=%d",v];
        st = [mMedAlertDB query:s];
        if(sqlite3_step(st) == SQLITE_ROW)
        {
            NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 0)];
            ModelMedicine *medicine = [[ModelMedicine alloc] init];
            medicine.mName = name;
            medicine.mID = v;
            [res addObject:medicine];
            [medicine release];
        }
        sqlite3_finalize(st);
    }
    sqlite3_close([mMedAlertDB mDB]);
    
    return res;
}

-(BOOL) medicineExistsByName:(NSString *)name
{
    BOOL found = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT id FROM medicine WHERE name='%@'", name];
    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil && sqlite3_step(stmt) == SQLITE_ROW)
        found = YES;
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return found;
}

-(BOOL) medicineExistsByID:(int)_id
{
    BOOL found = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT name FROM medicine WHERE id='%@'", [[NSString alloc] initWithFormat:@"%d",_id]];
    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil && sqlite3_step(stmt) == SQLITE_ROW)
        found = YES;
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return found; 
}

-(BOOL) insertMedicine:(ModelMedicine *)medicine
{
    if([self medicineExistsByName:[medicine mName]] == YES)
        return NO;
    
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO medicine (name) VALUES(?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        sqlite3_bind_text(st, 1, [[medicine mName] UTF8String], -1, SQLITE_TRANSIENT);
        
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

-(BOOL) insertMedicine:(int)medicine_id RelativeToUser:(int)user_id
{
    if([self medicineExistsByID:user_id] == YES)
        return NO;
    
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO medicine_user (medicine_id,user_id) VALUES(?,?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        sqlite3_bind_int(st, 1, medicine_id);
        sqlite3_bind_int(st, 2, user_id);
        
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
