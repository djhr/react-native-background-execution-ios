/**
 * Copyright (c) 2018-present, Daniel Rosa.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RCTBackgroundExecutionIOS.h"

#import <UIKit/UIKit.h>

#import <React/RCTConvert.h>


@implementation RCTConvert (RCTBackgroundExecutionIOS)

+ (UIBackgroundTaskIdentifier)UIBackgroundTaskIdentifier:(id)json
{
  return [RCTConvert uint64_t:json];
}

@end


@implementation RCTBackgroundExecutionIOS

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (NSDictionary *)constantsToExport
{
  return @{
           @"BackgroundTaskInvalid": @(UIBackgroundTaskInvalid)
           };
}

RCT_EXPORT_METHOD(backgroundTimeRemaining:(RCTPromiseResolveBlock) resolve
                             withRejecter:(RCTPromiseRejectBlock) reject)
{
  resolve(@(UIApplication.sharedApplication.backgroundTimeRemaining));
}

RCT_EXPORT_METHOD(beginBackgroundTask:(RCTResponseSenderBlock) expirationHandler
                             withName:(NSString) *taskName
                         withResolver:(RCTPromiseResolveBlock) resolve
                         withRejecter:(RCTPromiseRejectBlock) reject)
{
  UIBackgroundTaskIdentifier identifier = name == nil
    ? [UIApplication.sharedApplication beginBackgroundTaskWithExpirationHandler: expirationHandler]
    : [UIApplication.sharedApplication beginBackgroundTaskWithName: taskName
                                                 expirationHandler: expirationHandler];
  
  resolve(@(identifier));
}

RCT_EXPORT_METHOD(endBackgroundTask:(UIBackgroundTaskIdentifier) identifier)
{
  [UIApplication.sharedApplication endBackgroundTask: identifier];
}

@end
