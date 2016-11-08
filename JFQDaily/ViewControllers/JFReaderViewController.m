//
//  JFReaderViewController.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/8.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFReaderViewController.h"

//使用WKWebView需先导入WebKit框架
#import <WebKit/WebKit.h>
#import "JFConfigFile.h"
#import "Masonry.h"
#import "JFWindow.h"

@interface JFReaderViewController ()<WKNavigationDelegate>

/** 加载动画view*/
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *loadingImageView;
@property (nonatomic, strong) JFWindow *jfWindow;

@end

@implementation JFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    [super loadView];
    
    WKWebView *readerWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    readerWebView.navigationDelegate = self;
    [readerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_newsUrl]]];
    [self.view addSubview:readerWebView];
    [self.view addSubview:self.loadingView];
    [self.loadingView addSubview:self.loadingImageView];
    [self customUI];
    [self addJFWindow];
}

/// 懒加载，加载动画界面
- (UIView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
        _loadingView.backgroundColor = [UIColor whiteColor];
    }
    return _loadingView;
}

///懒加载，加载动画imageview
- (UIImageView *)loadingImageView {
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] init];
        NSMutableArray *imageMutableArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 93; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"QDArticleLoading_0%d",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [imageMutableArray addObject:image];
        }
        _loadingImageView.animationImages = imageMutableArray;
        _loadingImageView.animationDuration = 3.0;
        _loadingImageView.animationRepeatCount = MAXFLOAT;
    }
    return _loadingImageView;
}

/// 使用Masonry，自动布局子控件
- (void)customUI {
    [self.loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.height.offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setNewsUrl:(NSString *)newsUrl {
    JFLog(@"newsUrl--%@",newsUrl);
    _newsUrl = newsUrl;
}

/// 添加悬浮按钮window
- (void)addJFWindow {
    if (!self.jfWindow) {
        JFWindow *jfWindow = [[JFWindow alloc] initWithFrame:CGRectMake(20, JFSCREENH_HEIGHT - 80, 54, 54)];
        jfWindow.JFSuspensionButtonStyle = JFSuspensionButtonStyleBackType;
        jfWindow.windowLevel = UIWindowLevelAlert * 2;
        [jfWindow makeKeyAndVisible];
        self.jfWindow = jfWindow;
        
        __weak typeof(self) weakSelf = self;
        [jfWindow backBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
}

/// 销毁JFWindow
- (void)destoryJFWindow {
    self.jfWindow.hidden = YES;
    self.jfWindow = nil;
}

#pragma mark --- WKNavigationDelegate

/// WXWebView开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.loadingImageView startAnimating];
}

/// WXWebView加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.loadingImageView stopAnimating];
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
}

/// WXWebView加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    JFLog(@"加载失败");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
