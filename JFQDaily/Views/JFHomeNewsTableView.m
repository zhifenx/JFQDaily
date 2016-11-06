//
//  JFHomeNewsTableView.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/5.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFHomeNewsTableView.h"

#import "JFHomeNewsTableViewCell.h"

static NSString *ID = @"newsCell";

@interface JFHomeNewsTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSMutableArray *contentMutableArray;

@end

@implementation JFHomeNewsTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addRootTableView:frame];
    }
    return self;
}

- (void)addRootTableView:(CGRect)frame {
    UITableView *rootTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [rootTableView registerClass:[JFHomeNewsTableViewCell class] forCellReuseIdentifier:ID];
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    self.rootTableView = rootTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFHomeNewsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JFHomeNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
