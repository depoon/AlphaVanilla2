//
//  AnimationHandler.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationHandler : NSObject

- (void)animateflipView: (UIView*) containerView outgoingView: (UIView*) outgoingView incomingView: (UIView*) incomingView;
- (void)animateflipView: (UIView*) containerView outgoingView: (UIView*) outgoingView incomingView: (UIView*) incomingView shouldHideStatusBarOnIncomingView: (BOOL) shouldHideStatusBarOnIncomingView;

-(void) animateSlideView: (UIView*) slideUpView  initialYPoint: (int) initialYPoint destinationYPoint: (int) destinationYPoint delegate: (id) delegate  selector: (SEL) selector;
-(void) animateSlideView: (UIView*) slideUpView  initialYPoint: (int) initialYPoint destinationYPoint: (int) destinationYPoint;
-(void) animateFadeView: (UIView*) fadeView initialAlpha: (float) initialAlpha targetAlpha: (float) targetAlpha;
-(void) animateFadeView: (UIView*) fadeView initialAlpha: (float) initialAlpha targetAlpha: (float) targetAlpha delegate: (id) delegate  selector: (SEL) selector;
@end
