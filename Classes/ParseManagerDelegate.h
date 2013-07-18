//
//  ParseManagerDelegate.h
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParseManagerDelegate <NSObject>

-(BOOL) handleOpenURL:(NSURL *)url;
@end
