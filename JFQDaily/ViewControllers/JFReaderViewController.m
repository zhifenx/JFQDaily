//
//  JFReaderViewController.m
//  JFQDaily
//
//  Created by 张志峰 on 2016/11/8.
//  Copyright © 2016年 zhifenx. All rights reserved.
//  代码地址：https://github.com/zhifenx/JFQDaily
//  简书地址：http://www.jianshu.com/users/aef0f8eebe6d/latest_articles

#import "JFReaderViewController.h"

//使用WKWebView需先导入WebKit框架
#import <WebKit/WebKit.h>
#import "JFConfigFile.h"
#import "Masonry.h"
#import "JFSuspensionView.h"
#import "MBProgressHUD+JFProgressHUD.h"

@interface JFReaderViewController ()<WKNavigationDelegate, UIScrollViewDelegate>
{
    CGFloat _contentOffset_Y;   //WKWebView滑动后Y轴偏移量
}

/** 加载动画view*/
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *loadingImageView;
/** 悬浮按钮父view*/
@property (nonatomic, strong) JFSuspensionView *jfSuspensionView;

@end

@implementation JFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    [super loadView];
    
    WKWebView *readerWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    readerWebView.navigationDelegate = self;
    readerWebView.scrollView.delegate = self;
    [readerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_newsUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:7.0]];
    [self.view addSubview:readerWebView];
    [self.view addSubview:self.loadingView];
    [self.loadingView addSubview:self.loadingImageView];
    [self customUI];
    
    [self.view addSubview:self.jfSuspensionView];
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
    _newsUrl = newsUrl;
}

/// 悬浮按钮父view
- (JFSuspensionView *)jfSuspensionView {
    if (!_jfSuspensionView) {
        _jfSuspensionView = [[JFSuspensionView alloc] initWithFrame:CGRectMake(20, JFSCREENH_HEIGHT - 60, 61, 61)];
        //设置按钮样式（tag）
        _jfSuspensionView.JFSuspensionButtonStyle = JFSuspensionButtonStyleBackType;
        __weak typeof(self) weakSelf = self;
        [_jfSuspensionView backBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _jfSuspensionView;
}

/// 销毁JFSuspensionView
- (void)destoryJFSuspensionView {
    self.jfSuspensionView.hidden = YES;
    self.jfSuspensionView = nil;
}

#pragma mark --- WKNavigationDelegate

/// WXWebView开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.loadingImageView startAnimating];
}

/// WXWebView加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //渐隐加载动画
    [UIView animateWithDuration:0.3 animations:^{
        [self.loadingView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.loadingImageView stopAnimating];
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }];
}

/// WXWebView加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.loadingImageView stopAnimating];
    [MBProgressHUD promptHudWithShowHUDAddedTo:self.view message:@"加载失败，请检查网络"];
    [NSThread sleepForTimeInterval:1.3];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollDelegate
/// 滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //_contentOffset_Y + 80（隐藏悬浮按钮的阀值）
    if (scrollView.contentOffset.y > _contentOffset_Y + 80) {
        [self hideSuspenstionButton];
    } else if (scrollView.contentOffset.y < _contentOffset_Y) {
        [self showSuspenstionButton];
    }
}

/// 停止滚动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _contentOffset_Y = scrollView.contentOffset.y;
}

/// 显示悬浮按钮
- (void)showSuspenstionButton {
    if (self.jfSuspensionView.layer.frame.origin.y == JFSCREENH_HEIGHT - 60) return;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect tempFrame = self.jfSuspensionView.layer.frame;
        tempFrame.origin.y -= 60;
        self.jfSuspensionView.layer.frame = tempFrame;
    }];
}

/// 隐藏悬浮按钮
- (void)hideSuspenstionButton {
    if (self.jfSuspensionView.layer.frame.origin.y == JFSCREENH_HEIGHT) return;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect tempFrame = self.jfSuspensionView.layer.frame;
        tempFrame.origin.y += 60;
        self.jfSuspensionView.layer.frame = tempFrame;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
