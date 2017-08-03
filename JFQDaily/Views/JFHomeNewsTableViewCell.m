//
//  JFHomeNewsTableViewCell.m
//  JFQDaily
//
//  Created by zhifenx on 2017/7/25.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "JFHomeNewsTableViewCell.h"

static CGFloat newsTitleLabel_x = 20;

@implementation JFBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _newsTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsTitleLabel_x, 0, 30, 21)];
        _newsTypeLabel.font = [UIFont systemFontOfSize:12.0];
        _newsTypeLabel.textColor = [UIColor grayColor];
        [self addSubview:_newsTypeLabel];
        //
        CGFloat commentImageView_x = newsTitleLabel_x + _newsTypeLabel.frame.size.width + 3;
        CGFloat commentImageView_y = frame.size.height / 2 - 12.5 / 2 + 1;
        _commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(commentImageView_x, commentImageView_y, 12.5, 11.5)];
        [self addSubview:_commentImageView];
        //
        CGFloat commentlabel_x = commentImageView_x + _commentImageView.frame.size.width + 3;
        _commentlabel = [[UILabel alloc] initWithFrame:CGRectMake(commentlabel_x, 0, 30, 21)];
        _commentlabel.font = [UIFont systemFontOfSize:13.0];
        _commentlabel.textColor = [UIColor grayColor];
        [self addSubview:_commentlabel];
        //
        CGFloat praiseImageView_x = commentlabel_x + _commentlabel.frame.size.width;
        CGFloat praiseImageView_y = frame.size.height / 2 - 13 / 2 + 1;
        _praiseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(praiseImageView_x, praiseImageView_y, 13, 11.5)];
        [self addSubview:_praiseImageView];
        //
        CGFloat praiseLabel_x = praiseImageView_x + _praiseImageView.frame.size.width + 3;
        _praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(praiseLabel_x, 0, 30, 21)];
        _praiseLabel.font = [UIFont systemFontOfSize:13.0];
        _praiseLabel.textColor = [UIColor grayColor];
        [self addSubview:_praiseLabel];
    }
    return self;
}

@end




@implementation JFNewsView

- (instancetype)initWithFrame:(CGRect)frame style:(JFNewsCellLayoutStyle)style {
    if (self = [super initWithFrame:frame]) {
        switch (style) {
            case JFNewsCellLayoutStyleAbove:    //cellType = 0,图片在上，文字在下
                [self _aboveStyle];
                break;
            case JFNewsCellLayoutStyleRight:    //cellType = 1,图片在右，文字在左
                [self _rightStyle];
                break;
            default:                            //cellType = 2,图片在上，文字在下，下方有“评论”和“喜欢”数值
                [self _aboveStyle];
                break;
        }
    }
    return self;
}

// Above style
- (void)_aboveStyle {
    CGFloat newsImageView_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat newsImageView_h = 220;
    _newsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, newsImageView_w, 220)];
    [self addSubview:_newsImageView];
    //
    CGFloat newsTitleLabel_w = newsImageView_w - newsTitleLabel_x * 2;
    CGFloat newsTitleLabel_y = newsImageView_h + 5;
    _newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsTitleLabel_x, newsTitleLabel_y, newsTitleLabel_w, 60)];
    _newsTitleLabel.textColor = JFRGBAColor(42, 42, 42, 0.99);
    _newsTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    _newsTitleLabel.numberOfLines = 5;
    [self addSubview:_newsTitleLabel];
    //
    CGFloat subheadLabel_y = newsTitleLabel_y + 55;
    _subheadLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsTitleLabel_x, subheadLabel_y, newsTitleLabel_w, 40)];
    _subheadLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    _subheadLabel.textColor = [UIColor grayColor];
    _subheadLabel.numberOfLines = 3;
    [self addSubview:_subheadLabel];
}

