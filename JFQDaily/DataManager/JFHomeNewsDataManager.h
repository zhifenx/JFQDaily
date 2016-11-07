//
//  JFHomeNewsDataManager.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/6.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JFHomeNewsDataManagerBlock)(id data);

@interface JFHomeNewsDataManager : NSObject

@property (nonatomic, copy) JFHomeNewsDataManagerBlock newsDataBlock;

//请求新闻数据
- (void)requestHomeNewsDataWithLastKey:(NSString *)lastKey;

- (void)newsDataBlock:(JFHomeNewsDataManagerBlock)block;

@end
