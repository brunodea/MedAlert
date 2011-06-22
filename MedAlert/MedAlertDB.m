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

-(BOOL)isValid:(NSString *)userAnd :(NSString *)password
{
    NSLog(@"username:%@\npassword:%@", userAnd, password);
    
    return NO;
}

-(void)createEditableCopyOfDatabaseIfNeeded 
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString * databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:mDBName]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        NSLog(@"arquivo nao encontrado.");
        const char *dbpath = [databasePath UTF8String];
        
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
    [super dealloc];
}

@end
