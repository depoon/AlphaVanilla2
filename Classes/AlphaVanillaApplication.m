//
//  AlphaVanillaApplication.m
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "AlphaVanillaApplication.h"
#import "ParseManager.h"
#import "MainMenuViewController.h"

@implementation AlphaVanillaApplication{
    @private MainMenuViewController* mainMenuViewController;
    @private ParseManager* parseManager;
    @private UIWindow* window;
    
}

-(id) init{
    self = [super init];
    parseManager = [[ParseManager alloc]init];
    mainMenuViewController = [[MainMenuViewController alloc]init];
    [mainMenuViewController setParseFacebookLoginRequestDelegate:parseManager];
    [parseManager setParseFacebookPostLoginDelegate:mainMenuViewController];
    return self;
}

-(void) dealloc{
    if (parseManager){
        [parseManager release];
        parseManager = nil;
    }
    if (window){
        [window release];
        window = nil;
    }
    if (mainMenuViewController){
        [mainMenuViewController release];
        mainMenuViewController = nil;
    }
    [super dealloc];
}

-(void) setWindow: (UIWindow*) _window{
    if (window){
        [window release];
        window = nil;
    }
    window = [_window retain];
}




-(void) initialiseApplication:(NSDictionary *)launchOptions window: (UIWindow*) _window{
    [self setWindow:_window];
    
    
    
    [parseManager initialiseParseInApplication:launchOptions];
    
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:mainMenuViewController];
    [[navController navigationBar] setTintColor:[UIColor blackColor]];
    [window setRootViewController:navController];
    [navController release];

    
   // [parseManager testParse];
}

-(BOOL) handleOpenURL:(NSURL *)url{
    return [parseManager handleOpenURL:url];
}

-(BOOL) isCurrentFacebookUserLogin{
    return [parseManager isCurrentFacebookUserLogin];
}

-(void) loginFacebook{
    [parseManager loginFacebook];
    
}

-(NSDictionary*) getCurrentFacebookUserProfile{
    return [parseManager getCurrentFacebookUserProfile];
}


-(void) logoutFacebook{
    [parseManager logoutFacebook];
}




@end
