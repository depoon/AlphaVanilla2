//
//  ParseCreateBetRequestDelegate.h
//  AlphaVanilla2
//
//  Created by Kenneth on 19/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParseCreateBetRequestDelegate <NSObject>

-(void) didSuccessfullyCreatedBet;
-(void) didFailToCreateBet: (NSString*) errorMessage;
@end
