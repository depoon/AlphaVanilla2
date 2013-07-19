//
//  MainMenuViewManager.m
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "MainMenuViewManager.h"
#import <QuartzCore/QuartzCore.h>
#import "AnimationHandler.h"

int const MainMenuViewManager_tag_facebookLoginBaseView = 100;
int const MainMenuViewManager_tag_facebookProfileBaseView = 101;


@implementation MainMenuViewManager{
    @private UIView* mainView;
    NSObject<ParseFacebookLoginRequestDelegate>* parseFacebookLoginRequestDelegate;
    NSObject<MainMenuStartAppActionDelegate>* mainMenuStartAppActionDelegate;
    
}

-(void) dealloc{
    if (mainView){
        [mainView release];
        mainView = nil;
    }
    if (parseFacebookLoginRequestDelegate){
        [parseFacebookLoginRequestDelegate release];
        parseFacebookLoginRequestDelegate = nil;
    }
    if (mainMenuStartAppActionDelegate){
        [mainMenuStartAppActionDelegate release];
        mainMenuStartAppActionDelegate = nil;
    }
    [super dealloc];
}

-(void) setMainView: (UIView*) _mainView{
    if (mainView){
        [mainView release];
        mainView = nil;
    }
    mainView = [_mainView retain];
}

-(void) setParseFacebookLoginRequestDelegate: (NSObject<ParseFacebookLoginRequestDelegate>*) _parseFacebookLoginRequestDelegate{
    if (parseFacebookLoginRequestDelegate){
        [parseFacebookLoginRequestDelegate release];
        parseFacebookLoginRequestDelegate = nil;
    }
    parseFacebookLoginRequestDelegate = [_parseFacebookLoginRequestDelegate retain];
}

-(void) setMainMenuStartAppActionDelegate: (NSObject<MainMenuStartAppActionDelegate>*) _mainMenuStartAppActionDelegate{
    
    if (mainMenuStartAppActionDelegate){
        [mainMenuStartAppActionDelegate release];
        mainMenuStartAppActionDelegate = nil;
    }
    mainMenuStartAppActionDelegate = [_mainMenuStartAppActionDelegate retain];

}

-(void) setupBackgroundView{
    UIImage* backgroundImage = [UIImage imageNamed:@"generalBackground"];
    [mainView setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
}

-(void) setupView: (UIView*) _mainView{
    [self setMainView:_mainView];
    [self setupBackgroundView];
    /*
    UIImage* backgroundImage = [UIImage imageNamed:@"woodKitchen"];
    UIImageView* backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
    [mainView addSubview:backgroundImageView];
    [backgroundImageView release];
    */
    [self showWelcome];
    
    
    
}

-(void) showWelcome{
    UIView* welcomeView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 60)];
    [welcomeView setBackgroundColor:[UIColor clearColor]];
    welcomeView.layer.cornerRadius = 5;
    welcomeView.layer.masksToBounds = YES;
    [mainView addSubview:welcomeView];
    [welcomeView release];
    
    UIView* welcomeBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, welcomeView.frame.size.width, welcomeView.frame.size.height)];
    [welcomeBackgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [welcomeView addSubview:welcomeBackgroundView];
    [welcomeBackgroundView release];
    
    
    
    
    UILabel* welcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, 40)];
    [welcomeLabel setTextAlignment:NSTextAlignmentCenter];
    [welcomeLabel setText:@"Welcome to Bet & Snap"];
    [welcomeLabel setTextColor:[UIColor whiteColor]];
    
    [welcomeLabel setBackgroundColor:[UIColor clearColor]];
    [welcomeLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [welcomeView addSubview:welcomeLabel];
    [welcomeLabel release];
    

}

