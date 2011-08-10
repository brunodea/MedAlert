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
}

@property (nonatomic, retain) NSString *mName;
@property (nonatomic, retain) NSString *mLogin;
@property (assign, nonatomic) BOOL mRemeberMe;

@end
