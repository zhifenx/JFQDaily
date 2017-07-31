//
//  NSTimer+JFBlocksTimer.m
//  JFQDaily
//
//  Created by zhifenx on 2017/7/31.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "NSTimer+JFBlocksTimer.h"

@implementation NSTimer (JFBlocksTimer)

+ (NSTimer *)jf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(jf_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)jf_blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
