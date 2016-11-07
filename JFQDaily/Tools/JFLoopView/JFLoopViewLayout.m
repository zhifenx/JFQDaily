//
//  JFLoopViewLayout.m
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFLoopViewLayout.h"

@implementation JFLoopViewLayout

/// 准备布局
- (void)prepareLayout {
    [super prepareLayout];
    
    //设置item尺寸
    self.itemSize = self.collectionView.frame.size;
    //设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置分页
    self.collectionView.pagingEnabled = YES;
    
    //设置最小间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    //隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
