//
//  GADMAdapterMyTargetExtras.h
//  MyTargetAdapter
//
//  Created by Andrey Seredkin on 04.10.17.
//  Copyright © 2017 Mail.Ru Group. All rights reserved.
//

#import <GoogleMobileAds/GoogleMobileAds.h>

@interface GADMAdapterMyTargetExtras : NSObject <GADAdNetworkExtras>

/// Indicates whether the adapter is in debug mode.
@property BOOL isDebugMode;

@end
