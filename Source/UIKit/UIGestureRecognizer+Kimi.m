//
//  UIGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIGestureRecognizer+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Endo/NSObject+EDOObjectRef.h>

@implementation UIGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIGestureRecognizer", nil);
    EDO_EXPORT_PROPERTY(@"state");
    EDO_EXPORT_PROPERTY(@"enabled");
    EDO_EXPORT_PROPERTY(@"view");
    EDO_EXPORT_PROPERTY(@"requiresExclusiveTouchType");
    EDO_EXPORT_METHOD(requireGestureRecognizerToFail:);
    EDO_EXPORT_METHOD(locationInView:);
}

- (void)edo_handleTouch:(UIGestureRecognizer *)sender {}

- (void)setEdo_objectRef:(NSString *)edo_objectRef {
    [super setEdo_objectRef:edo_objectRef];
    [self addTarget:self action:@selector(edo_handleTouch:)];
}

@end
