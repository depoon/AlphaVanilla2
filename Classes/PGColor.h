//
//  PGColor.h
//  PropertyGuruSG
//
//  Created by Kenneth Chiang Hao Poon on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGColor : NSObject

+ (UIColor *)defaultTableViewColor;
+ (UIColor *)defaultTintViewColor;
+ (UIColor *)featuredListingCellBackgroundColor;
+ (UIColor *)defaultSearchBarTintColor;
+ (UIColor *)pgGrayColor;
+ (UIColor*) pgRedColor;
+ (UIColor*) pgDarkBlueColor;

-(void) setupFeaturedListingGradientBackgroundColor: (UIView*) basedView;
-(void) setupCommercialListingGradientBackgroundColor: (UIView*) basedView;
-(void) setupDefaultListingGradientBackgroundColor: (UIView*) basedView;

-(void) setupGradientBackgroundColor: (UIView*) basedView color: (UIColor*) color;
@end
