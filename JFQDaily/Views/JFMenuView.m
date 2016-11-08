//
//  JFMenuView.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/8.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFMenuView.h"

#import "JFConfigFile.h"

#define KHeaderViewH 200

static NSString *ID = @"menuCell";

@interface JFMenuView ()<UITableViewDelegate, UITableViewDataSource>

/** 上半部分设置按钮的父view*/
@property (nonatomic, strong) UIView *headerView;
/** 下半部分菜单按钮的父view*/
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITableView *menuTableView;

/** 菜单cell按钮图片数组*/
@property (nonatomic, strong) NSArray *imageArray;
/** 菜单cell按钮标题数组*/
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation JFMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headerView];
        [self addSubview:self.footerView];
        [self.footerView addSubview:self.menuTableView];
    }
    return self;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JFSCREEN_WIDTH, KHeaderViewH)];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KHeaderViewH, JFSCREEN_WIDTH, JFSCREENH_HEIGHT - KHeaderViewH)];
        _footerView.backgroundColor = [UIColor clearColor];
    }
    return _footerView;
}

- (UITableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 190, JFSCREENH_HEIGHT - KHeaderViewH - 80) style:UITableViewStylePlain];
        [_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
    }
    return _menuTableView;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"menu_about",
                        @"menu_category",
                        @"menu_column",
                        @"menu_lab",
                        @"menu_noti",
                        @"menu_user",
                        @"menu_home"];
    }
    return _imageArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"关于我们",
                        @"新闻分类",
                        @"栏目中心",
                        @"好奇心研究所",
                        @"我的消息",
                        @"个人中心",
                        @"首页"];
    }
    return _titleArray;
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"新闻分类"]) {
        NSLog(@"你点击了新闻分类");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (JFSCREENH_HEIGHT - KHeaderViewH - 80) / _imageArray.count;
}

@end
