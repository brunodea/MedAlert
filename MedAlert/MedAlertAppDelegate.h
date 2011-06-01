//
//  MedAlertAppDelegate.h
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 01/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MedAlertViewController;

@interface MedAlertAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MedAlertViewController *viewController;

@end
