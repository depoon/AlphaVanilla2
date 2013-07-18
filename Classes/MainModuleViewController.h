//
//  MainModuleViewController.h
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseQueryBetRequestDelegate.h"
#import "EGORefreshTableHeaderView.h"

@interface MainModuleViewController : UITableViewController<ParseQueryBetRequestDelegate, EGORefreshTableHeaderDelegate>

@end
