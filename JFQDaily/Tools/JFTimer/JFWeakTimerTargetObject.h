//
//  JFWeakTimerTargetObject.h
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFWeakTimerTargetObject : NSObject

+ (NSTimer * _Nonnull)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(_Nonnull SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

@end
