//
//  PGKeyboardInputAccessoryViewGenerator.h
//  PropertyGuruSG
//
//  Created by Kenneth Chiang Hao Poon on 29/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGKeyboardInputAccessoryAction.h"

@interface PGKeyboardInputAccessoryViewGenerator : NSObject

-(UIView*)generateInputAccessoryView: (NSObject<PGKeyboardInputAccessoryAction>*) target;

@end
