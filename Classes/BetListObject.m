//
//  BetListObject.m
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "BetListObject.h"

@implementation BetListObject{
    @private NSMutableArray* betArray;
}

-(id) init{
    self = [super init];
    betArray = [[NSMutableArray alloc]init];
    return self;
}

-(void) dealloc{
    if (betArray){
        [betArray removeAllObjects];
        [betArray release];
        betArray = nil;
    }
    [super dealloc];
}

-(int) getTotalCount{
    return [betArray count];
}

-(void) addBetsArray: (NSArray*) _inputBetsArray{
    [betArray addObjectsFromArray:_inputBetsArray];
}

-(void) clearAllBets{
    [betArray removeAllObjects];
}

-(BetObject*) getBetAtIndex: (int) i{
    return [betArray objectAtIndex:i];
}




@end
