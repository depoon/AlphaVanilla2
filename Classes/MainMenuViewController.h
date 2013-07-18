//
//  MainMenuViewController.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseFacebookLoginRequestDelegate.h"
#import "ParseFacebookPostLoginDelegate.h"
#import "MainMenuStartAppActionDelegate.h"

@interface MainMenuViewController : UIViewController<ParseFacebookPostLoginDelegate, MainMenuStartAppActionDelegate>


-(void) setParseFacebookLoginRequestDelegate: (NSObject<ParseFacebookLoginRequestDelegate>*) _parseFacebookLoginRequestDelegate;

@end
