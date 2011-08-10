//
//  MedAlertDB.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface MedAlertDB : NSObject {
    NSString *mDBName;
    NSString *mDBPath;
    sqlite3 *mDB;
}

@property (nonatomic, retain) NSString *mDBName;
@property (nonatomic, readonly) NSString *mDBPath;
@property (nonatomic, readonly) sqlite3 *mDB;

+(MedAlertDB *)instance;
-(sqlite3_stmt *)query:(NSString *)SQLquery;
-(void)createEditableCopyOfDatabaseIfNeeded;

@end
