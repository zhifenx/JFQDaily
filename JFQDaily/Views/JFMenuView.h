//
//  JFMenuView.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/8.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JFMenuViewBlock)();

@interface JFMenuView : UIView

/** 弹出新闻分类界面block*/
@property (nonatomic, copy) JFMenuViewBlock popupNewsClassificationViewBlock;

/** 隐藏新闻分类界面block*/
@property (nonatomic, copy) JFMenuViewBlock hideNewsClassificationViewBlock;

/// 弹出菜单界面
- (void)popupMenuViewAnimation;
/// 隐藏菜单界面
- (void)hideMenuViewAnimation;
///隐藏新闻分类菜单
- (void)hideJFNewsClassificationViewAnimation;

- (void)popupNewsClassificationViewBlock:(JFMenuViewBlock)block;

- (void)hideNewsClassificationViewBlock:(JFMenuViewBlock)block;

@end
