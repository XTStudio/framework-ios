//
//  UICollectionViewLayout+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/28.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UICollectionViewLayout+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UICollectionViewLayout (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UICollectionViewLayout", nil);
    EDO_EXPORT_PROPERTY(@"collectionView");
    EDO_EXPORT_METHOD(invalidateLayout);
}

@end