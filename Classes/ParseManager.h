//
//  ParseManager.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseManagerDelegate.h"
#import "ParseFacebookLoginRequestDelegate.h"
#import "ParseFacebookPostLoginDelegate.h"
#import "BetObject.h"
#import "ParseQueryBetRequestDelegate.h"
#import "ParseCreateBetRequestDelegate.h"


@interface ParseManager : NSObject<ParseManagerDelegate, ParseFacebookLoginRequestDelegate>

-(void) initialiseParseInApplication:(NSDictionary *)launchOptions;
-(void) setParseFacebookPostLoginDelegate: (NSObject<ParseFacebookPostLoginDelegate>*) _parseFacebookPostLoginDelegate;
-(void) setParseQueryBetRequestDelegate: (NSObject<ParseQueryBetRequestDelegate>*) _parseQueryBetRequestDelegate;
-(void) setParseCreateBetRequestDelegate: (NSObject<ParseCreateBetRequestDelegate>*) _parseCreateBetRequestDelegate;
-(NSObject*) getCurrentUser;
-(void) createNewBetByOffer: (BetObject*) _betObject;
-(void) queryAllBets;

-(void) testParse;

@end
