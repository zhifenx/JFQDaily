//
//  JFNewsClassificationView.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/9.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JFNewsClassificationViewBlock)();

@interface JFNewsClassificationView : UIView

@property (nonatomic, copy) JFNewsClassificationViewBlock backBlock;

- (void)backBlock:(JFNewsClassificationViewBlock)block;

///弹出悬浮按钮
- (void)popupSuspensionView;
///隐藏悬浮按钮
- (void)hideSuspensionView;

@end
