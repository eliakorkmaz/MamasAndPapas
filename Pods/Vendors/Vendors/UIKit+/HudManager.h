//
// Created by SERDAR YILLAR on 7/10/13.
// Copyright (c) 2013 Spacesheep. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface HudManager : NSObject

	+ ( HudManager * )instance;

	- ( void )showWithTitle:( NSString * )string status:( NSString * )status afterDelay:( CGFloat )delay;

	- ( void )dismissWithSuccess:( NSString * )status title:( NSString * )title afterDelay:( CGFloat )delay;

	- ( void )dismissWithError:( NSString * )title afterDelay:( CGFloat )delay;

	- ( void )dismissAfterDelay:( CGFloat )delay;
@end
