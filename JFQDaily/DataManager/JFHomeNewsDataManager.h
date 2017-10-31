//
//  JFHomeNewsDataManager.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/6.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFHomeNewsDataManager : NSObject

/**
 请求新闻数据
 
 @param lastKey 加载新闻的key
 @param result 请求成功返回的结果
 @param failure 请求失败返回的信息
 */
- (void)requestHomeNewsDataWithLastKey:(NSString *)lastKey result:(void(^)(id data))result failure:(void(^)(id message))failure;

@end
