//
//  JFWindow.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFWindow.h"

@implementation JFWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addButton:frame];
    }
    return self;
}

- (void)addButton:(CGRect)frame {
    UIViewController *rootVC = [[UIViewController alloc] init];
    rootVC.view.frame = frame;
    self.rootViewController = rootVC;
    UIButton *suspensionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [suspensionButton setImage:[UIImage imageNamed:@"c_Qdaily button_54x54_"] forState:UIControlStateNormal];
    [suspensionButton addTarget:self action:@selector(clickSuspensionButton:) forControlEvents:UIControlEventTouchUpInside];
    [rootVC.view addSubview:suspensionButton];
}

- (void)clickSuspensionButton:(UIButton *)sender {
    sender.selected = !sender.selected;

    [UIView animateWithDuration:0.15 animations:^{
        CGRect tempFrame = self.layer.frame;
        tempFrame.origin.y += 100;
        self.layer.frame = tempFrame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            
            CGRect tempFrame = self.layer.frame;
            tempFrame.origin.y -= 100;
            self.layer.frame = tempFrame;
            
            if (sender.selected) {
                [sender setImage:[UIImage imageNamed:@"c_close button_54x54_"] forState:UIControlStateNormal];
            }else {
                [sender setImage:[UIImage imageNamed:@"c_Qdaily button_54x54_"] forState:UIControlStateNormal];
            }
        }];
    }];
}

@end
