//
//  BetObject.h
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetObject : NSObject

@property (nonatomic, retain) NSString* prediction;
@property (nonatomic, retain) UIImage* offerBetImage;
@property (nonatomic, retain) NSString* offerDescription;
@property (nonatomic, retain) NSObject* offerUserObject;
@property (nonatomic, retain) NSString* offerFacebookId;
@property (nonatomic, retain) NSString* offerName;

@end
