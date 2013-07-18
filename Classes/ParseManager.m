//
//  ParseManager.m
//  AlphaVanilla2
//
//  Created by Kenneth on 14/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "ParseManager.h"
#import <Parse/Parse.h>

@implementation ParseManager{
    @private NSObject<ParseFacebookPostLoginDelegate>* parseFacebookPostLoginDelegate;
    @private NSObject<ParseQueryBetRequestDelegate>* parseQueryBetRequestDelegate;
    @private NSObject<ParseCreateBetRequestDelegate>* parseCreateBetRequestDelegate;
}

-(void) dealloc{
    if (parseFacebookPostLoginDelegate){
        [parseFacebookPostLoginDelegate release];
        parseFacebookPostLoginDelegate = nil;
    }
    if (parseQueryBetRequestDelegate){
        [parseQueryBetRequestDelegate release];
        parseQueryBetRequestDelegate = nil;
    }
    if (parseCreateBetRequestDelegate){
        [parseCreateBetRequestDelegate release];
        parseCreateBetRequestDelegate = nil;
    }
    [super dealloc];
}

-(void) setParseFacebookPostLoginDelegate: (NSObject<ParseFacebookPostLoginDelegate>*) _parseFacebookPostLoginDelegate{
    if (parseFacebookPostLoginDelegate){
        [parseFacebookPostLoginDelegate release];
        parseFacebookPostLoginDelegate = nil;
    }
    parseFacebookPostLoginDelegate = [_parseFacebookPostLoginDelegate retain];
}

-(void) setParseQueryBetRequestDelegate: (NSObject<ParseQueryBetRequestDelegate>*) _parseQueryBetRequestDelegate{
    if (parseQueryBetRequestDelegate){
        [parseQueryBetRequestDelegate release];
        parseQueryBetRequestDelegate = nil;
    }
    parseQueryBetRequestDelegate = [_parseQueryBetRequestDelegate retain];
}

-(void) setParseCreateBetRequestDelegate: (NSObject<ParseCreateBetRequestDelegate>*) _parseCreateBetRequestDelegate{
    if (parseCreateBetRequestDelegate){
        [parseCreateBetRequestDelegate release];
        parseCreateBetRequestDelegate = nil;
    }
    parseCreateBetRequestDelegate = [_parseCreateBetRequestDelegate retain];
}

-(void) initialiseParseInApplication:(NSDictionary *)launchOptions{
    
    
    [Parse setApplicationId:@"CaZUudXqs4V4i5iSemylA6xrF5cIpsQPyrqVRPeY"
                  clientKey:@"Lw9RlGdnQPhQViYdcTVK1jACcd4lgsJd5aQa59r9"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFFacebookUtils initializeFacebook];

}

-(BOOL) handleOpenURL:(NSURL *)url{
    return [PFFacebookUtils handleOpenURL:url];
}


-(BOOL) isCurrentFacebookUserLogin{
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {

        [self downloadFacebookUser];
        NSLog(@"user is already login");
        if (parseFacebookPostLoginDelegate){
            [parseFacebookPostLoginDelegate showFacebookProfile:[self getCurrentFacebookUserProfile]];
        }
        return YES;
    }
        NSLog(@"user is not yet login");
    return NO;
}

-(void) loginFacebook{
    
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                if (parseFacebookPostLoginDelegate){
                    [parseFacebookPostLoginDelegate didFailedFacebookLogin:@"Facebook Login Failed"];
                }
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                if (parseFacebookPostLoginDelegate){
                    [parseFacebookPostLoginDelegate didFailedFacebookLogin:@"Facebook Login Failed"];
                }
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            if (parseFacebookPostLoginDelegate){
                [self downloadFacebookUser];
                [parseFacebookPostLoginDelegate didSuccessfulFacebookLogin:@"Facebook Login Success"];
            }
            NSLog(@"User with facebook signed up and logged in!");
        } else {
            if (parseFacebookPostLoginDelegate){
                [self downloadFacebookUser];
                [parseFacebookPostLoginDelegate didSuccessfulFacebookLogin:@"Facebook Login Success"];
            }

            NSLog(@"User with facebook logged in!");
        }
    }];
}


