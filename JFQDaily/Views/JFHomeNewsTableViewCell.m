//
//  JFHomeNewsTableViewCell.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/5.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFHomeNewsTableViewCell.h"

#import "Masonry.h"

@interface JFHomeNewsTableViewCell ()

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *newsTitleLabel;
@property (nonatomic, strong) UILabel *subheadLabel;

/**
 *  新闻类型（设计、智能、娱乐等）
 */
@property (nonatomic, strong) UILabel *newsTypeLabel;
/** 该条新闻的评论数*/
@property (nonatomic, strong) UIButton *criticismNumberButton;
/** 点赞数*/
@property (nonatomic, strong) UIButton *praiseButton;
/** 新闻发布时间*/
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation JFHomeNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildControls];
    }
    return self;
}

- (void)addChildControls {
    UIImageView *newsImageView = [[UIImageView alloc] init];
    [self addSubview:newsImageView];
    
    UILabel *newsTitleLabel = [[UILabel alloc] init];
    [self addSubview:newsTitleLabel];
    
    UILabel *newsTypeLabel = [[UILabel alloc] init];
    [self addSubview:newsTypeLabel];
    
    UIButton *criticismNumberButton = [[UIButton alloc] init];
    [self addSubview:criticismNumberButton];
    
    UIButton *praiseButton = [[UIButton alloc] init];
    [self addSubview:praiseButton];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    
    self.newsImageView = newsImageView;
    self.newsTitleLabel = newsTitleLabel;
    self.newsTypeLabel = newsTypeLabel;
    self.criticismNumberButton = criticismNumberButton;
    self.praiseButton = praiseButton;
    self.timeLabel = timeLabel;
}

- (void)customUI {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
