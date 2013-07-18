//
//  AnimationHandler.m
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "AnimationHandler.h"

@implementation AnimationHandler

- (void)animateflipView: (UIView*) containerView outgoingView: (UIView*) outgoingView incomingView: (UIView*) incomingView shouldHideStatusBarOnIncomingView: (BOOL) shouldHideStatusBarOnIncomingView{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationTransition:(outgoingView.hidden == NO ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight) forView:containerView cache:YES];
    
    outgoingView.hidden = YES;
    incomingView.hidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:shouldHideStatusBarOnIncomingView withAnimation:UIStatusBarAnimationNone];
    
	[UIView commitAnimations];
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationTransition:(outgoingView.hidden == NO ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:containerView cache:YES];
    
    
    //    [[UIApplication sharedApplication] setStatusBarHidden:shouldHideStatusBarOnIncomingView withAnimation:UIStatusBarAnimationFade];
    
    
    [UIView commitAnimations];
    
}

- (void)animateflipView: (UIView*) containerView outgoingView: (UIView*) outgoingView incomingView: (UIView*) incomingView{
    
    BOOL isStatusBarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
    [self animateflipView:containerView outgoingView:outgoingView incomingView:incomingView shouldHideStatusBarOnIncomingView:isStatusBarHidden];
}

-(void) animateSlideView: (UIView*) slideUpView  initialYPoint: (int) initialYPoint destinationYPoint: (int) destinationYPoint delegate: (id) delegate  selector: (SEL) selector{
    
    CGRect frame = slideUpView.frame;
    frame.origin.y = initialYPoint;
    slideUpView.frame = frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.8];
    
    frame.origin.y = destinationYPoint;
    slideUpView.frame = frame;
    
    if (delegate!=nil && selector!=nil){
        [UIView setAnimationDelegate:delegate];
        [UIView setAnimationDidStopSelector:selector];
    }
    [UIView commitAnimations];
}

-(void) animateSlideView: (UIView*) slideUpView  initialYPoint: (int) initialYPoint destinationYPoint: (int) destinationYPoint{
    [self animateSlideView:slideUpView initialYPoint:initialYPoint destinationYPoint:destinationYPoint delegate:nil selector:nil];
}

-(void) animateFadeView: (UIView*) fadeView initialAlpha: (float) initialAlpha targetAlpha: (float) targetAlpha delegate: (id) delegate  selector: (SEL) selector{
    fadeView.alpha = initialAlpha;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    fadeView.alpha = targetAlpha;
    if (delegate!=nil && selector!=nil){
        [UIView setAnimationDelegate:delegate];
        [UIView setAnimationDidStopSelector:selector];
    }
    [UIView commitAnimations];
}

-(void) animateFadeView: (UIView*) fadeView initialAlpha: (float) initialAlpha targetAlpha: (float) targetAlpha{
    [self animateFadeView:fadeView initialAlpha:initialAlpha targetAlpha:targetAlpha delegate:nil selector:nil];
}

@end
