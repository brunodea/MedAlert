//
//  ModelMedicine.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelMedicine : NSObject {
    NSString *mName;
    int mID;
}

@property (nonatomic, retain) NSString *mName;
@property (nonatomic, assign) int mID;

@end
