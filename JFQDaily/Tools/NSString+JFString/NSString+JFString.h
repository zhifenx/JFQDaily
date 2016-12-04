//
//  NSString+JFString.h
//  JFLive
//
//  Created by 张志峰 on 16/9/9.
//  Copyright © 2016年 zhifenx. All rights reserved.
//  代码地址：https://github.com/zhifenx/JFQDaily
//  简书地址：http://www.jianshu.com/users/aef0f8eebe6d/latest_articles

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JFMessage)

/**
 *  返回聊天信息文本的宽高
 */
+ (CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font andMaxSize:(CGSize)size;

/**
 *  将毫秒转换成日期
 */
+ (NSString *)getShowDateWithTime:(NSString *)time;

@end
