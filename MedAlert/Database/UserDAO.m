//
//  UserDAO.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserDAO.h"
#import "ModelUser.h"

@implementation UserDAO

@synthesize mMedAlertDB;

-(id) init
{
    self = [super init];
    if(self != nil)
        mMedAlertDB = [MedAlertDB instance];
    return self;
}

-(BOOL) exists:(ModelUser *)user
{
    BOOL found = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT name FROM user WHERE login='%@'",[user mLogin]];
    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil && sqlite3_step(stmt) == SQLITE_ROW)
        found = YES;
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return found;
}

-(ModelUser *)isValid:(NSString *)userAnd :(NSString *)password
{
    ModelUser *user = nil;
    NSString *SQLquery = [NSString stringWithFormat:
                          @"SELECT name,login FROM user WHERE login='%@' AND password='%@'", userAnd, password];
    
    sqlite3_stmt *statement = [mMedAlertDB query:SQLquery];
    if(statement != nil && sqlite3_step(statement) == SQLITE_ROW)
    {
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
        NSString *login = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        
        user = [[ModelUser alloc] initWith:name:login:NO];
    }
    sqlite3_finalize(statement);
    sqlite3_close([mMedAlertDB mDB]); 
    
    return user;
}

-(BOOL)insert:(ModelUser *)userWith:(NSString *)password
{
    if([self exists:userWith] == YES)
        return NO;
    
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO user (name,login,password,rememberme) VALUES(?,?,?,?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        sqlite3_bind_text(st, 1, [[userWith mName] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 2, [[userWith mLogin] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 3, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(st, 4, [userWith mRemeberMe]);
        
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

-(BOOL) adjustInfoOf:(ModelUser *)user
{
    if([self exists:user] == NO)
        return NO;
    NSLog(@"gehehe");
    
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = [[NSString stringWithFormat:@"UPDATE user SET name='%@', rememberme=%d WHERE login='%@'",[user mName],[user mRemeberMe], [user mLogin]] UTF8String];
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        
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
