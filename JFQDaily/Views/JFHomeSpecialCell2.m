//
//  JFHomeSpecialCell2.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/7.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFHomeSpecialCell2.h"

#import "JFConfigFile.h"
#import "Masonry.h"

@interface JFHomeSpecialCell2 ()

@property (nonatomic, strong) UILabel *subheadLabel;

@end

@implementation JFHomeSpecialCell2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubControl];
        [self customUI];
    }
    return self;
}

- (void)addSubControl {
    UILabel *subheadLabel = [[UILabel alloc] init];
    subheadLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    subheadLabel.textColor = [UIColor grayColor];
    [self addSubview:subheadLabel];
    
    self.subheadLabel = subheadLabel;
}

- (void)setSubhead:(NSString *)subhead {
    _subhead = subhead;
    self.subheadLabel.text = subhead;
}

- (void)customUI {
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(JFSCREEN_WIDTH);
        make.height.offset(180);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset((JFSCREEN_WIDTH) - 40);
        make.height.offset(40);
        make.top.equalTo(self.newsImageView.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset((JFSCREEN_WIDTH) - 40);
        make.height.offset(60);
        make.top.equalTo(self.newsTitleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(20);
    }];
}

@end
