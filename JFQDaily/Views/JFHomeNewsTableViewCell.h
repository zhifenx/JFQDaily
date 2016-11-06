//
//  JFHomeNewsTableViewCell.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/5.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFHomeNewsTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *newsImageName;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *subhead;


/**
 *  新闻类型（设计、智能、娱乐等）
 */
@property (nonatomic, copy) NSString *newsType;
/** 该条新闻的评论数*/
@property (nonatomic, copy) NSString *criticismNumber;
/** 点赞数*/
@property (nonatomic, copy) NSString *praise;
/** 新闻发布时间*/
@property (nonatomic, copy) NSString *time;

@end
