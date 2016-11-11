//
//  JFLoopView.h
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//  代码地址：https://github.com/zhifenx/JFQDaily
//  简书地址：http://www.jianshu.com/users/aef0f8eebe6d/latest_articles

#import <UIKit/UIKit.h>

typedef void(^JFLoopViewBlock)(NSString *Url);

@interface JFLoopView : UIView

/** 点击collectionView的item跳转Block*/
@property (nonatomic, copy) JFLoopViewBlock didSelectCollectionItemBlock;

@property (nonatomic, strong) NSMutableArray *newsUrlMutableArray;

- (instancetype)initWithImageMutableArray:(NSMutableArray *)imageMutableArray
                        titleMutableArray:(NSMutableArray *)titleMutableArray;

- (void)didSelectCollectionItemBlock:(JFLoopViewBlock)block;

@end
