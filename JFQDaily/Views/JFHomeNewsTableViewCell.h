//
//  JFHomeNewsTableViewCell.h
//  JFQDaily
//
//  Created by zhifenx on 2017/7/25.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFNewsCellLayout.h"
#import <UIImageView+WebCache.h>
#import "JFConfigFile.h"

@interface JFBottomView : UIView

@property (nonatomic, strong) UIImageView *commentImageView; // 评论icon
@property (nonatomic, strong) UIImageView *praiseImageView;  // 喜欢icon
@property (nonatomic, strong) UILabel *newsTypeLabel;        // 新闻类型（设计、智能、娱乐等）
@property (nonatomic, strong) UILabel *commentlabel;         // 该条新闻的评论数
@property (nonatomic, strong) UILabel *praiseLabel;          // 点赞数
@property (nonatomic, strong) UILabel *timeLabel;            // 新闻发布时间
@end

@interface JFNewsView : UIView

@property (nonatomic, strong) UIImageView *newsImageView;    // 新闻图片
@property (nonatomic, strong) UILabel *newsTitleLabel;       // 新闻标题
@property (nonatomic, strong) UILabel *subheadLabel;         // 新闻副标题
@end

@interface JFHomeNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) JFNewsView *newsView;
@property (nonatomic, strong) JFBottomView *bottomView;
@property (nonatomic, strong) UIView *cellBackgroundView;
@property (nonatomic, strong) JFNewsCellLayout *layout;;
- (void)setLayout:(JFNewsCellLayout *)layout;
@end
