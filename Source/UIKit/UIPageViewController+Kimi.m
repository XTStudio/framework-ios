//
//  UIPageViewController+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIPageViewController+Kimi.h"
#import <Endo/EDOExporter.h>
#import <objc/runtime.h>

static int kPageItemsTag;
static int kLoopsTag;

@implementation UIPageViewController (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIPageViewController", @"UIViewController");
    EDO_EXPORT_PROPERTY(@"edo_loops");
    EDO_EXPORT_PROPERTY(@"edo_pageItems");
    EDO_EXPORT_PROPERTY(@"edo_currentPage");
    EDO_EXPORT_METHOD(edo_scrollToNextPage:);
    EDO_EXPORT_METHOD(edo_scrollToPreviousPage:);
    EDO_EXPORT_INITIALIZER({
        UIPageViewController *instance = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                         navigationOrientation:0 < arguments.count && [arguments[0] isKindOfClass:[NSNumber class]] && [arguments[0] boolValue] ? UIPageViewControllerNavigationOrientationVertical :  UIPageViewControllerNavigationOrientationHorizontal
                                                                                       options:nil];
        instance.dataSource = instance;
        instance.delegate = instance;
        return instance;
    })
}

- (BOOL)edo_loops {
    return [objc_getAssociatedObject(self, &kLoopsTag) boolValue];
}

- (void)setEdo_loops:(BOOL)edo_loops {
    objc_setAssociatedObject(self, &kLoopsTag, @(edo_loops), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<UIViewController *> *)edo_pageItems {
    return objc_getAssociatedObject(self, &kPageItemsTag);
}

- (void)setEdo_pageItems:(NSArray<UIViewController *> *)edo_pageItems {
    objc_setAssociatedObject(self, &kPageItemsTag, edo_pageItems, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (edo_pageItems.count > 0) {
        [self setViewControllers:@[[edo_pageItems firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    else {
        [self setViewControllers:@[] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (UIViewController *)edo_currentPage {
    return self.viewControllers.firstObject;
}

- (void)setEdo_currentPage:(UIViewController *)edo_currentPage {
    if (edo_currentPage != nil) {
        [self setViewControllers:@[edo_currentPage] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (void)edo_scrollToNextPage:(NSNumber *)animated {
    BOOL isAnimated = [animated isKindOfClass:[NSNumber class]] ? [animated boolValue] : YES;
    UIViewController *currentViewController = self.edo_currentPage;
    if (currentViewController != nil) {
        UIViewController *nextViewController = [self pageViewController:self viewControllerAfterViewController:self.edo_currentPage];
        if (nextViewController != nil) {
            [self setViewControllers:@[nextViewController] direction:UIPageViewControllerNavigationDirectionForward animated:isAnimated completion:nil];
        }
    }
}

- (void)edo_scrollToPreviousPage:(NSNumber *)animated {
    BOOL isAnimated = [animated isKindOfClass:[NSNumber class]] ? [animated boolValue] : YES;
    UIViewController *currentViewController = self.edo_currentPage;
    if (currentViewController != nil) {
        UIViewController *nextViewController = [self pageViewController:self viewControllerBeforeViewController:self.edo_currentPage];
        if (nextViewController != nil) {
            [self setViewControllers:@[nextViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:isAnimated completion:nil];
        }
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.edo_pageItems != nil) {
        NSUInteger currentIdx = [self.edo_pageItems indexOfObject:viewController];
        if (currentIdx <= 0) {
            if (self.edo_loops && self.edo_pageItems.count > 1) {
                return self.edo_pageItems.lastObject;
            }
            else {
                return nil;
            }
        }
        else {
            return self.edo_pageItems[currentIdx - 1];
        }
    }
    else {
        id result = [self edo_valueWithEventName:@"beforeViewController" arguments:@[viewController]];
        if ([result isKindOfClass:[UIViewController class]]) {
            return result;
        }
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.edo_pageItems != nil) {
        NSUInteger currentIdx = [self.edo_pageItems indexOfObject:viewController];
        if (currentIdx + 1 >= self.edo_pageItems.count) {
            if (self.edo_loops && self.edo_pageItems.count > 1) {
                return self.edo_pageItems.firstObject;
            }
            else {
                return nil;
            }
        }
        else {
            return self.edo_pageItems[currentIdx + 1];
        }
    }
    else {
        id result = [self edo_valueWithEventName:@"afterViewController" arguments:@[viewController]];
        if ([result isKindOfClass:[UIViewController class]]) {
            return result;
        }
    }
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    [self edo_emitWithEventName:@"didFinishAnimating" arguments:@[self, previousViewControllers]];
}

@end