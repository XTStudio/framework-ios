//
//  UINavigationController+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UINavigationController+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UINavigationController (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UINavigationController", @"UIViewController");
    EDO_EXPORT_METHOD_ALIAS(edo_pushViewController:animated:, @"pushViewController");
    EDO_EXPORT_METHOD_ALIAS(edo_popViewControllerAnimated:, @"popViewController");
    EDO_EXPORT_METHOD_ALIAS(edo_popToViewController:animated:, @"popToViewController");
    EDO_EXPORT_METHOD_ALIAS(edo_popToRootViewControllerAnimated:, @"popToRootViewController");
    EDO_EXPORT_METHOD_ALIAS(setViewControllers:animated:, @"setViewControllers");
    EDO_EXPORT_READONLY_PROPERTY(@"navigationBar");
    EDO_EXPORT_METHOD_ALIAS(setNavigationBarHidden:animated:, @"setNavigationBarHidden");
    EDO_EXPORT_INITIALIZER({
        UIViewController *rootViewController = 0 < arguments.count && [arguments[0] isKindOfClass:[UIViewController class]] ? arguments[0] : nil;
        if (rootViewController != nil) {
            return [[UINavigationController alloc] initWithRootViewController:rootViewController];
        }
        else {
            return [[UINavigationController alloc] init];
        }
    });
}

- (void)edo_pushViewController:(UIViewController *)viewController animated:(NSNumber *)animated {
    [self pushViewController:viewController
                    animated:(animated == nil || ![animated isKindOfClass:[NSNumber class]] ? YES : animated.boolValue)];
}

- (UIViewController *)edo_popViewControllerAnimated:(NSNumber *)animated {
    return [self popViewControllerAnimated:(animated == nil || ![animated isKindOfClass:[NSNumber class]] ? YES : animated.boolValue)];
}

- (NSArray<UIViewController *> *)edo_popToViewController:(UIViewController *)viewController animated:(NSNumber *)animated {
    return [self popToViewController:viewController
                            animated:(animated == nil || ![animated isKindOfClass:[NSNumber class]] ? YES : animated.boolValue)];
}

- (NSArray<UIViewController *> *)edo_popToRootViewControllerAnimated:(NSNumber *)animated {
    return [self popToRootViewControllerAnimated:(animated == nil || ![animated isKindOfClass:[NSNumber class]] ? YES : animated.boolValue)];
}

@end
