//
//  NSString+JFString.m
//  JFLive
//
//  Created by 张志峰 on 16/9/9.
//  Copyright © 2016年 zhifenx. All rights reserved.
//  代码地址：https://github.com/zhifenx/JFQDaily
//  简书地址：http://www.jianshu.com/users/aef0f8eebe6d/latest_articles

#import "NSString+JFString.h"

@implementation NSString (JFMessage)

+ (CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font andMaxSize:(CGSize)size {
    NSDictionary*attrs =@{NSFontAttributeName: font};
    return [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs  context:nil].size;
}

+ (NSString *)getShowDateWithTime:(NSString *)time {
    /**
     传入时间转NSDate类型
     */
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:[time longLongValue]/1000.0];
    
    /**
     初始化并定义Formatter
     
     :returns: NSDate
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    /**
     *  使用Formatter格式化时间（传入时间和当前时间）为NSString
     */
    NSString *timeStr = [dateFormatter stringFromDate:timeDate];
    NSString *nowDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    /**
     *  判断前四位是不是本年，不是本年直接返回完整时间
     */
    if ([[timeStr substringWithRange:NSMakeRange(0, 4)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]].location == NSNotFound) {
        return timeStr;
    }else{
        /**
         *  判断是不是本天，是本天返回HH:mm,不是返回MM-dd HH:mm
         */
        if ([[timeStr substringWithRange:NSMakeRange(5, 5)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(5, 5)]].location != NSNotFound) {
            return [timeStr substringWithRange:NSMakeRange(11, 5)];
        }else{
            return [timeStr substringWithRange:NSMakeRange(5, 11)];
        }
    }
}

@end
