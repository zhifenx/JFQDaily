//
//  JFNewsClassificationView.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/9.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JFNewsClassificationViewDelegate <NSObject>

- (void)back;
@end

@interface JFNewsClassificationView : UIView

@property (nonatomic, weak) id<JFNewsClassificationViewDelegate> delegate;

- (void)popupSuspensionView;    // 弹出悬浮按钮
- (void)hideSuspensionView;     // 隐藏悬浮按钮
@end
