//
// Created by Jamie Lynch on 30/11/2017.
// Copyright (c) 2017 Bugsnag. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BugsnagConfiguration;
@class BugsnagNotifier;
@class BugsnagSession;

NS_ASSUME_NONNULL_BEGIN

@interface BugsnagSessionTrackingApiClient : NSObject

- (instancetype)initWithConfig:(BugsnagConfiguration *)configuration notifier:(BugsnagNotifier *)notifier;

- (void)deliverSession:(BugsnagSession *)session;

@property (copy, nonatomic) NSString *codeBundleId;

@property (nonatomic) BugsnagNotifier *notifier;

@end

NS_ASSUME_NONNULL_END
