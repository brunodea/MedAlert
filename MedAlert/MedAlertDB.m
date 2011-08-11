//
//  MedAlertDB.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedAlertDB.h"

@implementation MedAlertDB

@synthesize mDBName;
@synthesize mDBPath;
@synthesize mDB;

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
    //[filemgr removeItemAtPath:mDBPath error:nil];
    
    if([filemgr fileExistsAtPath: mDBPath] == NO)
    {
        NSLog(@"arquivo do BD nao encontrado.");
        const char *dbpath = [mDBPath UTF8String];
        
        if(sqlite3_open(dbpath, &mDB) == SQLITE_OK)
        {
            NSLog(@"BD aberto com sucesso");
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, login TEXT, password TEXT, rememberme BOOLEAN)";
            
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
}

-(void)dealloc
{
    [mDBName release];
    [mDBPath release];
    [super dealloc];
}

@end
