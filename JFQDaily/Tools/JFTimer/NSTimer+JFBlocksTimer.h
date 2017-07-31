//
//  NSTimer+JFBlocksTimer.h
//  JFQDaily
//
//  Created by zhifenx on 2017/7/31.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (JFBlocksTimer)

+ (NSTimer *)jf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;

@end
