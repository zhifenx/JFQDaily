//
//  JFWindow.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 悬浮按钮种类枚举
typedef NS_ENUM(NSInteger, JFSuspensionButtonStyle) {
    JFSuspensionButtonStyleQType = 1,   //  Qlogo样式
    JFSuspensionButtonStyleCloseType,   //  关闭样式
    JFSuspensionButtonStyleBackType,    //  返回样式
};

typedef void(^JFWindowBlock)();

@interface JFWindow : UIWindow

/** 悬浮按钮tag，设置按钮样式*/
@property (nonatomic, assign) NSInteger JFSuspensionButtonStyle;

/** 弹出菜单界面*/
@property (nonatomic, copy) JFWindowBlock popupMenuBlock;

/** 关闭菜单界面*/
@property (nonatomic, copy) JFWindowBlock closeMenuBlock;

/** 返回到homeNewsViewController*/
@property (nonatomic, copy) JFWindowBlock backBlock;

- (void)popupOrCloseMenuBlock:(JFWindowBlock)block;

- (void)closeMenuBlock:(JFWindowBlock)block;

- (void)backBlock:(JFWindowBlock)block;

@end
