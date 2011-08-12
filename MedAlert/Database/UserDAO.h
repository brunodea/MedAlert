//
//  UserDAO.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 09/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MedAlertDB.h"
#import "ModelUser.h"

@interface UserDAO : NSObject {
    MedAlertDB *mMedAlertDB;
}

@property (nonatomic, retain) MedAlertDB *mMedAlertDB;

-(BOOL) loginExists:(NSString *)login; //verifica se o login do usuario existe no banco de dados.
-(ModelUser *) userWithLogin:(NSString *)login
               andPassword:(NSString *)password; //retorna ModelUser de acordo com seu login e password. Nil se não existir.
-(BOOL) insertUser:(ModelUser *)user
      withPassword:(NSString *)password; //insere no BD o usuário user. YES se tudo ok.

-(BOOL) adjustInfoOfUser:(ModelUser *)user;
-(NSString *) passwordOfLogin:(NSString *)login;
-(BOOL) rememberThePasswordOfLogin:(NSString *)login;

@end
