/**
 * Copyright (c) 2018-present, Daniel Rosa.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RCTBackgroundExecutionIOS.h"

#import <UIKit/UIKit.h>
#import <React/RCTLog.h>


@implementation RCTBackgroundExecutionIOS

UIBackgroundTaskIdentifier taskId;
void (^onExpiration)(void);


#pragma mark Lifecycle

- (id)init
{
  self = [super init];
  
  if (self != nil) {
    taskId = UIBackgroundTaskInvalid;
    onExpiration = nil;
  }
  
  return self;
}

- (void)dealloc
{
  if (taskId == UIBackgroundTaskInvalid) return;
  
  [self endBackgroundTask];
}


#pragma mark Private API

- (void) beginBackgroundTask
{
  if (taskId == UIBackgroundTaskInvalid) {
    taskId = [UIApplication.sharedApplication beginBackgroundTaskWithExpirationHandler:^{
      if (onExpiration != nil) onExpiration();
      [self endBackgroundTask];
    }];
  } else {
    RCTLogWarn(@"Background task already running.");
  }
}

- (void) endBackgroundTask
{
  if (taskId != UIBackgroundTaskInvalid) {
    [UIApplication.sharedApplication endBackgroundTask: taskId];
    taskId = UIBackgroundTaskInvalid;
    onExpiration = nil;
  } else {
    RCTLogWarn(@"No background task running.");
  }
}


#pragma mark API

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

RCT_EXPORT_METHOD(backgroundTimeRemaining:(RCTPromiseResolveBlock) resolve
                             withRejecter:(RCTPromiseRejectBlock) reject)
{
  resolve(@(UIApplication.sharedApplication.backgroundTimeRemaining));
}

RCT_EXPORT_METHOD(beginBackgroundTask:(RCTResponseSenderBlock) expirationHandler)
{
  self.onExpiration = ^{
    expirationHandler(@[]);
  };

  [self beginBackgroundTask];
}

RCT_EXPORT_METHOD(endBackgroundTask)
{
  [self endBackgroundTask];
}

@end
