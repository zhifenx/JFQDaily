//
//  JFMenuView.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/8.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFMenuView.h"

#import "JFNewsClassificationView.h"
#import "JFConfigFile.h"
#import "Masonry.h"
#import "MBProgressHUD+JFProgressHUD.h"
#import <pop/POP.h>

#define KHeaderViewH 200

static NSString *ID = @"menuCell";

@interface JFMenuView ()<UITableViewDelegate, UITableViewDataSource>

/** 模糊效果层*/
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

/** 上半部分设置按钮的父view*/
@property (nonatomic, strong) UIView *headerView;
/** 下半部分菜单按钮的父view*/
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITableView *menuTableView;
/** 新闻分类菜单界面*/
@property (nonatomic, strong) JFNewsClassificationView *jfNewsClassificationView;

/** 菜单cell按钮图片数组*/
@property (nonatomic, strong) NSArray *imageArray;
/** 菜单cell按钮标题数组*/
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation JFMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.blurEffectView];
        [self addSubview:self.headerView];
        [self addSubview:self.footerView];
        [self.footerView addSubview:self.menuTableView];
        [self addSubview:self.jfNewsClassificationView];
        [self addHeaderViewButtonAndLabel];
    }
    return self;
}

- (UIVisualEffectView *)blurEffectView {
    if (!_blurEffectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _blurEffectView.frame = self.frame;
    }
    return _blurEffectView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -KHeaderViewH, JFSCREEN_WIDTH, KHeaderViewH)];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, JFSCREENH_HEIGHT, JFSCREEN_WIDTH, JFSCREENH_HEIGHT - KHeaderViewH)];
        _footerView.backgroundColor = [UIColor clearColor];
    }
    return _footerView;
}

/** pop动画
 *  POPPropertyAnimation    动画属性
 *  view                    动画对象
 *  offset                  偏移量
 *  speed                   动画速度
 */
- (void)popAnimationWithView:(UIView *)view Offset:(CGFloat)offset speed:(CGFloat)speed {
    POPSpringAnimation *popSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    popSpring.toValue = @(view.center.y + offset);
    popSpring.beginTime = CACurrentMediaTime();
    popSpring.springBounciness = 11.0f;
    popSpring.springSpeed = speed;
    [view pop_addAnimation:popSpring forKey:@"positionY"];
}

/// 弹出headerView和footerView
- (void)popupMenuViewAnimation {
    //显示JFMenuView
    [self setHidden:NO];
    
    //加判断，防止连击悬浮按钮时出现界面逻辑交互混乱的情况（下同）
    if (-KHeaderViewH == self.headerView.layer.frame.origin.y) {
        [self popAnimationWithView:self.headerView Offset:KHeaderViewH speed:15];
    }
    if (JFSCREENH_HEIGHT == self.footerView.layer.frame.origin.y) {
        [self popAnimationWithView:self.footerView Offset:-(JFSCREENH_HEIGHT - KHeaderViewH) speed:15];
    }
}

/// 动画隐藏headerView和footerView
- (void)hideMenuViewAnimation {
    [UIView animateWithDuration:0.1
                     animations:^{
                         [self headerViewOffsetY:-KHeaderViewH];
                         [self footerViewOffsetY:JFSCREENH_HEIGHT];
                     } completion:^(BOOL finished) {
                         //隐藏JFMenuView
                         [self setHidden:YES];
                     }];
}

/// 改变headerView的Y值
- (void)headerViewOffsetY:(CGFloat)offsetY {
    CGRect headerTempFrame = self.headerView.frame;
    headerTempFrame.origin.y = offsetY;
    self.headerView.frame = headerTempFrame;
}

/// 改变footerView的Y值
- (void)footerViewOffsetY:(CGFloat)offsetY {
    CGRect footerTempFrame = self.footerView.frame;
    footerTempFrame.origin.y = offsetY;
    self.footerView.frame = footerTempFrame;
}

- (JFNewsClassificationView *)jfNewsClassificationView {
    if (!_jfNewsClassificationView) {
        _jfNewsClassificationView = [[JFNewsClassificationView alloc] initWithFrame:CGRectMake(JFSCREEN_WIDTH, KHeaderViewH, JFSCREEN_WIDTH, JFSCREENH_HEIGHT - KHeaderViewH)];
        
        //隐藏自己，返回到menuView
        __weak typeof(self) weakSelf = self;
        [_jfNewsClassificationView backBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                if (strongSelf.hideNewsClassificationViewBlock) {
                    strongSelf.hideNewsClassificationViewBlock();
                }
            }
        }];
    }
    return _jfNewsClassificationView;
}

