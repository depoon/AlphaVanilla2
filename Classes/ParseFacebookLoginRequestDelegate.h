//
//  ParseFacebookDelegate.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParseFacebookLoginRequestDelegate <NSObject>

-(BOOL) isCurrentFacebookUserLogin;
-(void) loginFacebook;
-(NSDictionary*) getCurrentFacebookUserProfile;
-(void) logoutFacebook;
@end
