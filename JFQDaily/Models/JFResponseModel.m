//
//  JFResponseModel.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/7.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFResponseModel.h"

@implementation JFCategoryModel
@end



@implementation JFPostModel

// 设置模型属性名和字典key之间的映射关系
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"subhead":@"description"};// 返回的字典，key为模型属性名，value为转化的字典的多级key
}

@end

@implementation JFFeedsModel
@end



@implementation JFResponseModel
@end



@implementation JFBannersModel
@end
