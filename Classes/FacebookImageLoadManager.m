//
//  FacebookImageLoadManager.m
//  AlphaVanilla2
//
//  Created by Kenneth on 19/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "FacebookImageLoadManager.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

@implementation FacebookImageLoadManager{

    @private ASINetworkQueue *mediaNetworkQueue;
}


-(id) init{
    self = [super init];

    mediaNetworkQueue = [[ASINetworkQueue alloc] init];
    [mediaNetworkQueue setRequestDidFinishSelector:@selector(requestFinished:)];
    [mediaNetworkQueue setRequestDidFailSelector:@selector(requestFailed:)];
    [mediaNetworkQueue setShowAccurateProgress:YES];
    [mediaNetworkQueue setDelegate:self];
    
    [mediaNetworkQueue go];
    
    return self;
}
-(ASIFormDataRequest*) generateFacebookImageConnecionRequest: (NSString*) facebookId{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square", facebookId]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    return request;
}

-(void) loadUserFacebookImage: (id) imageView facebookId: (NSString*) facebookId{
    ASIFormDataRequest* _request = [self generateFacebookImageConnecionRequest:facebookId];
    _request.delegate = self;
    
    [_request setTimeOutSeconds:60*2];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [_request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
    NSMutableDictionary* imageViewDictionary = [NSMutableDictionary dictionary];
    [imageViewDictionary setObject:imageView forKey:@"imageView"];
    [_request setUserInfo:imageViewDictionary];
    
    
    [mediaNetworkQueue addOperation:_request];
}


- (void)requestFinished:(ASIHTTPRequest *)_request{

    
    if ([_request responseStatusCode] == 200){
        NSDictionary* imageDictionary = _request.userInfo;
        UIImageView* imageView = [imageDictionary objectForKey:@"imageView"];
        NSData* imageData = [_request responseData];
        [imageView setImage:[UIImage imageWithData:imageData]];

        
    }
    

    
    
}

- (void)requestFailed:(ASIHTTPRequest *)_request{
    NSLog(@"facebook request failed");
/*
    if (listingCoverImageRetrieveActionDelegate!=nil){
        [listingCoverImageRetrieveActionDelegate postActionForListingCoverImageRetrieveFailure:nil];
        return;
    }
 */
}


@end
