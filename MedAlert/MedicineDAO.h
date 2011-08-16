//
//  MedicineDAO.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "ModelUser.h"
#import "ModelAlarm.h"

@interface MedicineDAO : DAO {
}

-(NSMutableArray *) medicinesOfUser:(int)user_id;
-(NSMutableArray *) medicinesOfAlarm:(int)alarm_id;

@end
