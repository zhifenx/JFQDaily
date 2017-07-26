//
//  JFNewsCellLayout.m
//  JFQDaily
//
//  Created by zhifenx on 2017/7/25.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "JFNewsCellLayout.h"

@implementation JFNewsCellLayout

- (instancetype)initWithModel:(JFFeedsModel *)model style:(JFNewsCellLayoutStyle)style {
    if (self = [super init]) {
        _model = model;
        _style = style;
    }
    return self;
}

- (CGFloat)height {
    switch (_style) {
        case JFNewsCellLayoutStyleAbove:
            return 330;
            break;
        case JFNewsCellLayoutStyleRight:
            return 130;
            break;
        default:
            return 360;
            break;
    }
}

@end
