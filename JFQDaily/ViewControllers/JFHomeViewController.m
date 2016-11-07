//
//  JFHomeViewController.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/4.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFHomeViewController.h"

#import "JFConfigFile.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "MJExtension.h"
#import "JFWindow.h"
#import "JFHomeNewsDataManager.h"
#import "JFHomeNewsTableViewCell.h"
#import "JFLoopView.h"
//新闻数据模型相关
#import "JFResponseModel.h"
#import "JFFeedsModel.h"
#import "JFPostModel.h"
#import "JFCategoryModel.h"
#import "JFBannersModel.h"


static NSString *ID = @"newsCell";

@interface JFHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *_last_key;//上拉加载时传入的key
    NSString *_has_more;//是否还有未加载的文章
}

@property (nonatomic, strong) UITableView *homeNewsTableView;
@property (nonatomic, strong) JFHomeNewsTableViewCell *cell;
@property (nonatomic, strong) JFWindow *jfWindow;
@property (nonatomic, strong) JFHomeNewsDataManager *manager;
@property (nonatomic, strong) JFResponseModel *response;
@property (nonatomic, strong) NSArray *feedsArray;
@property (nonatomic, strong) NSArray *bannersArray;
@property (nonatomic, strong) NSArray *imageArray;
/** 主要内容数组*/
@property (nonatomic, strong) NSMutableArray *contentMutableArray;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *refreshFooter;

@end

@implementation JFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentMutableArray = [[NSMutableArray alloc] init];
    self.imageArray = [[NSArray alloc] init];
    [self.manager requestHomeNewsDataWithLastKey:@"0"];
    
    //设置下拉刷新
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshData];
    }];
    self.refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    self.refreshHeader.stateLabel.hidden = YES;
    self.homeNewsTableView.mj_header = self.refreshHeader;
    
    //设置上拉加载
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.refreshFooter setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
    [self.refreshFooter setTitle:@"没有更多内容了" forState:MJRefreshStateNoMoreData];
    self.homeNewsTableView.mj_footer = self.refreshFooter;
    
}

/// 下拉刷新数据
- (void)refreshData {
    //下拉刷新时清空数据
    self.contentMutableArray = [[NSMutableArray alloc] init];
//    self.homeNewsTableView.tableHeaderView = nil;
    [self.manager requestHomeNewsDataWithLastKey:@"0"];
}

/// 上拉加载数据
- (void)loadData {
    //判断是否还有更多数据
    if ([_has_more isEqualToString:@"1"]) {
        [self.manager requestHomeNewsDataWithLastKey:_last_key];
    }else if ([_has_more isEqualToString:@"0"]) {
    [self.refreshFooter setState:MJRefreshStateNoMoreData];
    }
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.homeNewsTableView];
    [self addJFWindow];
}

/// 添加图片轮播器
- (void)addLoopView {
    //这里做判断是不免上拉加载时出现数据错误（如果轮播器已经存在就不再添加）
    if (!self.homeNewsTableView.tableHeaderView) {
        NSMutableArray *imageMuatableArray = [[NSMutableArray alloc] init];
        NSMutableArray *titleMutableArray = [[NSMutableArray alloc] init];
        for (JFBannersModel *banner in self.bannersArray) {
            [imageMuatableArray addObject:banner.post.image];
            [titleMutableArray addObject:banner.post.title];
        }
        JFLoopView *loopView = [[JFLoopView alloc] initWithImageMutableArray:imageMuatableArray titleMutableArray:titleMutableArray];
        loopView.frame = CGRectMake(0, 0, JFSCREEN_WIDTH, 300);
        self.homeNewsTableView.tableHeaderView = loopView;
    }
}


/// 数据管理器
- (JFHomeNewsDataManager *)manager {
    if (!_manager) {
        _manager = [[JFHomeNewsDataManager alloc] init];
        __weak typeof(self) weakSelf = self;
        [_manager newsDataBlock:^(id data) {
            weakSelf.response = [JFResponseModel mj_objectWithKeyValues:data];
            _last_key = weakSelf.response.last_key;
            _has_more = weakSelf.response.has_more;
            
            
            weakSelf.feedsArray = [JFFeedsModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"feeds"]];
            
            //在contentMutableArray后面添加一个数组
            [weakSelf.contentMutableArray addObjectsFromArray:weakSelf.feedsArray];
            
            weakSelf.bannersArray = [JFFeedsModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"banners"]];
            
            //停止刷新
            [self.refreshHeader endRefreshing];
            [self.refreshFooter endRefreshing];
            
            [self addLoopView];
            [self.homeNewsTableView reloadData];
        }];
        
    }
    return _manager;
}

/// 懒加载JFHomeNewsTableView（首页根view）
- (UITableView *)homeNewsTableView {
    if (!_homeNewsTableView) {
        _homeNewsTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_homeNewsTableView registerClass:[JFHomeNewsTableViewCell class] forCellReuseIdentifier:ID];
        _homeNewsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeNewsTableView.delegate = self;
        _homeNewsTableView.dataSource = self;
    }
    return _homeNewsTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFFeedsModel *feed = self.contentMutableArray[indexPath.row];
    self.cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.cell == nil) {
        self.cell = [[JFHomeNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        self.cell.cellType = feed.type;
        self.cell.newsImageName = feed.post.image;
        self.cell.newsTitle = feed.post.title;
        self.cell.newsType = feed.post.category.title;
        self.cell.commentCount = [NSString stringWithFormat:@"%ld",(long)feed.post.comment_count];
        self.cell.praiseCount = [NSString stringWithFormat:@"%ld",(long)feed.post.praise_count];
    }
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (![feed.type isEqualToString:@"1"]) {
        self.cell.subhead = feed.post.subhead;
    }
    return self.cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFHomeNewsTableViewCell *cell = self.cell;
    if ([cell.cellType isEqualToString:@"0"]) {
        return 330;
    }else if ([cell.cellType isEqualToString:@"2"]) {
        return 360;
    }else {
        return 130;
    }
}

/// 添加悬浮按钮window
- (void)addJFWindow {
    JFWindow *jfWindow = [[JFWindow alloc] initWithFrame:CGRectMake(20, JFSCREENH_HEIGHT - 80, 54, 54)];
    jfWindow.windowLevel = UIWindowLevelAlert * 2;
    [jfWindow makeKeyAndVisible];
    self.jfWindow = jfWindow;
}

/// 销毁JFWindow
- (void)destoryJFWindow {
    self.jfWindow.hidden = YES;
    self.jfWindow = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
