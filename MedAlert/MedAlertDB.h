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
    sqlite3 *mDB;
}

@property (nonatomic, retain) NSString *mDBName;

+(MedAlertDB *)instance;

-(BOOL)isValid:(NSString *)userAnd:(NSString *)password;
-(void)createEditableCopyOfDatabaseIfNeeded;

@end
