//
//  AlphaVanillaApplication.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseManagerDelegate.h"
#import "ParseFacebookLoginRequestDelegate.h"


@interface AlphaVanillaApplication : NSObject<ParseManagerDelegate, ParseFacebookLoginRequestDelegate>

-(void) initialiseApplication:(NSDictionary *)launchOptions window: (UIWindow*) _window;
@end
