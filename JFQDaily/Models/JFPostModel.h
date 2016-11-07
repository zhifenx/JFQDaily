//
//  JFPostModel.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/6.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JFCategoryModel;

@interface JFPostModel : NSObject

/** 新闻标题*/
@property (nonatomic, copy) NSString *title;
/** 副标题*/
@property (nonatomic, copy) NSString *subhead;
/** 出版时间*/
@property (nonatomic, assign) NSInteger publish_time;
/** 配图*/
@property (nonatomic, copy) NSString *image;
/** 评论数*/
@property (nonatomic, assign) NSInteger comment_count;
/** 点赞数*/
@property (nonatomic, assign) NSInteger praise_count;
/** 新闻文章链接（html格式）*/
@property (nonatomic, copy) NSString *appview;

@property (nonatomic, strong) JFCategoryModel *category;

@end
