//
//  MedAlertDB.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedAlertDB.h"

@interface MedAlertDB (hiden)

-(sqlite3_stmt *)query:(NSString *)SQLquery;

@end

@implementation MedAlertDB

@synthesize mDBName;

static MedAlertDB *msInstance = nil;

+(MedAlertDB *)instance
{
    @synchronized([MedAlertDB class])
    {        if(!msInstance)
        {            [[self alloc] init];
            return msInstance;
        }
        return msInstance;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([MedAlertDB class])
    {
        NSAssert(msInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        msInstance = [super alloc];
        return msInstance;
    }
    return nil;
}

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        mDBName = @"medalert.db";
        [self createEditableCopyOfDatabaseIfNeeded];
    }
    return self;
}

-(sqlite3_stmt *)query:(NSString *)SQLquery
{
    const char *dbpath = [mDBPath UTF8String];
    sqlite3_stmt *statement = nil;
    if(sqlite3_open(dbpath, &mDB) == SQLITE_OK)
    {
        const char *query_stmt = [SQLquery UTF8String];
        
        if(sqlite3_prepare_v2(mDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            return statement;
        }
    }
    
    return statement;
}

-(BOOL)exists:(NSString *)user
{
    BOOL found = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT name FROM user WHERE login='%@'",user];
    
    sqlite3_stmt *stmt = [self query:SQLquery];
    if(stmt != nil && sqlite3_step(stmt) == SQLITE_ROW)
        found = YES;
    sqlite3_finalize(stmt);
    sqlite3_close(mDB);
    
    return found;
}

-(BOOL)isValid:(NSString *)userAnd :(NSString *)password
{
    BOOL found = NO;
    NSString *SQLquery = [NSString stringWithFormat:@"SELECT name FROM user WHERE login='%@'", userAnd];
    
    sqlite3_stmt *statement = [self query:SQLquery];
    if(statement != nil && sqlite3_step(statement) == SQLITE_ROW)
    {   
        found = YES;
    }
    sqlite3_finalize(statement);
    sqlite3_close(mDB);    
    return found;
}

-(BOOL)insertUser:(NSString *)nameAnd :(NSString *)loginAnd :(NSString *)password
{
    if([self exists:loginAnd] == YES)
        return NO;
    
    const char *dbpath = [mDBPath UTF8String];
    if(sqlite3_open(dbpath, &mDB) == SQLITE_OK)
    {
        const char *sql = "INSERT INTO user (name,login,password) VALUES(?,?,?)";
        sqlite3_stmt *st = nil;
        if(sqlite3_prepare_v2(mDB, sql, -1, &st, NULL) != SQLITE_OK)
            return NO;
        sqlite3_bind_text(st, 1, [nameAnd UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 2, [loginAnd UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(st, 3, [password UTF8String], -1, SQLITE_TRANSIENT);
    
        if(sqlite3_step(st) != SQLITE_DONE) 
        {
            sqlite3_finalize(st);
            sqlite3_close(mDB);
            return NO;
        }
    
        sqlite3_finalize(st);
    }
    sqlite3_close(mDB);
    
    return YES;
}

-(void)createEditableCopyOfDatabaseIfNeeded 
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    mDBPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:mDBName]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath: mDBPath ] == NO)
    {
        NSLog(@"arquivo do BD nao encontrado.");
        const char *dbpath = [mDBPath UTF8String];
        
        if(sqlite3_open(dbpath, &mDB) == SQLITE_OK)
        {
            NSLog(@"BD aberto com sucesso");
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, login TEXT, password TEXT)";
            
            if(sqlite3_exec(mDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
                //status.text = ;
            }
            else
                NSLog(@"Tabela criada com sucesso");
            
            sqlite3_close(mDB);
            
        } else {
            NSLog(@"Failed to open/create database");
            //status.text = @"Failed to open/create database";
        }
    }
    [filemgr release];

    /*
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"medalert.db"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) 
        return;
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"medalert.db"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) 
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }*/
}

-(void)dealloc
{
    [mDBName release];
    [mDBPath release];
    [super dealloc];
}

@end
