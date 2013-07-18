//
//  MainMenuViewManager.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseFacebookLoginRequestDelegate.h"
#import "ParseFacebookPostLoginDelegate.h"
#import "MainMenuStartAppActionDelegate.h"

@interface MainMenuViewManager : NSObject<ParseFacebookPostLoginDelegate>

-(void) setupView: (UIView*) _mainView;
-(void) viewDidAppear:(BOOL)animated;
-(void) setParseFacebookLoginRequestDelegate: (NSObject<ParseFacebookLoginRequestDelegate>*) _parseFacebookLoginRequestDelegate;

-(void) setMainMenuStartAppActionDelegate: (NSObject<MainMenuStartAppActionDelegate>*) _mainMenuStartAppActionDelegate;
@end
