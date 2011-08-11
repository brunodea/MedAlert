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

-(BOOL) exists:(ModelUser *)user; //verifica se o login do usuario existe no banco de dados.
-(ModelUser *) isValid:(NSString *)loginAnd:(NSString *)password; //verifica se o login e senha estao corretos.
-(BOOL) insert:(ModelUser *)userWith:(NSString *)password; //insere no BD o usuário user. YES se tudo ok.
-(BOOL) adjustInfoOf:(ModelUser *)user;

@end