// Right style
- (void)_rightStyle {
    CGFloat newsTitleLabel_w = [UIScreen mainScreen].bounds.size.width / 2 - 40;
    _newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsTitleLabel_x, 10, newsTitleLabel_w, 80)];
    _newsTitleLabel.textColor = JFRGBAColor(42, 42, 42, 0.99);
    _newsTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    _newsTitleLabel.numberOfLines = 5;
    [self addSubview:_newsTitleLabel];
    //
    CGFloat newsImageView_x = newsTitleLabel_x + newsTitleLabel_w + 20;
    CGFloat newsImageView_w = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat newsImageView_h = self.frame.size.height;
    _newsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(newsImageView_x, 0, newsImageView_w, newsImageView_h)];
    [self addSubview:_newsImageView];
}

@end




@implementation JFHomeNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)_layout {
    if (_layout.style == JFNewsCellLayoutStyleAbove) {          //cellType = 0,图片在上，文字在下
        [self _newsView];
    }else if (_layout.style == JFNewsCellLayoutStyleRight) {    //cellType = 1,图片在右，文字在左
        [self _newsView];
        [self _bottomViewWithWidth:self.frame.size.width / 2];
    }else if (_layout.style == JFNewsCellLayoutStyleDetails) {  //cellType = 2,图片在上，文字在下，下方有“评论”和“喜欢”数值
        [self _newsView];
        [self _bottomViewWithWidth:self.frame.size.width];
    }
}

- (void)_newsView {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    _newsView = [[JFNewsView alloc] initWithFrame:CGRectMake(0, 5, w, _layout.height - 5) style:_layout.style];
    [_cellBackgroundView addSubview:_newsView];
}

- (void)_bottomViewWithWidth:(CGFloat)width {
    _bottomView = [[JFBottomView alloc] initWithFrame:CGRectMake(0, _layout.height-5-21, width, 21)];
    [_cellBackgroundView addSubview:_bottomView];
}

- (void)setLayout:(JFNewsCellLayout *)layout {
    _layout = layout;
    CGRect tempFrame = self.contentView.frame;
    tempFrame.size.height = layout.height;
    self.contentView.frame = tempFrame;
    
    [_cellBackgroundView removeFromSuperview];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    _cellBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, _layout.height)];
    UIView *cellSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 5)];
    cellSeparator.backgroundColor = JFRGBAColor(238, 238, 238, 1);
    [_cellBackgroundView addSubview:cellSeparator];
    [self.contentView addSubview:_cellBackgroundView];
    [self _layout];
    [self _data];
}

- (void)_data {
    NSURL *imageUrl = [NSURL URLWithString:_layout.model.post.image];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //图片渐显效果
    [_newsView.newsImageView sd_setImageWithURL:imageUrl
                          placeholderImage:nil
                                   options:SDWebImageRefreshCached
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     if ([manager diskImageExistsForURL:imageUrl]) {
                                         return;//缓存中有，不再加载
                                     }else {
                                         _newsView.newsImageView.alpha = 0.0;
                                         [UIView transitionWithView:_newsView.newsImageView
                                                           duration:0.5
                                                            options:UIViewAnimationOptionTransitionCrossDissolve
                                                         animations:^{
                                                             _newsView.newsImageView.alpha = 1.0;
                                                         } completion:NULL];
                                     }
                                 }];
    _newsView.newsTitleLabel.text = _layout.model.post.title;
    _newsView.subheadLabel.text = _layout.model.post.subhead;
    _bottomView.newsTypeLabel.text = _layout.model.post.category.title;
    _bottomView.commentImageView.image = [UIImage imageNamed:@"feedComment"];
    _bottomView.commentlabel.text = [NSString stringWithFormat:@"%ld",_layout.model.post.comment_count];
    _bottomView.praiseImageView.image = [UIImage imageNamed:@"feedPraise"];
    _bottomView.praiseLabel.text = [NSString stringWithFormat:@"%ld",_layout.model.post.praise_count];
}
@end
