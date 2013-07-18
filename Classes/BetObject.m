//
//  BetObject.m
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "BetObject.h"

@implementation BetObject
@synthesize offerBetImage;
@synthesize offerDescription;
@synthesize prediction;
@synthesize offerUserObject;
@synthesize offerFacebookId;
@synthesize offerName;

-(void) dealloc{
    if (prediction){
        [prediction release];
        prediction = nil;
    }
    if (offerDescription){
        [offerDescription release];
        offerDescription = nil;
    }
    if (offerBetImage){
        [offerBetImage release];
        offerBetImage = nil;
    }
    if (offerUserObject){
        [offerUserObject release];
        offerUserObject = nil;
    }
    if (offerFacebookId){
        [offerFacebookId release];
        offerFacebookId = nil;
    }
    if (offerName){
        [offerName release];
        offerName = nil;
    }
    
    [super dealloc];
}

-(NSString*) description{
    NSMutableString* text = [NSMutableString string];
    [text appendFormat:@"\nprediction: %@", prediction];
    [text appendFormat:@"\nofferDescription: %@", offerDescription];
    [text appendFormat:@"\nofferFacebookId: %@", offerFacebookId];
    return text;

}

@end
