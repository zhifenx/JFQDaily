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
    JFSuspensionButtonStyleQType = 1,   //  Qlogo样式 （弹出JFMenuView）
    JFSuspensionButtonStyleCloseType,   //  关闭样式（关闭JFMenuView）
    JFSuspensionButtonStyleBackType,    //  返回样式（返回到JFHomeViewController根View）
    JFSuspensionButtonStyleBackType2    //  返回样式2（返回到JFMenuView）
};

@protocol JFSuspensionViewDelegate <NSObject>

@optional
- (void)popupMenuView;
- (void)closeMenuView;
- (void)back;
- (void)backToMenuView;
@end

@interface JFSuspensionView : UIView

@property (nonatomic, assign) NSInteger JFSuspensionButtonStyle;    // 悬浮按钮样式
@property (nonatomic, weak) id<JFSuspensionViewDelegate> delegate;
@end
