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

-(BOOL) loginExists:(NSString *)login
{
    BOOL found = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT name FROM user WHERE login='%@'", login];
    
    sqlite3_stmt *stmt = [mMedAlertDB query:SQLquery];
    if(stmt != nil && sqlite3_step(stmt) == SQLITE_ROW)
        found = YES;
    sqlite3_finalize(stmt);
    sqlite3_close([mMedAlertDB mDB]);
    
    return found;
}

-(ModelUser *) userWithLogin:(NSString *)login
               andPassword:(NSString *)password
{
    ModelUser *user = nil;
    NSString *SQLquery = [NSString stringWithFormat:
                          @"SELECT name,login,rememberme,id FROM user WHERE login='%@' AND password='%@'", login, password];
    
    sqlite3_stmt *statement = [mMedAlertDB query:SQLquery];
    if(statement != nil && sqlite3_step(statement) == SQLITE_ROW)
    {
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
        NSString *login = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        BOOL rememberme = (BOOL)sqlite3_column_int(statement, 2);
        int id = (int)sqlite3_column_int(statement, 3);
        
        user = [[[ModelUser alloc] initWithName:name login:login andRemember:rememberme] autorelease];
        user.mID = id;
    }
    sqlite3_finalize(statement);
    sqlite3_close([mMedAlertDB mDB]); 
    
    return user;
}

-(BOOL) insertUser:(ModelUser *)user
      withPassword:(NSString *)password
{
    if([self loginExists:user.mLogin] == YES)
        return NO;
    
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO user (name,login,password,rememberme) VALUES(?,?,?,?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(db, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        sqlite3_bind_text(st, 1, [[user mName] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 2, [[user mLogin] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 3, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(st, 4, [user mRemeberMe]);
        
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

-(BOOL) adjustInfoOfUser:(ModelUser *)user
{
    if([self loginExists:user.mLogin] == NO)
        return NO;
    
    const char *dbpath = [[mMedAlertDB mDBPath] UTF8String];
    sqlite3 *db = [mMedAlertDB mDB];
    if(sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *sql = [[NSString stringWithFormat:@"UPDATE user SET name='%@', rememberme=%d WHERE login='%@' AND id=%d",[user mName],[user mRemeberMe], [user mLogin], [user mID]] UTF8String];
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

-(NSString *) passwordOfLogin:(NSString *)login
{
    NSString *sql = [NSString stringWithFormat:@"SELECT password FROM user WHERE login='%@'", login];
    
    NSString *res = @"";

    sqlite3_stmt *statement = [mMedAlertDB query:sql];
    if(statement != nil && sqlite3_step(statement) == SQLITE_ROW)
    {
        NSString *password = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];        
        res = password;
    }
    
    sqlite3_finalize(statement);
    sqlite3_close([mMedAlertDB mDB]); 
    
    return res;
}

-(BOOL) rememberThePasswordOfLogin:(NSString *)login
{
    BOOL remember = NO;
    NSString *sql = [NSString stringWithFormat:@"SELECT rememberme FROM user WHERE login='%@'", login];
    
    sqlite3_stmt *statement = [mMedAlertDB query:sql];
    if(statement != nil && sqlite3_step(statement) == SQLITE_ROW)
    {
        remember = sqlite3_column_int(statement, 0);
    }
    
    sqlite3_finalize(statement);
    sqlite3_close([mMedAlertDB mDB]); 
    
    
    return remember;
}

@end
