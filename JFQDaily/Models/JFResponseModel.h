//
//  JFResponseModel.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/7.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JFFeedsModel;

@interface JFResponseModel : NSObject

/** 下拉加载时判断是否还有更多文章 false：没有 true：有*/
@property (nonatomic, copy) NSString *has_more;

/** 下拉加载时需要拼接到URL中的key*/
@property (nonatomic, copy) NSString *last_key;

@property (nonatomic, strong) JFFeedsModel *feeds;

@end
