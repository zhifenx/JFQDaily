//
//  JFLoopViewCell.m
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFLoopViewCell.h"

#import <UIImageView+WebCache.h>

@interface JFLoopViewCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titlelabel;

@end

@implementation JFLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.numberOfLines = 3;
        [self addSubview:titleLabel];
        
        self.iconView = iconView;
        self.titlelabel = titleLabel;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    NSURL *imageUrl = [NSURL URLWithString:imageName];
    [self.iconView sd_setImageWithURL:imageUrl placeholderImage:nil];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titlelabel.text = title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = self.bounds;
    self.titlelabel.frame = CGRectMake(20, self.bounds.size.height - 110, self.bounds.size.width - 40, 110);
    self.titlelabel.shadowColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    self.titlelabel.shadowOffset = CGSizeMake(0.3, 0.3);
}

@end
