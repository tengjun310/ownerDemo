//
//  WebViewViewController.m
//  WMDProject
//
//  Created by teng jun on 2018/12/22.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation WebViewViewController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.delegate = self;
    }
    
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hiddenLeftItem = NO;
    
    self.view.backgroundColor = kColorBackground;
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
}

@end
