//
//  MedicineDAO.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedAlertDB.h"

@interface MedicineDAO : NSObject {
    MedAlertDB *mMedAlertDB;
}

@property (nonatomic, retain) MedAlertDB *mMedAlertDB;

@end
