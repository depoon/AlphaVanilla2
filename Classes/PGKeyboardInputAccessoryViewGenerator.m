//
//  PGKeyboardInputAccessoryViewGenerator.m
//  PropertyGuruSG
//
//  Created by Kenneth Chiang Hao Poon on 29/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PGKeyboardInputAccessoryViewGenerator.h"
@implementation PGKeyboardInputAccessoryViewGenerator


-(UIView*)generateInputAccessoryView: (NSObject<PGKeyboardInputAccessoryAction>*) target{
    UIToolbar* toolbar = [[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)]autorelease];

    [toolbar setTintColor:[UIColor blackColor]];
    
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:target action:@selector(keyboardInputAccessoryDoneButtonPressed)];
    
    
    
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, btnDone, nil]];
    [btnDone release];
    [flexibleSpace release];
    
    return toolbar;
    
}
@end
