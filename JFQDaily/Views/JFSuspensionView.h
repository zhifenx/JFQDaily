//
//  JFSuspensionView.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 悬浮按钮种类（tag）枚举
typedef NS_ENUM(NSInteger, JFSuspensionButtonStyle) {
    JFSuspensionButtonStyleQType = 1,   //  Qlogo样式
    JFSuspensionButtonStyleCloseType,   //  关闭样式
    JFSuspensionButtonStyleBackType,    //  返回样式
};

typedef void(^JFSuspensionViewBlock)();

@interface JFSuspensionView : UIView

/** 悬浮按钮，设置按钮样式（tag）*/
@property (nonatomic, assign) NSInteger JFSuspensionButtonStyle;

/** 弹出菜单界面*/
@property (nonatomic, copy) JFSuspensionViewBlock popupMenuBlock;

/** 关闭菜单界面*/
@property (nonatomic, copy) JFSuspensionViewBlock closeMenuBlock;

/** 返回到homeNewsViewController*/
@property (nonatomic, copy) JFSuspensionViewBlock backBlock;

- (void)popupMenuBlock:(JFSuspensionViewBlock)block;

- (void)closeMenuBlock:(JFSuspensionViewBlock)block;

- (void)backBlock:(JFSuspensionViewBlock)block;

@end
