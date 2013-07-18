//
//  BetListObject.h
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BetObject.h"

@interface BetListObject : NSObject

-(int) getTotalCount;
-(void) addBetsArray: (NSArray*) _inputBetsArray;

-(void) clearAllBets;
-(BetObject*) getBetAtIndex: (int) i;
@end
