//
//  JFHomeNewsDataManager.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/6.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFHomeNewsDataManager.h"

#import <AFNetworking.h>
#import "JFConfigFile.h"

#define kTimeOutInterval 10

@implementation JFHomeNewsDataManager

#pragma mark - 创建请求者
- (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置相应内容类
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    return manager;
}

#pragma mark - GET方式请求新闻数据
- (void)requestHomeNewsDataWithLastKey:(NSString *)lastKey {
    AFHTTPSessionManager *manager = [self manager];
    //拼接URL
    NSString *urlString = [NSString stringWithFormat:@"http://app3.qdaily.com/app3/homes/index/%@.json?",lastKey];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //  JSON数据转字典
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (self.newsDataBlock) {
            self.newsDataBlock([dataDictionary valueForKey:@"response"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)newsDataBlock:(JFHomeNewsDataManagerBlock)block {
    self.newsDataBlock = block;
}

@end
