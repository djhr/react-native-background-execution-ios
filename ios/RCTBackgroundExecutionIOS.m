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

NSString *const BACKGROUND_NOT_AVAILABLE = @"Running in the background is not possible.";
UIBackgroundTaskIdentifier taskId;
RCTResponseSenderBlock onExpiration;
RCTResponseSenderBlock onError;


#pragma mark Lifecycle

- (id)init
{
  self = [super init];

  if (self != nil) {
    taskId = UIBackgroundTaskInvalid;
    onExpiration = nil;
    onError = nil;
  }

  return self;
}

- (void)dealloc
{
  if (taskId == UIBackgroundTaskInvalid) return;

  [self endBgTask];
}


#pragma mark Private API

- (void) beginBgTask
{
  if (taskId == UIBackgroundTaskInvalid) {
    taskId = [UIApplication.sharedApplication beginBackgroundTaskWithExpirationHandler:^{
      if (onExpiration != nil) onExpiration(@[@(UIApplication.sharedApplication.backgroundTimeRemaining)]);
      [self endBgTask];
    }];

    if (taskId == UIBackgroundTaskInvalid) [self beginBgTaskDidFail];
  } else {
    RCTLogWarn(@"Background task already running.");
  }
}

- (void) endBgTask
{
  if (taskId != UIBackgroundTaskInvalid) {
    [UIApplication.sharedApplication endBackgroundTask: taskId];

    taskId = UIBackgroundTaskInvalid;
    onExpiration = nil;
    onError = nil;
  } else {
    RCTLogWarn(@"No background task running.");
  }
}

- (void) beginBgTaskDidFail
{
  RCTLogWarn(BACKGROUND_NOT_AVAILABLE);
  if (onError != nil) onError(@[BACKGROUND_NOT_AVAILABLE]);

  onExpiration = nil;
  onError = nil;
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
  dispatch_async(dispatch_get_main_queue(), ^{
    resolve(@(UIApplication.sharedApplication.backgroundTimeRemaining));
  });
}

RCT_EXPORT_METHOD(beginBackgroundTask:(RCTResponseSenderBlock) callback
                                error:(RCTResponseSenderBlock) error)
{
  onExpiration = callback;
  onError = error;
  [self beginBgTask];
}

RCT_EXPORT_METHOD(endBackgroundTask)
{
  [self endBgTask];
}

@end
