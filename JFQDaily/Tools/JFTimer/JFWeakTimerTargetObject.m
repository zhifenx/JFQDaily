//
//  JFWeakTimerTargetObject.m
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//  代码地址：https://github.com/zhifenx/JFQDaily
//  简书地址：http://www.jianshu.com/users/aef0f8eebe6d/latest_articles

#import "JFWeakTimerTargetObject.h"

@interface JFWeakTimerTargetObject ()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation JFWeakTimerTargetObject


+ (NSTimer * _Nonnull)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(_Nonnull SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    //创建当前类对象
    JFWeakTimerTargetObject *object = [[JFWeakTimerTargetObject alloc] init];
    object.target = aTarget;
    object.selector = aSelector;
    return [NSTimer scheduledTimerWithTimeInterval:ti target:object selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
}

- (void)fire:(id)obj {
    [self.target performSelector:self.selector withObject:obj afterDelay:0.0];
}

@end
