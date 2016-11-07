//
//  JFFeedsModel.h
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/6.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JFPostModel;

@interface JFFeedsModel : NSObject

/** 文章类型（以此来判断cell（文章显示）的样式）*/
@property (nonatomic, copy) NSString *type;

/** 文章配图 */
@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) JFPostModel *post;

@end
