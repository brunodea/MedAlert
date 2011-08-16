//
//  DAO.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MedAlertDB.h"


@interface DAO : NSObject {
    MedAlertDB *mMedAlertDB;
}

@property (nonatomic, retain) MedAlertDB *mMedAlertDB;

@end
