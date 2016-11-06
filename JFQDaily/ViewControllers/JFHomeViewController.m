//
//  JFHomeViewController.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFHomeViewController.h"

#import "JFConfigFile.h"
#import <Masonry.h>
#import "JFWindow.h"

@interface JFHomeViewController ()

@property (nonatomic, strong) JFWindow *jfWindow;

@end

@implementation JFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    [super loadView];
    
    UIView *demo = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    demo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:demo];
    [self addJFWindow];
}

/// 添加悬浮按钮window
- (void)addJFWindow {
    JFWindow *jfWindow = [[JFWindow alloc] initWithFrame:CGRectMake(20, JFSCREENH_HEIGHT - 80, 54, 54)];
    jfWindow.windowLevel = UIWindowLevelAlert * 2;
    [jfWindow makeKeyAndVisible];
    self.jfWindow = jfWindow;
}

/// 销毁JFWindow
- (void)destoryJFWindow {
    self.jfWindow.hidden = YES;
    self.jfWindow = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
