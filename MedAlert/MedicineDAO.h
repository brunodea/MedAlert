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
-(NSMutableArray *) allMedicines;
-(BOOL) medicineExistsByName:(NSString *)name;
-(BOOL) medicineExistsByID:(int) _id;
-(BOOL) medicineExistsByUserID:(int) user_id AndMedicineID:(int) medicine_id;
-(BOOL) insertMedicine:(ModelMedicine *)medicine;
-(BOOL) insertMedicine:(int)medicine_id RelativeToUser:(int)user_id;
-(NSInteger) medicineIDByName:(NSString *)name;
-(NSMutableArray *) medicinesLike:(NSString *)name WithLimit:(int)limit;
-(void) removeMedicineByID:(NSInteger) medicine_id FromUserByID:(NSInteger) user_id;
-(void) removeIfNotUsedMedicineByID:(NSInteger)medicine_id;
-(BOOL) updateMedicine:(ModelMedicine *)medicine ofUser:(ModelUser *)user;
@end
