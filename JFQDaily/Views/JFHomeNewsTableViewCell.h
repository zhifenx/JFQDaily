//
//  JFHomeNewsTableViewCell.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/5.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFNewsCellLayout.h"

@interface JFHomeNewsTableViewCell : UITableViewCell

/** cell的类型（0、1、2）*/
@property (nonatomic, copy) NSString *cellType;
/** 配图*/
@property (nonatomic, copy) NSString *newsImageName;
/** 标题*/
@property (nonatomic, copy) NSString *newsTitle;
/** 副标题*/
@property (nonatomic, copy) NSString *subhead;


/**
 *  新闻类型（设计、智能、娱乐等）
 */
@property (nonatomic, copy) NSString *newsType;
/** 该条新闻的评论数*/
@property (nonatomic, copy) NSString *commentCount;
/** 点赞数*/
@property (nonatomic, copy) NSString *praiseCount;
/** 新闻发布时间*/
@property (nonatomic, assign) NSInteger time;

@end
