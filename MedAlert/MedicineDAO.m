//
//  MedicineDAO.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedicineDAO.h"


@implementation MedicineDAO

@synthesize mMedAlertDB;

-(id)init
{
    [super init];
    if(self != nil)
    {
        mMedAlertDB = [MedAlertDB instance];
    }
    
    return self;
}

@end
