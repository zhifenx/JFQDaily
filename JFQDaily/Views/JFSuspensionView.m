//
//  JFSuspensionView.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFSuspensionView.h"

#import <pop/POP.h>

@interface JFSuspensionView ()

@property (nonatomic, strong) UIButton *suspensionButton;

@end

@implementation JFSuspensionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addButton:frame];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self customUI];
}

/// 重写JFSuspensionButtonStyle的set方法
- (void)setJFSuspensionButtonStyle:(NSInteger)JFSuspensionButtonStyle {
    _JFSuspensionButtonStyle = JFSuspensionButtonStyle;
}

- (void)addButton:(CGRect)frame {
    UIButton *suspensionButton = [[UIButton alloc] init];
    [suspensionButton addTarget:self action:@selector(clickSuspensionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:suspensionButton];
    self.suspensionButton = suspensionButton;
}

- (void)customUI {
    self.suspensionButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.suspensionButton.tag = _JFSuspensionButtonStyle;
    NSString *imageName = [[NSString alloc] init];
    if (_JFSuspensionButtonStyle == JFSuspensionButtonStyleQType) {
        imageName = @"c_Qdaily button_54x54_";
    }else if (_JFSuspensionButtonStyle == JFSuspensionButtonStyleCloseType) {
        imageName = @"c_close button_54x54_";
    }else if (_JFSuspensionButtonStyle == JFSuspensionButtonStyleBackType) {
        imageName = @"navigation_back_round_normal";
    }else {
        imageName = @"homeBackButton";
    }
    [_suspensionButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)clickSuspensionButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_suspensionButton.tag == JFSuspensionButtonStyleQType || _suspensionButton.tag == JFSuspensionButtonStyleCloseType) {
        //加判断，防止连击悬浮按钮时出现界面逻辑交互混乱的情况
        if (0 == sender.layer.frame.origin.y) {
        [UIView animateWithDuration:0.05
                         animations:^{
                             [self suspensionButtonAnimationWithOffsetY:80];
                         } completion:^(BOOL finished) {
                             [self popAnimationWithOffset:-80 beginTime:0];
                            //弹出菜单界面
                            if (_suspensionButton.tag == JFSuspensionButtonStyleQType) {
                                [sender setImage:[UIImage imageNamed:@"c_close button_54x54_"] forState:UIControlStateNormal];
                                //重新设置悬浮按钮的tag
                                self.suspensionButton.tag = JFSuspensionButtonStyleCloseType;
                                if (self.popupMenuBlock) {
                                    self.popupMenuBlock();
                                }
                                return;//因为上面已经对点击事件做处理了，且更改了suspensionButton的tag，此处如果return就会继续执行下面的方法，导致逻辑错误。
                            }
                
                            //关闭菜单界面

                             if (_suspensionButton.tag == JFSuspensionButtonStyleCloseType) {
                                [sender setImage:[UIImage imageNamed:@"c_Qdaily button_54x54_"] forState:UIControlStateNormal];
                                    //重新设置悬浮按钮的tag
                                    self.suspensionButton.tag = JFSuspensionButtonStyleQType;
                                    if (self.closeMenuBlock) {
                                        self.closeMenuBlock();
                                    }
                                    return;//作用同上
                                }
                                    }];
                                    
        }
    }
    //返回到homeNewsViewController
    if (_suspensionButton.tag == JFSuspensionButtonStyleBackType) {
        //重新设置悬浮按钮的tag
        self.suspensionButton.tag = JFSuspensionButtonStyleQType;
        if (self.backBlock) {
            self.backBlock();
        }
        return;//作用同上
    }
    
    //返回到JFMenuView
    if (_suspensionButton.tag == JFSuspensionButtonStyleBackType2) {
        if (self.backToMenuViewBlock) {
            self.backToMenuViewBlock();
        }
    }
}

- (void)popupMenuBlock:(JFSuspensionViewBlock)block {
    self.popupMenuBlock = block;
}

- (void)closeMenuBlock:(JFSuspensionViewBlock)block {
    self.closeMenuBlock = block;
}

- (void)backBlock:(JFSuspensionViewBlock)block {
    self.backBlock = block;
}

- (void)backToMenuViewBlock:(JFSuspensionViewBlock)block {
    self.backToMenuViewBlock = block;
}

/** pop动画
 *  POPPropertyAnimation    动画属性
 *  springBounciness:4.0    [0-20] 弹力 越大则震动幅度越大
 *  springSpeed     :12.0   [0-20] 速度 越大则动画结束越快
 *  dynamicsTension :0      拉力  接下来三个都跟物理力学模拟相关 数值调整起来比较麻烦、费时
 *  dynamicsFriction:0      摩擦力
 *  dynamicsMass    :0      质量
 */
- (void)popAnimationWithOffset:(CGFloat)offset beginTime:(CGFloat)beginTime {
    POPSpringAnimation *popSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    popSpring.toValue = @(self.suspensionButton.center.y + offset);
    popSpring.beginTime = CACurrentMediaTime() + beginTime;
    popSpring.springBounciness = 10.0f;
    popSpring.springSpeed = 18;
    [self.suspensionButton pop_addAnimation:popSpring forKey:@"positionY"];
}

/// 改变悬浮按钮Y值
- (void)suspensionButtonAnimationWithOffsetY:(CGFloat)offsetY {
    CGRect tempFrame = self.suspensionButton.layer.frame;
    tempFrame.origin.y += offsetY;
    self.suspensionButton.layer.frame = tempFrame;
}

@end
