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

+(MedAlertDB *)instance;

-(BOOL)exists:(NSString *)user;
-(BOOL)isValid:(NSString *)userAnd:(NSString *)password;
-(BOOL)insertUser:(NSString *)nameAnd:(NSString *)loginAnd:(NSString *)password;
-(void)createEditableCopyOfDatabaseIfNeeded;

@end
