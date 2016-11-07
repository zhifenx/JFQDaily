//
//  NSString+JFMessage.h
//  JFLive
//
//  Created by 张志峰 on 16/9/9.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

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
