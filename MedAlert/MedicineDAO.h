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
#import "ModelMedicine.h"

@interface MedicineDAO : DAO {
}

-(NSMutableArray *) medicinesOfUser:(int)user_id;
-(NSMutableArray *) medicinesOfAlarm:(int)alarm_id;
-(BOOL) medicineExistsByName:(NSString *)name;
-(BOOL) medicineExistsByID:(int) _id;
-(BOOL) insertMedicine:(ModelMedicine *)medicine;
-(BOOL) insertMedicine:(int)medicine_id RelativeToUser:(int)user_id;

@end
