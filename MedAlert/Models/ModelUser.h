//
//  ModelUser.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelUser : NSObject {
    NSInteger mId;
    NSString *mName;
    NSString *login;
    NSString *password;
}

@property (assign, nonatomic, readonly) NSInteger mID;
@property (nonatomic, retain) NSString *mName;
@property (nonatomic, retain) NSString *login;
@property (nonatomic, retain) NSString *password;

@end
