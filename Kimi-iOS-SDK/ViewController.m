//
//  ViewController.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Endo/EDOExporter.h>

@interface ViewController ()

@property (nonatomic, strong) JSContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [[JSContext alloc] init];
    [[EDOExporter sharedExporter] exportWithContext:self.context];
    [self.context setExceptionHandler:^(JSContext *context, JSValue *exception) {
        NSLog(@"%@", exception);
    }];
    [self.context evaluateScript:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"]
                                                       usedEncoding:nil
                                                              error:NULL]];
    UIView *mainView = [[EDOExporter sharedExporter] nsValueWithJSValue:[self.context objectForKeyedSubscript:@"main"]];
    [self.view addSubview:mainView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
