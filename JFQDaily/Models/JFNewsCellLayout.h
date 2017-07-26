//
//  JFNewsCellLayout.h
//  JFQDaily
//
//  Created by zhifenx on 2017/7/25.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFResponseModel.h"

/// 风格
typedef NS_ENUM(NSUInteger, JFNewsCellLayoutStyle) {
    JFNewsCellLayoutStyleAbove = 0,         //cellType = 0,图片在上，文字在下
    JFNewsCellLayoutStyleRight = 1,         //cellType = 1,图片在右，文字在左
    JFNewsCellLayoutStyleDetails = 2,       //cellType = 2,图片在上，文字在下，下方有“评论”和“喜欢”数值
};

@interface JFNewsCellLayout : NSObject
@property (nonatomic, assign) JFNewsCellLayoutStyle style;   //cell风格
@property (nonatomic, assign, readonly) CGFloat height;      //cell高度
@property (nonatomic, strong) JFFeedsModel *model;        // 数据

- (instancetype)initWithModel:(JFFeedsModel *)model style:(JFNewsCellLayoutStyle)style;
@end
