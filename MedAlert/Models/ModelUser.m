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

-(id)initWith:(NSString *)nameAnd:(NSString *)loginAnd:(BOOL)rememberMe
{
    if([self init] != nil)
    {
        mName = nameAnd;
        mLogin = loginAnd;
        mRemeberMe = rememberMe;
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
