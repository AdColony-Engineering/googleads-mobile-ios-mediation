//
//  GADMAdapterInMobiUtils.m
//  Adapter
//  Copyright © 2019 Google. All rights reserved.
//

#import "GADMAdapterInMobiUtils.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <InMobiSDK/InMobiSDK.h>
#include <stdatomic.h>

NSInteger GADMAdapterInMobiAdMobErrorCodeForInMobiCode(NSInteger inMobiErrorCode) {
  NSInteger errorCode;
  switch (inMobiErrorCode) {
    case kIMStatusCodeNoFill:
      errorCode = kGADErrorMediationNoFill;
      break;
    case kIMStatusCodeRequestTimedOut:
      errorCode = kGADErrorTimeout;
      break;
    case kIMStatusCodeServerError:
      errorCode = kGADErrorServerError;
      break;
    case kIMStatusCodeInternalError:
      errorCode = kGADErrorInternalError;
      break;
    default:
      errorCode = kGADErrorInternalError;
      break;
  }
  return errorCode;
}

void GADMAdapterInMobiMutableSetAddObject(NSMutableSet *_Nullable set, NSObject *_Nonnull object) {
  if (object) {
    [set addObject:object];  // Allow pattern.
  }
}

void GADMAdapterInMobiMapTableRemoveObjectForKey(NSMapTable *_Nullable mapTable, id _Nullable key) {
  if (key) {
    [mapTable removeObjectForKey:key];  // Allow pattern.
  }
}

void GADMAdapterInMobiMapTableSetObjectForKey(NSMapTable *_Nullable mapTable,
                                              id<NSCopying> _Nullable key, id _Nullable value) {
  if (value && key) {
    [mapTable setObject:value forKey:key];  // Allow pattern.
  }
}

void GADMAdapterInMobiMutableSetSafeGADRTBSignalCompletionHandler(
    GADRTBSignalCompletionHandler handler, GADRTBSignalCompletionHandler setHandler) {
  __block atomic_flag completionHandlerCalled = ATOMIC_FLAG_INIT;
  __block GADRTBSignalCompletionHandler originalCompletionHandler = [setHandler copy];
  handler = ^void(NSString *_Nullable signals, NSError *_Nullable error) {
    if (atomic_flag_test_and_set(&completionHandlerCalled)) {
      return;
    }

    if (originalCompletionHandler) {
      originalCompletionHandler(signals, error);
    }
    originalCompletionHandler = nil;
  };
}
