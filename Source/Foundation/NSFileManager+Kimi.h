//
//  NSFileManager+Kimi.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Kimi)

- (NSArray<NSString *> *)edo_subpathsAtPath:(NSString *)atPath deepSearch:(BOOL)deepSearch;
- (NSData *)edo_readFile:(NSString *)atPath;

@end
