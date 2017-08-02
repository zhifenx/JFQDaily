//
//  JFMenuView.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/8.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^JFMenuViewBlock)();

@protocol JFMenuViewDelegate <NSObject>

- (void)clickTheSettingButtonEvent;
- (void)popupNewsClassificationView;
- (void)hideNewsClassificationView;
@end

@interface JFMenuView : UIView

@property (nonatomic, weak) id<JFMenuViewDelegate> delegate;

- (void)popupMenuViewAnimation;                 // 弹出菜单界面
- (void)hideMenuViewAnimation;                  // 隐藏菜单界面
- (void)hideJFNewsClassificationViewAnimation;  // 隐藏新闻分类菜单
@end
