//
//  ModelUser.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelUser : NSObject {
    NSString *mName;
    NSString *mLogin; //login eh unico.
    
    BOOL mRemeberMe;
    int mID;
}

@property (nonatomic, retain) NSString *mName;
@property (nonatomic, retain) NSString *mLogin;
@property (assign, nonatomic) BOOL mRemeberMe;
@property (assign, nonatomic) int mID;

-(id)initWithName:(NSString *)name
         login:(NSString *)login
      andRemember:(BOOL)remember;

@end
