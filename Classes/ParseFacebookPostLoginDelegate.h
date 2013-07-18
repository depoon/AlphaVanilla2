//
//  ParseFacebookPostLoginDelegate.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParseFacebookPostLoginDelegate <NSObject>

-(void) didFailedFacebookLogin: (NSString*) errorMessage;
-(void) didSuccessfulFacebookLogin: (NSString*) successMessage;
-(void) showFacebookProfile: (NSDictionary*) facebookProfileDictionary;
-(void) didSuccessfulFacebookLogout;

@end
