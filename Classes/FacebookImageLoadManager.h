//
//  FacebookImageLoadManager.h
//  AlphaVanilla2
//
//  Created by Kenneth on 19/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookImageLoadManager : NSObject

-(void) loadUserFacebookImage: (id) imageView facebookId: (NSString*) facebookId;
@end
