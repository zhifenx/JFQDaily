//
//  JFResponseModel.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/7.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

//*********************************JFCategoryModel****************************//
@interface JFCategoryModel : NSObject
@property (nonatomic, copy) NSString *title;                // 新闻类型（设计、娱乐、智能等)
@end

//*********************************JFPostModel****************************//
@interface JFPostModel : NSObject
@property (nonatomic, copy) NSString *title;                // 新闻标题
@property (nonatomic, copy) NSString *subhead;              // 副标题
@property (nonatomic, assign) NSInteger publish_time;       // 出版时间
@property (nonatomic, copy) NSString *image;                // 配图
@property (nonatomic, assign) NSInteger comment_count;      // 评论数
@property (nonatomic, assign) NSInteger praise_count;       // 点赞数
@property (nonatomic, copy) NSString *appview;              // 新闻文章链接（html格式)
@property (nonatomic, strong) JFCategoryModel *category;
@end

//*********************************JFFeedsModel****************************//
@interface JFFeedsModel : NSObject
@property (nonatomic, copy) NSString *type;                 // 文章类型（以此来判断cell（文章显示）的样式）
@property (nonatomic, copy) NSString *image;                // 文章配图
@property (nonatomic, strong) JFPostModel *post;
@end

//*********************************JFResponseModel****************************//
@interface JFResponseModel : NSObject
@property (nonatomic, copy) NSString *has_more;             // 下拉加载时判断是否还有更多文章 false：没有 true：有
@property (nonatomic, copy) NSString *last_key;             // 下拉加载时需要拼接到URL中的key
@property (nonatomic, strong) JFFeedsModel *feeds;
@end

//*********************************JFBannersModel****************************//
@interface JFBannersModel : JFFeedsModel
@end
