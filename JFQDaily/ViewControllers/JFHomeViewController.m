//
//  JFHomeViewController.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFHomeViewController.h"

@interface JFHomeViewController ()

@end

@implementation JFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    [super loadView];
    
    UIView *demo = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    demo.backgroundColor = [UIColor redColor];
    [self.view addSubview:demo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