-(void) showLoginScreen{
    
    UIView* facebookLoginBaseView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 350)];
    facebookLoginBaseView.layer.cornerRadius = 5;
    facebookLoginBaseView.layer.masksToBounds = YES;
    
    [facebookLoginBaseView setBackgroundColor:[UIColor clearColor]];
    [facebookLoginBaseView setTag:MainMenuViewManager_tag_facebookLoginBaseView];
    [mainView addSubview:facebookLoginBaseView];
    [facebookLoginBaseView release];
    
    UIButton* facebookLoginButton = [[UIButton alloc]initWithFrame:CGRectMake(71, 240, 151, 43)];
    [facebookLoginButton setImage:[UIImage imageNamed:@"login-button-small"] forState:UIControlStateNormal];
    [facebookLoginButton setImage:[UIImage imageNamed:@"login-button-small-pressed"] forState:UIControlStateHighlighted];
    [facebookLoginButton addTarget:self action:@selector(loginFacebook) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel* facebookLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 95, 43)];
    [facebookLoginLabel setText:@"Login"];
    [facebookLoginLabel setTextAlignment:NSTextAlignmentCenter];
    [facebookLoginLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [facebookLoginLabel setBackgroundColor:[UIColor clearColor]];
    [facebookLoginLabel setTextColor:[UIColor whiteColor]];
    [facebookLoginButton addSubview:facebookLoginLabel];
    
    [facebookLoginLabel release];
    [facebookLoginBaseView addSubview:facebookLoginButton];
    [facebookLoginButton release];
    
    [facebookLoginBaseView setAlpha:0];
    
    AnimationHandler* animationHandler = [[AnimationHandler alloc]init];
    [animationHandler animateFadeView:facebookLoginBaseView initialAlpha:0 targetAlpha:1];
    [animationHandler release];
    

}

