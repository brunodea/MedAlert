//
//  AlarmNote.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"


@interface AlarmNote : Model {
    NSString *mNote;
}

@property (nonatomic, retain) NSString *mNote;

@end
