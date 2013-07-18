//
//  PoonDemoAppDelegate.m
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "PoonDemoAppDelegate.h"
#import "AlphaVanillaApplication.h"

@implementation PoonDemoAppDelegate{
    @private AlphaVanillaApplication* alphaVanillaApplication;
}

- (void)dealloc
{
    [_window release];
    if (alphaVanillaApplication){
        [alphaVanillaApplication release];
        alphaVanillaApplication = nil;
    }
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    alphaVanillaApplication = [[AlphaVanillaApplication alloc]init];
    [alphaVanillaApplication initialiseApplication:launchOptions window:self.window];
    


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[self.window rootViewController] viewDidAppear:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [alphaVanillaApplication handleOpenURL:url];

}


@end
