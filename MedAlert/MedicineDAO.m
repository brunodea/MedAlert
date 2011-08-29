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
    NSMutableArray *res = [[[NSMutableArray alloc] init] autorelease];
    NSString *sql = [NSString stringWithFormat:@"SELECT medicine.name, medicine.id, medicine_user.note \
                                                 FROM medicine, medicine_user \
                                                 WHERE medicine.id=medicine_user.medicine_id AND medicine_user.user_id=%d",user_id];
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    
    while(sqlite3_step(st) == SQLITE_ROW)
    {
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 0)];
        NSInteger mid = (NSInteger)sqlite3_column_int(st, 1);
        NSString *note = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 2)];

        ModelMedicine *medicine = [[ModelMedicine alloc] init];
        medicine.mName = name;
        medicine.mID = mid;
        medicine.mNote = note;
        
        [res addObject:(ModelMedicine *)medicine];
        [medicine release];
    }
    sqlite3_finalize(st);
    sqlite3_close([mMedAlertDB mDB]);
    
    return res;
}

-(NSMutableArray *)medicinesOfAlarm:(int)alarm_id
{
    NSMutableArray *res = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT medicine.name,medicine.id FROM medicine,alarm_medicine\
                                                 WHERE alarm_medicine.alarm_id=%d AND medicine.id = alarm_medicine.medicine_id",alarm_id];
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    
    while(st != nil && sqlite3_step(st) == SQLITE_ROW)
    {
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 0)];
        NSInteger mid = (NSInteger)sqlite3_column_int(st, 1);
        
        ModelMedicine *medicine = [[ModelMedicine alloc] init];
        medicine.mName = name;
        medicine.mID = mid;
        [res addObject:medicine];
        [medicine release];
    }
    sqlite3_finalize(st);
    sqlite3_close([mMedAlertDB mDB]);
    
    return res;
}

-(NSMutableArray *)allMedicines
{
    NSMutableArray *res = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT medicine.name,medicine.id FROM medicine"];
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    
    while(st != nil && sqlite3_step(st) == SQLITE_ROW)
    {
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(st, 0)];
        NSInteger mid = (NSInteger)sqlite3_column_int(st, 1);
        
        ModelMedicine *medicine = [[ModelMedicine alloc] init];
        medicine.mName = name;
        medicine.mID = mid;
        [res addObject:medicine];
        [medicine release];
    }
    sqlite3_finalize(st);
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
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT name FROM medicine WHERE id=%d", _id];
    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil && sqlite3_step(stmt) == SQLITE_ROW)
        found = YES;
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return found; 
}

-(BOOL) medicineExistsByUserID:(int)user_id AndMedicineID:(int)medicine_id
{
    BOOL found = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT * FROM medicine_user WHERE user_id=%d AND medicine_id=%d",user_id,medicine_id];
    
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
    if([self medicineExistsByUserID:user_id AndMedicineID:medicine_id] == YES)
        return NO;
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO medicine_user (medicine_id,user_id,note) VALUES(?,?,?)";
        sqlite3_stmt *st = nil;
        
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
        {
            NSLog(@"%s",sqlite3_errmsg(db));
            return NO;
        }
        
        sqlite3_bind_int(st, 1, medicine_id);
        sqlite3_bind_int(st, 2, user_id);
        sqlite3_bind_text(st, 3, [[NSString stringWithString:@"Sem notas."] UTF8String], -1, SQLITE_TRANSIENT);
        
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

-(NSInteger) medicineIDByName:(NSString *)name
{
    NSInteger res = -1;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT id FROM medicine WHERE name='%@'", name];
    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil && sqlite3_step(stmt) == SQLITE_ROW)
        res = sqlite3_column_int(stmt, 0);    
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return res;
}

-(NSMutableArray *) medicinesLike:(NSString *)name WithLimit:(int)limit
{
    NSMutableArray *res = [NSMutableArray array];
    
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT name,id FROM medicine WHERE name LIKE '%@%C'",name,'%'];    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil)
    {
        int count = 0;
        while(sqlite3_step(stmt) == SQLITE_ROW && count < limit)
        {
            NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            NSInteger mid = (NSInteger)sqlite3_column_int(stmt, 1);
            
            ModelMedicine *medicine = [[ModelMedicine alloc] init];
            medicine.mName = name;
            medicine.mID = mid;
            [res addObject:medicine];
            [medicine release];
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return res;
}

-(void) removeMedicineByID:(NSInteger)medicine_id FromUserByID:(NSInteger)user_id
{
    NSString *SQLquery = [NSString stringWithFormat:@"DELETE FROM medicine_user WHERE medicine_id=%d AND user_id=%d",medicine_id,user_id];    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil)
        sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    [self removeIfNotUsedMedicineByID:medicine_id];
}

-(BOOL) isMedicineUsedByID:(NSInteger)medicine_id
{
    BOOL isUsed = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT * FROM medicine_user WHERE medicine_id=%d",medicine_id];    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil)
    {
        if(sqlite3_step(stmt) == SQLITE_ROW)
            isUsed = YES;
    }
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return isUsed;
}

-(void) removeIfNotUsedMedicineByID:(NSInteger)medicine_id
{
    if([self isMedicineUsedByID:medicine_id] == NO) 
    {
        NSString *SQLquery = [NSString stringWithFormat:@"DELETE FROM medicine WHERE id=%d",medicine_id];    
        sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
        if(stmt != nil)
            sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        sqlite3_close([mMedAlertDB mDB]);
    }
}

-(BOOL) updateMedicine:(ModelMedicine *)medicine ofUser:(ModelUser *)user
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE medicine_user SET note=? WHERE medicine_id=%d AND user_id=%d",medicine.mID,user.mID];
    sqlite3_stmt *st = [mMedAlertDB query:sql];
    if(st != nil)
    {
        sqlite3_bind_text(st, 1, [medicine.mNote UTF8String], -1, SQLITE_TRANSIENT);
        if(sqlite3_step(st) != SQLITE_DONE)
            return NO;
    }
    sqlite3_finalize(st);
    sqlite3_close([mMedAlertDB mDB]);
    
    return YES;
}

@end
