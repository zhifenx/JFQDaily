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

//新闻数据模型相关
#import "JFResponseModel.h"
#import "JFFeedsModel.h"
#import "JFPostModel.h"
#import "JFCategoryModel.h"
#import "JFBannersModel.h"

@interface JFHomeViewController ()

@property (nonatomic, strong) JFWindow *jfWindow;
@property (nonatomic, strong) JFHomeNewsDataManager *manager;
@property (nonatomic, strong) JFResponseModel *response;
@property (nonatomic, strong) NSArray *feedsArray;
@property (nonatomic, strong) NSArray *bannersArray;

@end

@implementation JFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.manager requestHomeNewsDataWithLastKey:@"0"];
}

- (void)loadView {
    [super loadView];
    
    UIView *demo = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    demo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:demo];
    [self addJFWindow];
}

- (JFHomeNewsDataManager *)manager {
    if (!_manager) {
        _manager = [[JFHomeNewsDataManager alloc] init];
        __weak typeof(self) weakSelf = self;
        [_manager newsDataBlock:^(id data) {
            
            weakSelf.response = [JFResponseModel mj_objectWithKeyValues:data];
            
            JFLog(@"has_more---%@",weakSelf.response.has_more);
            
            weakSelf.feedsArray = [JFFeedsModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"feeds"]];
            weakSelf.bannersArray = [JFFeedsModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"banners"]];
            
            for (JFBannersModel *banner in self.bannersArray) {
                JFLog(@"JFBannersModel---%@",banner.post.category.title);
            }
            
            for (JFFeedsModel *feed in self.feedsArray) {
                JFLog(@"JFFeedsModel---%@",feed.post.category.title);
            }
        }];
        
        
    }
    return _manager;
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
