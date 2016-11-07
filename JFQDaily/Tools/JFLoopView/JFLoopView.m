//
//  JFLoopView.m
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFLoopView.h"

#import "JFLoopViewLayout.h"
#import "JFLoopViewCell.h"
#import "JFWeakTimerTargetObject.h"

@interface JFLoopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imageMutableArray;
@property (nonatomic, strong) NSMutableArray *titleMutableArray;
@property (nonatomic, weak) NSTimer *timer;

@end

static NSString *ID = @"loopViewCell";

@implementation JFLoopView

- (instancetype)initWithImageMutableArray:(NSMutableArray *)imageMutableArray
                        titleMutableArray:(NSMutableArray *)titleMutableArray {
    if (self = [super init]) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[JFLoopViewLayout alloc] init]];
        [collectionView registerClass:[JFLoopViewCell class] forCellWithReuseIdentifier:ID];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self addSubview:collectionView];
        
        self.collectionView = collectionView;
        self.imageMutableArray = imageMutableArray;
        self.titleMutableArray = titleMutableArray;
        
        //添加分页器
        [self addSubview:self.pageControl];
        
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageMutableArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            
            //添加定时器
            [self addTimer];
        });
        
    }
    return self;
}

/// 懒加载pageControl
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 270, 0, 30)];
        _pageControl.numberOfPages = self.imageMutableArray.count;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _pageControl;
}

#pragma mark UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageMutableArray.count * 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JFLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName = self.imageMutableArray[indexPath.item % self.imageMutableArray.count];
    cell.title = self.titleMutableArray[indexPath.item % self.titleMutableArray.count];
    return cell;
}

#pragma mark ---- UICollectionViewDelegate

/// 开始拖地时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

/// 当滚动减速时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / scrollView.bounds.size.width;
    if (page == 0) {
        page = self.imageMutableArray.count;
        self.collectionView.contentOffset = CGPointMake(page * scrollView.frame.size.width, 0);
    }else if (page == [self.collectionView numberOfItemsInSection:0] - 1) {
        page = self.imageMutableArray.count - 1;
        self.collectionView.contentOffset = CGPointMake(page * scrollView.frame.size.width, 0);
    }
    
    //设置UIPageControl当前页
    NSInteger currentPage = page % self.imageMutableArray.count;
    self.pageControl.currentPage =currentPage;
    //添加定时器
    [self addTimer];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //移除定时器
    [self removeTimer];
}

/// 添加定时器
- (void)addTimer {
    if (self.timer) return;
    self.timer = [JFWeakTimerTargetObject scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/// 移除定时器
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

/// 切换到下一张图片
- (void)nextImage {
    CGFloat offsetX = self.collectionView.contentOffset.x;
    NSInteger page = offsetX / self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake((page + 1) * self.collectionView.bounds.size.width, 0) animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)dealloc {
    [self removeTimer];
}

@end
