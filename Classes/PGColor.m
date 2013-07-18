//
//  PGColor.m
//  PropertyGuruSG
//
//  Created by Kenneth Chiang Hao Poon on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PGColor.h"
#import <QuartzCore/CAGradientLayer.h>

@implementation PGColor

+ (UIColor *)defaultTableViewColor{
    return [UIColor colorWithRed:230/255.0 green:229/255.0 blue:228/255.0 alpha:1];
}

+ (UIColor *)defaultTintViewColor{
    return [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
}

+ (UIColor *)featuredListingCellBackgroundColor{
    //return [UIColor colorWithRed:251/255.0 green:239/255.0 blue:239/255.0 alpha:1];    
    return [UIColor colorWithRed:250/255.0 green:222/255.0 blue:156/255.0 alpha:1];    
}

+ (UIColor *)commercialListingCellBackgroundColor{
    return [UIColor colorWithRed:204/255.0 green:236/255.0 blue:255/255.0 alpha:1];    
}

+ (UIColor *)defaultSearchBarTintColor{
    return [UIColor lightGrayColor];    
}

+ (UIColor *)pgGrayColor{
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];    
}    

+ (UIColor*) pgRedColor{
    return [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];        
}

+ (UIColor*) pgDarkBlueColor{
    return [UIColor colorWithRed:30/255.0 green:70/255.0 blue:124/255.0 alpha:1];        
}


-(void) updateViewWithGradientLayer:(UIView*) basedView layer: (CAGradientLayer *)layer {
    NSMutableArray* sublayerArray = [NSMutableArray arrayWithArray:[basedView.layer sublayers]];
    for (int i=0; i<[sublayerArray count]; i++){
        NSObject* originalLayer = [sublayerArray objectAtIndex:i];
        if ([originalLayer isKindOfClass:[CAGradientLayer class]]){
            [sublayerArray removeObjectAtIndex:i];
            i--;
        }
    }
    [sublayerArray insertObject:layer atIndex:0];
    [basedView.layer setSublayers:sublayerArray];
}

- (void)generateLayerLocationsArray:(CAGradientLayer *)layer {
    layer.locations = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:0.0f],
                       [NSNumber numberWithFloat:0.10f],
                       [NSNumber numberWithFloat:0.25f],
                       [NSNumber numberWithFloat:0.30f],
                       [NSNumber numberWithFloat:0.40f],
                       [NSNumber numberWithFloat:1.0f],
                       nil];
}

-(void) setupGradientBackgroundColor: (UIView*) basedView color: (UIColor*) color{
    CAGradientLayer *layer = [CAGradientLayer layer];
    const CGFloat *cs = CGColorGetComponents(color.CGColor);
    
    // create the colors for our gradient 
    // based on the color passed in
    
    layer.colors = [NSArray arrayWithObjects:
                    (id)[color CGColor],
                    (id)[[UIColor colorWithRed:1.00f/0.96f*cs[0] 
                                         green:1.00f/0.96f*cs[1] 
                                          blue:1.00f/0.96f*cs[2] 
                                         alpha:1] CGColor],
                    (id)[[UIColor colorWithRed:0.99f/0.96f*cs[0] 
                                         green:0.99f/0.96f*cs[1] 
                                          blue:0.99f/0.96f*cs[2] 
                                         alpha:1] CGColor],
                    (id)[[UIColor colorWithRed:0.98f/0.96f*cs[0] 
                                         green:0.98f/0.96f*cs[1] 
                                          blue:0.98f/0.96f*cs[2] 
                                         alpha:1] CGColor],
                    (id)[[UIColor colorWithRed:0.96f/0.96f*cs[0] 
                                         green:0.96f/0.96f*cs[1] 
                                          blue:0.96f/0.96f*cs[2] 
                                         alpha:1] CGColor],
                    (id)[[UIColor colorWithRed:0.94f/0.96f*cs[0] 
                                         green:0.94f/0.96f*cs[1] 
                                          blue:0.94f/0.96f*cs[2] 
                                         alpha:1] CGColor],
                    
                    nil];
  
    [self generateLayerLocationsArray:layer];
    
    layer.frame = basedView.bounds;
    
    [self updateViewWithGradientLayer: basedView layer:layer];
}

-(void) setupDefaultCellBackgroundColor: (UIView*) basedView{
    CAGradientLayer *layer = [CAGradientLayer layer];

    
    // create the colors for our gradient 
    // based on the color passed in
    
    layer.colors = [NSArray arrayWithObjects:
                    (id)[[UIColor whiteColor] CGColor],
                    (id)[[UIColor whiteColor] CGColor],
                    (id)[[UIColor whiteColor] CGColor],
                    (id)[[UIColor whiteColor] CGColor],
                    (id)[[UIColor whiteColor] CGColor],
                    (id)[[UIColor whiteColor] CGColor],
                    nil];
  
    [self generateLayerLocationsArray:layer];
    
    layer.frame = basedView.bounds;
    
    [self updateViewWithGradientLayer: basedView layer:layer];
}




-(void) setupFeaturedListingGradientBackgroundColor: (UIView*) basedView{
    UIColor* color = [PGColor featuredListingCellBackgroundColor];
    [self setupGradientBackgroundColor:basedView color:color];

}

-(void) setupCommercialListingGradientBackgroundColor: (UIView*) basedView{
    UIColor* color = [PGColor commercialListingCellBackgroundColor  ];
    [self setupGradientBackgroundColor:basedView color:color];
    
}

-(void) setupDefaultListingGradientBackgroundColor: (UIView*) basedView{
//    [self setupGradientBackgroundColor:basedView color:[UIColor whiteColor]];
    [self setupDefaultCellBackgroundColor:basedView];
    //[basedView setBackgroundColor:[UIColor whiteColor]];
}


@end
