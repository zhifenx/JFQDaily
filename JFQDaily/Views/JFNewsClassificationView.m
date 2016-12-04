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
#import "MBProgressHUD+JFProgressHUD.h"
#import <pop/POP.h>

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
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                if (strongSelf.backBlock) {
                    strongSelf.backBlock();
                }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MBProgressHUD promptHudWithShowHUDAddedTo:self.superview message:@"待完善，您的支持是我最大的动力！"];
}

/** pop动画
 *  POPPropertyAnimation    动画属性
 *  view                    动画对象
 *  offset                  偏移量
 *  speed                   动画速度
 */
- (void)popAnimationWithView:(UIView *)view Offset:(CGFloat)offset speed:(CGFloat)speed {
    POPSpringAnimation *popSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    popSpring.toValue = @(view.center.x + offset);
    popSpring.beginTime = CACurrentMediaTime() + 0.2;
    popSpring.springBounciness = 8.0f;
    popSpring.springSpeed = speed;
    [view pop_addAnimation:popSpring forKey:@"positionX"];
}

///弹出悬浮按钮
- (void)popupSuspensionView {
    [self popAnimationWithView:self.jfSuspensionView Offset:-JFSCREEN_WIDTH + 10 speed:20];
}

///隐藏悬浮按钮
- (void)hideSuspensionView {
    [UIView animateWithDuration:0.15
                     animations:^{
                         [self suspensionViewOffsetX:JFSCREEN_WIDTH];
                     }];
}

///改变悬浮按钮的X值
- (void)suspensionViewOffsetX:(CGFloat)offsetX {
    CGRect tempFrame = self.jfSuspensionView.frame;
    tempFrame.origin.x = offsetX;
    self.jfSuspensionView.frame = tempFrame;
}

@end