-(void) showFacebookProfile: (NSDictionary*) facebookProfileDictionary{
    UIView* facebookProfileBaseView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 350)];
    facebookProfileBaseView.layer.cornerRadius = 5;
    facebookProfileBaseView.layer.masksToBounds = YES;

    [facebookProfileBaseView setBackgroundColor:[UIColor clearColor]];
    [facebookProfileBaseView setTag:MainMenuViewManager_tag_facebookProfileBaseView];
    [mainView addSubview:facebookProfileBaseView];
    [facebookProfileBaseView release];
    
    UIView* facebookProfileBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, facebookProfileBaseView.frame.size.width, facebookProfileBaseView.frame.size.height)];
    [facebookProfileBackgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [facebookProfileBaseView addSubview:facebookProfileBackgroundView];
    [facebookProfileBackgroundView release];
    
    UIImage* facebookProfileImage = [self generateProfileImage: [facebookProfileDictionary objectForKey:@"pictureURL"]];
    UIImageView* facebookProfileImageView  = [[UIImageView alloc]initWithImage:facebookProfileImage];
    [facebookProfileImageView setFrame:CGRectMake(((facebookProfileBaseView.frame.size.width- facebookProfileImage.size.width)/2), 40, facebookProfileImage.size.width, facebookProfileImage.size.height)];
    [facebookProfileBaseView addSubview:facebookProfileImageView];
    [facebookProfileImageView release];
    
    UILabel* facebookProfileNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, facebookProfileImageView.frame.origin.y+facebookProfileImageView.frame.size.height+10, facebookProfileBaseView.frame.size.width, 40)];
    [facebookProfileNameLabel setFont:[UIFont systemFontOfSize:20]];
    [facebookProfileNameLabel setText:[facebookProfileDictionary objectForKey:@"name"]];
    [facebookProfileNameLabel setTextAlignment:NSTextAlignmentCenter];
    [facebookProfileNameLabel setBackgroundColor:[UIColor clearColor]];
    [facebookProfileNameLabel setTextColor:[UIColor whiteColor]];
    [facebookProfileBaseView addSubview:facebookProfileNameLabel];
    [facebookProfileNameLabel release];

    UIImage* facebookButtonImage = [UIImage imageNamed:@"login-button-small"];
    
    UIButton* facebookLogoutButton = [[UIButton alloc]initWithFrame:CGRectMake(((facebookProfileBaseView.frame.size.width- facebookButtonImage.size.width)/2), facebookProfileNameLabel.frame.origin.y+facebookProfileNameLabel.frame.size.height+20, 151, 43)];
    [facebookLogoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [facebookLogoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [facebookLogoutButton setImage:[UIImage imageNamed:@"login-button-small"] forState:UIControlStateNormal];
    [facebookLogoutButton setImage:[UIImage imageNamed:@"login-button-small-pressed"] forState:UIControlStateHighlighted];
    [facebookLogoutButton addTarget:self action:@selector(facebookLogout) forControlEvents:UIControlEventTouchUpInside];
    [facebookProfileBaseView addSubview:facebookLogoutButton];
    [facebookLogoutButton release];
    
    UILabel* facebookLogoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 95, 43)];
    [facebookLogoutLabel setText:@"Logout"];
    [facebookLogoutLabel setTextAlignment:NSTextAlignmentCenter];
    [facebookLogoutLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [facebookLogoutLabel setBackgroundColor:[UIColor clearColor]];
    [facebookLogoutLabel setTextColor:[UIColor whiteColor]];
    [facebookLogoutButton addSubview:facebookLogoutLabel];
    [facebookLogoutLabel release];
    
    
    UIButton* enterAppButton = [[UIButton alloc]initWithFrame:CGRectMake(facebookLogoutButton.frame.origin.x, facebookLogoutButton.frame.origin.y+facebookLogoutButton.frame.size.height+15, facebookLogoutButton.frame.size.width, 35)];
    [enterAppButton addTarget:self action:@selector(enterApp) forControlEvents:UIControlEventTouchUpInside];
    [enterAppButton setTitle:@"Enter App" forState:UIControlStateNormal];
    enterAppButton.layer.cornerRadius = 5;
    enterAppButton.layer.masksToBounds = YES;

    [enterAppButton setBackgroundColor:[UIColor darkGrayColor]];
    [enterAppButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [facebookProfileBaseView addSubview:enterAppButton];
    [enterAppButton release];
    
    [facebookProfileBaseView setAlpha:0];
    
    
    AnimationHandler* animationHandler = [[AnimationHandler alloc]init];
    [animationHandler animateFadeView:facebookProfileBaseView initialAlpha:0 targetAlpha:1];
    [animationHandler release];
    
}

-(UIImage*) generateProfileImage: (NSString*) urlString{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    return image;
}

-(void) resetView{
    [[mainView viewWithTag:MainMenuViewManager_tag_facebookLoginBaseView] removeFromSuperview];
    [[mainView viewWithTag:MainMenuViewManager_tag_facebookProfileBaseView] removeFromSuperview];
    
}

-(void) viewDidAppear:(BOOL)animated{

    [self reloadMainMenu];
}


-(void) reloadMainMenu{

    [self resetView];
    if ([self isCurrentFacebookUserLogin]){
        
    }else{
        [self showLoginScreen];
    }
}

-(BOOL) isCurrentFacebookUserLogin{
    if (parseFacebookLoginRequestDelegate){
        return [parseFacebookLoginRequestDelegate isCurrentFacebookUserLogin];
    }
    return NO;
}

-(void) loginFacebook{
    UIView* loginView = [mainView viewWithTag:MainMenuViewManager_tag_facebookLoginBaseView];
    
    int indicatorwidth = 30;
    UIActivityIndicatorView* activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((loginView.frame.size.width-indicatorwidth)/2, 80, indicatorwidth, indicatorwidth)];
    [loginView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    [activityIndicatorView release];
    
    if (parseFacebookLoginRequestDelegate){
        [parseFacebookLoginRequestDelegate loginFacebook];
    }
}

-(void) facebookLogout{
    if (parseFacebookLoginRequestDelegate){
        [parseFacebookLoginRequestDelegate logoutFacebook];
    }
}

-(void) didFailedFacebookLogin: (NSString*) errorMessage{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}
-(void) didSuccessfulFacebookLogin: (NSString*) successMessage{

    
    UIView* loginView = [mainView viewWithTag:MainMenuViewManager_tag_facebookLoginBaseView];
    AnimationHandler* animationHandler = [[AnimationHandler alloc]init];
    [animationHandler animateFadeView:loginView initialAlpha:1 targetAlpha:0];
    [animationHandler release];
    
    NSDictionary* facebookProfileDictionary = [parseFacebookLoginRequestDelegate getCurrentFacebookUserProfile];
    [self showFacebookProfile:facebookProfileDictionary];   
}

-(void) didSuccessfulFacebookLogout{



    UIView* profileView = [mainView viewWithTag:MainMenuViewManager_tag_facebookProfileBaseView];
    
    
    AnimationHandler* animationHandler = [[AnimationHandler alloc]init];
    [animationHandler animateFadeView:profileView initialAlpha:1 targetAlpha:0];
    [animationHandler release];
    
   // [self reloadMainMenu];
    
    [self performSelector:@selector(reloadMainMenu) withObject:nil afterDelay:0.5];
}

-(void) enterApp{
    if (mainMenuStartAppActionDelegate!=nil){
        [mainMenuStartAppActionDelegate enterApp];
    }
}

@end