///弹出新闻分类菜单
- (void)popupJFNewsClassificationViewAnimation {
    [UIView animateWithDuration:0.15
                     animations:^{
                         [self menuTableViewOffsetX:-JFSCREEN_WIDTH];
                     } completion:^(BOOL finished) {
                        POPSpringAnimation *popSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                        popSpring.toValue = @(self.jfNewsClassificationView.center.x - JFSCREEN_WIDTH);
                        popSpring.beginTime = CACurrentMediaTime();
                        popSpring.springBounciness = 8.0f;
                        popSpring.springSpeed = 15.0f;
                        [self.jfNewsClassificationView pop_addAnimation:popSpring forKey:@"positionX"];
                     }];
}

///隐藏新闻分类菜单
- (void)hideJFNewsClassificationViewAnimation {
    
    [self.jfNewsClassificationView hideSuspensionView];
    [UIView animateWithDuration:0.15
                     animations:^{
                         [UIView animateWithDuration:0.15
                                          animations:^{
                                              [self jfNewsClassificationViewOffsetX:JFSCREEN_WIDTH];
                                          }];
                     } completion:^(BOOL finished) {
                         //弹簧动画效果
                         [UIView animateWithDuration:0.5 //动画时间
                                               delay:0   //动画延迟
                              usingSpringWithDamping:0.5 //越接近零，震荡越大；1时为平滑的减速动画
                               initialSpringVelocity:0.15 //弹簧的初始速度 （距离/该值）pt/s
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              [self menuTableViewOffsetX:0];
                                          }
                                          completion:nil];
                     }];
    
}

/// 改变menuTableView的X值
- (void)menuTableViewOffsetX:(CGFloat)offsetX {
    CGRect footerTempFrame = self.menuTableView.frame;
    footerTempFrame.origin.x = offsetX;
    self.menuTableView.frame = footerTempFrame;
}

/// 改变JFNewsClassificationView的X值
- (void)jfNewsClassificationViewOffsetX:(CGFloat)offsetX {
    CGRect tempFrame = self.jfNewsClassificationView.frame;
    tempFrame.origin.x = offsetX;
    self.jfNewsClassificationView.frame = tempFrame;
}

/// headerViewButon（设置、开源、离线、分享）
- (void)addHeaderViewButtonAndLabel {
    UILabel *sign = [[UILabel alloc] init];
    sign.text = @"zhifenx仿好奇心日报";
    sign.textAlignment = NSTextAlignmentCenter;
    sign.textColor = [UIColor whiteColor];
    [self.headerView addSubview:sign];
    
    [sign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.height.offset(21);
        make.top.equalTo(self.headerView.mas_top).offset(KHeaderViewH * 0.2);
        make.centerX.equalTo(self.headerView.mas_centerX);
    }];
    
    NSArray *iconNameArray = @[@"setting_icon",
                               @"github_icon",
                               @"off_line_icon",
                               @"share_icon"];
    for (int i = 0; i < iconNameArray.count; i ++) {
        UIButton *headerViewButton = [[UIButton alloc] init];
        [headerViewButton addTarget:self action:@selector(headerViewButtonEvents:) forControlEvents:UIControlEventTouchDown];
        headerViewButton.tag = i;
        NSString *imageName = iconNameArray[i];
        [headerViewButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.headerView addSubview:headerViewButton];
        //添加Masonry自动布局
        [headerViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(38);
            make.height.offset(57);
            make.top.equalTo(self.headerView.mas_top).offset(KHeaderViewH * 0.4);
            make.right.equalTo(self.headerView.mas_left).offset(((JFSCREEN_WIDTH - 4 * 38) / 5 + 38) * (i + 1));
        }];
    }
}

- (void)headerViewButtonEvents:(UIButton *)sender {
//    [MBProgressHUD promptHudWithShowHUDAddedTo:self message:@"待完善，您的支持是我最大的动力!"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheSettingButtonEvent)]) {
        [self.delegate clickTheSettingButtonEvent];
    }
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

#pragma mark --- menuTableView

- (UITableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 190, JFSCREENH_HEIGHT - KHeaderViewH - 80) style:UITableViewStylePlain];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
    }
    return _menuTableView;
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
        [self popupJFNewsClassificationViewAnimation];
        [self.jfNewsClassificationView popupSuspensionView];
        if (self.popupNewsClassificationViewBlock) {
            self.popupNewsClassificationViewBlock();
        }
    }else {
        [MBProgressHUD promptHudWithShowHUDAddedTo:self message:@"待完善，您的支持是我最大的动力！"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (JFSCREENH_HEIGHT - KHeaderViewH - 80) / _imageArray.count;
}

- (void)popupNewsClassificationViewBlock:(JFMenuViewBlock)block {
    self.popupNewsClassificationViewBlock = block;
}

- (void)hideNewsClassificationViewBlock:(JFMenuViewBlock)block {
    self.hideNewsClassificationViewBlock = block;
}

@end
