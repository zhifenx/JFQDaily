//
//  JFWindow.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFWindow.h"

@interface JFWindow ()

@property (nonatomic, strong) UIButton *suspensionButton;

@end

@implementation JFWindow

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

- (void)setJFSuspensionButtonStyle:(NSInteger)JFSuspensionButtonStyle {
    _JFSuspensionButtonStyle = JFSuspensionButtonStyle;
}

- (void)addButton:(CGRect)frame {
    UIViewController *rootVC = [[UIViewController alloc] init];
    rootVC.view.frame = frame;
    self.rootViewController = rootVC;
    UIButton *suspensionButton = [[UIButton alloc] init];
    [suspensionButton addTarget:self action:@selector(clickSuspensionButton:) forControlEvents:UIControlEventTouchUpInside];
    [rootVC.view addSubview:suspensionButton];
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
    }else {
        imageName = @"navigation_back_round_normal";
    }
    [_suspensionButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)clickSuspensionButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.15 animations:^{
        [self suspensionButtonAnimationWithOffsetY:100];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            [self suspensionButtonAnimationWithOffsetY:-105];
            if (sender.selected) {
                [sender setImage:[UIImage imageNamed:@"c_close button_54x54_"] forState:UIControlStateNormal];
                
                //重新设置设置悬浮按钮的tag
                self.suspensionButton.tag = JFSuspensionButtonStyleCloseType;
            }else {
                [sender setImage:[UIImage imageNamed:@"c_Qdaily button_54x54_"] forState:UIControlStateNormal];
            }
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.05 animations:^{
                [self suspensionButtonAnimationWithOffsetY:5];
            }];
        }];
    }];
    
    //弹出菜单界面
    if (_suspensionButton.tag == JFSuspensionButtonStyleQType) {
        if (self.popupMenuBlock) {
            self.popupMenuBlock();
        }
    }
    
    //关闭菜单界面
    if (_suspensionButton.tag == JFSuspensionButtonStyleCloseType) {
        if (self.closeMenuBlock) {
            self.closeMenuBlock();
        }
    }
    
    //返回到homeNewsViewController
    if (_suspensionButton.tag == JFSuspensionButtonStyleBackType) {
        if (self.backBlock) {
            self.backBlock();
        }
    }
}

- (void)popupMenuBlock:(JFWindowBlock)block {
    self.popupMenuBlock = block;
}

- (void)closeMenuBlock:(JFWindowBlock)block {
    self.closeMenuBlock = block;
}

- (void)backBlock:(JFWindowBlock)block {
    self.backBlock = block;
}

/// 悬浮按钮动画
- (void)suspensionButtonAnimationWithOffsetY:(CGFloat)offsetY {
    CGRect tempFrame = self.layer.frame;
    tempFrame.origin.y += offsetY;
    self.layer.frame = tempFrame;
}

@end