-(void) downloadFacebookUser{
    // Send request to Facebook
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            if (userData[@"name"]) {
                userProfile[@"name"] = userData[@"name"];
            }
            
            if (userData[@"location"][@"name"]) {
                userProfile[@"location"] = userData[@"location"][@"name"];
            }
            
            if (userData[@"gender"]) {
                userProfile[@"gender"] = userData[@"gender"];
            }
            
            if (userData[@"birthday"]) {
                userProfile[@"birthday"] = userData[@"birthday"];
            }
            
            if (userData[@"relationship_status"]) {
                userProfile[@"relationship"] = userData[@"relationship_status"];
            }
            
            if ([pictureURL absoluteString]) {
                userProfile[@"pictureURL"] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            NSLog(@"Profile Is Ready: %@", userProfile);
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            if (parseFacebookPostLoginDelegate){
                [parseFacebookPostLoginDelegate didFailedFacebookLogin:@"Facebook Session Invalid"];
            }
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
}

-(void) logoutFacebook{
    [PFUser logOut];
    if (parseFacebookPostLoginDelegate){
        [parseFacebookPostLoginDelegate didSuccessfulFacebookLogout];
    }
}



-(void) testParse{
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
}

-(NSDictionary*) getCurrentFacebookUserProfile{
    return (NSDictionary*) [[PFUser currentUser] objectForKey:@"profile"];
}

-(PFUser*) getCurrentUser{
    return [PFUser currentUser];
}

-(void) createNewBetByOffer: (BetObject*) _betObject{
    
    UIImage* betImage = _betObject.offerBetImage;
    NSData *imageData = UIImageJPEGRepresentation(betImage, 0.05f);
    PFFile *file = [PFFile fileWithName:@"uploadedImage" data:imageData];
    
    
    PFObject *betDAO = [PFObject objectWithClassName:@"Bet"];
    [betDAO setObject:file forKey:@"offerImage"];
    [betDAO setObject:_betObject.prediction forKey:@"prediction"];
    [betDAO setObject:_betObject.offerDescription forKey:@"offerDescription"];
    [betDAO setObject:_betObject.offerUserObject forKey:@"offerId"];
    [betDAO setObject:_betObject.offerFacebookId forKey:@"offerFacebookId"];
    [betDAO setObject:_betObject.offerName forKey:@"offerName"];
    
    if (parseCreateBetRequestDelegate!=nil){
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded){
                [betDAO saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded){
                        [parseCreateBetRequestDelegate didSuccessfullyCreatedBet];
                    }else{
                        [parseCreateBetRequestDelegate didFailToCreateBet:[error description]];
                    }
                }];
            }else{
                [parseCreateBetRequestDelegate didFailToCreateBet:[error description]];
            }
        }];
    }
   // [file saveInBackground];

}

-(void) queryAllBets{
    
    if (parseQueryBetRequestDelegate!=nil){
        PFQuery *query = [PFQuery queryWithClassName:@"Bet"];
        [query orderByDescending:@"updatedAt"];
    
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            NSMutableArray* resultsArray = [NSMutableArray array];
            for(PFObject* betDAO in objects){
                BetObject* betObject = [[BetObject alloc]init];
                
                betObject.prediction = [betDAO objectForKey:@"prediction"];
                betObject.offerDescription = [betDAO objectForKey:@"offerDescription"];
                betObject.offerUserObject = [betDAO objectForKey:@"offerId"];
                betObject.offerFacebookId = [betDAO objectForKey:@"offerFacebookId"];
                betObject.offerName = [betDAO objectForKey:@"offerName"];
                
                PFFile *offerBetImageFile = [betDAO objectForKey:@"offerImage"];
                UIImage* offerBetImage = [UIImage imageWithData:[offerBetImageFile getData]];
                
                betObject.offerBetImage = offerBetImage;
                [resultsArray addObject:betObject];
            }
            
            
            [parseQueryBetRequestDelegate queryFinishedLoading:resultsArray];
        }];
    }
}


@end
