//
//  JFNewsClassificationView.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/9.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFNewsClassificationView.h"

#import "JFConfigFile.h"
#import "JFSuspensionView.h"

static NSString *ID = @"nwesClassificationCell";

@interface JFNewsClassificationView ()<UITableViewDelegate, UITableViewDataSource>

/** 新闻分类菜单*/
@property (nonatomic, strong) UITableView *newsClassificationTableView;
@property (nonatomic, strong) JFSuspensionView *jfSuspensionView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation JFNewsClassificationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.jfSuspensionView];
        [self addSubview:self.newsClassificationTableView];
    }
    return self;
}

- (JFSuspensionView *)jfSuspensionView {
    if (!_jfSuspensionView) {
        _jfSuspensionView = [[JFSuspensionView alloc] initWithFrame:CGRectMake(JFSCREEN_WIDTH, self.frame.size.height - 70, 54, 54)];
        _jfSuspensionView.JFSuspensionButtonStyle = JFSuspensionButtonStyleBackType2;
        
        ///返回到nenuViewBlock回调
        __weak typeof(self) weakSelf = self;
        [_jfSuspensionView backToMenuViewBlock:^{
            if (weakSelf.backBlock) {
                weakSelf.backBlock();
            }
        }];
    }
    return _jfSuspensionView;
}

- (void)backBlock:(JFNewsClassificationViewBlock)block {
    self.backBlock = block;
}

- (UITableView *)newsClassificationTableView {
    if (!_newsClassificationTableView) {
        _newsClassificationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JFSCREEN_WIDTH, self.frame.size.height - 80) style:UITableViewStylePlain];
        [_newsClassificationTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        _newsClassificationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _newsClassificationTableView.backgroundColor = [UIColor clearColor];
        _newsClassificationTableView.delegate = self;
        _newsClassificationTableView.dataSource = self;
    }
    return _newsClassificationTableView;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"menu_column",
                        @"menu_about",
                        @"menu_category",
                        @"menu_noti",
                        @"menu_lab",
                        @"menu_user",
                        @"menu_home"];
    }
    return _imageArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"皇家马德里",
                        @"阿森纳",
                        @"曼联",
                        @"巴萨罗那",
                        @"多特蒙德",
                        @"马德里竞技",
                        @"曼城"];
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
    }
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (JFSCREENH_HEIGHT - 280) / _imageArray.count;
}


///弹出悬浮按钮
- (void)popupSuspensionView {
    [UIView animateWithDuration:0.5 animations:^{
        
        [self suspensionViewOffsetX:0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            
            [self suspensionViewOffsetX:15];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                
                [self suspensionViewOffsetX:10];
            }];
        }];
    }];
}

///隐藏悬浮按钮
- (void)hideSuspensionView {
    [UIView animateWithDuration:0.15 animations:^{
        [self suspensionViewOffsetX:JFSCREEN_WIDTH + 100];
    }];
}

///改变悬浮按钮的X值
- (void)suspensionViewOffsetX:(CGFloat)offsetX {
    CGRect tempFrame = self.jfSuspensionView.frame;
    tempFrame.origin.x = offsetX;
    self.jfSuspensionView.frame = tempFrame;
}

@end
