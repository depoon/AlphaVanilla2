//
//  MainMenuViewController.m
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MainMenuViewManager.h"
#import "MainModuleViewController.h"

@implementation MainMenuViewController{
    @private MainMenuViewManager* mainMenuViewManager;
    @private NSObject<ParseFacebookLoginRequestDelegate>* parseFacebookLoginRequestDelegate;
}

-(id) init{
    self = [super init];
    mainMenuViewManager = [[MainMenuViewManager alloc]init];
    [mainMenuViewManager setMainMenuStartAppActionDelegate:self];
    return self;
}

-(void) dealloc{
    if (mainMenuViewManager){
        [mainMenuViewManager release];
        mainMenuViewManager = nil;
    }
    if (parseFacebookLoginRequestDelegate){
        [parseFacebookLoginRequestDelegate release];
        parseFacebookLoginRequestDelegate = nil;
    }
    [super dealloc];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    [mainMenuViewManager setupView: self.view];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [mainMenuViewManager viewDidAppear:animated];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


-(void) setParseFacebookLoginRequestDelegate: (NSObject<ParseFacebookLoginRequestDelegate>*) _parseFacebookLoginRequestDelegate{
    if (parseFacebookLoginRequestDelegate){
        [parseFacebookLoginRequestDelegate release];
        parseFacebookLoginRequestDelegate = nil;
    }
    parseFacebookLoginRequestDelegate = [_parseFacebookLoginRequestDelegate retain];
    [mainMenuViewManager setParseFacebookLoginRequestDelegate:parseFacebookLoginRequestDelegate];
}



-(void) didFailedFacebookLogin: (NSString*) errorMessage{
    [mainMenuViewManager didFailedFacebookLogin:errorMessage];
}
-(void) didSuccessfulFacebookLogin: (NSString*) successMessage{
    [mainMenuViewManager didSuccessfulFacebookLogin:successMessage];
}

-(void) showFacebookProfile: (NSDictionary*) facebookProfileDictionary{
    [mainMenuViewManager showFacebookProfile:facebookProfileDictionary];
}

-(void) didSuccessfulFacebookLogout{
    [mainMenuViewManager didSuccessfulFacebookLogout];
}

-(void) enterApp{
    MainModuleViewController* mainModuleViewController = [[MainModuleViewController alloc]init];
    [self.navigationController pushViewController:mainModuleViewController animated:YES];
    [mainModuleViewController release];
}

@end
