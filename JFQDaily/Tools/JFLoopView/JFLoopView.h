//
//  JFLoopView.h
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

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
