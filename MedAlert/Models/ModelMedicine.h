//
//  ModelMedicine.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface ModelMedicine : Model {
    NSString *mName;
    NSString *mNote;
}

@property (nonatomic, retain) NSString *mName;
@property (nonatomic, retain) NSString *mNote;

@end
