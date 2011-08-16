//
//  ModelUser.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModelUser.h"


@implementation ModelUser

@synthesize mName;
@synthesize mLogin;
@synthesize mRemeberMe;

-(id)initWithName:(NSString *)name
         login:(NSString *)login
      andRemember:(BOOL)remember
{
    if([self init] != nil)
    {
        mName = name;
        mLogin = login;
        mRemeberMe = remember;
        mID = -1;
    }
    return self;
}

-(void)dealloc
{
    [mName dealloc];
    [mLogin dealloc];
    [super dealloc];
}


@end
