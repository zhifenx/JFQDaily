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

@property (nonatomic, strong) UITableView *homeNewsTableView;
@property (nonatomic, strong) JFHomeNewsTableViewCell *cell;
@property (nonatomic, strong) JFWindow *jfWindow;
@property (nonatomic, strong) JFHomeNewsDataManager *manager;
@property (nonatomic, strong) JFResponseModel *response;
@property (nonatomic, strong) NSMutableArray *feedsArray;
@property (nonatomic, strong) NSMutableArray *bannersArray;
@property (nonatomic, strong) NSMutableArray *imageMutableArray;

@end

@implementation JFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageMutableArray = [[NSMutableArray alloc] init];
    [self.manager requestHomeNewsDataWithLastKey:@"0"];
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.homeNewsTableView];
    [self addJFWindow];
}

/// 添加图片轮播器
- (void)addLoopView {
    
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


/// 数据管理器
- (JFHomeNewsDataManager *)manager {
    if (!_manager) {
        _manager = [[JFHomeNewsDataManager alloc] init];
        __weak typeof(self) weakSelf = self;
        [_manager newsDataBlock:^(id data) {
            weakSelf.response = [JFResponseModel mj_objectWithKeyValues:data];
            weakSelf.feedsArray = [JFFeedsModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"feeds"]];
            weakSelf.bannersArray = [JFFeedsModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"banners"]];
#warning 不应该在这里添加，需要优化
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
    return self.feedsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFFeedsModel *feed = self.feedsArray[indexPath.row];
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
