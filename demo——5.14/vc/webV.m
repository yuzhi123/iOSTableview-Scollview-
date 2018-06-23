//
//  webV.m
//  demo——5.14
//
//  Created by koudaishu on 2018/5/21.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "webV.h"
#import "UIViewController+Addtion.h"

@interface webV ()<WKNavigationDelegate>

@property (nonatomic,strong)WKWebView* webView;

@end

@implementation webV



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    NSString* newsUrl = @"http://dev.m.51koudaishu.com/site/about-us.htm?sourse=app&type=1&version=1.7.5";
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:newsUrl]];
    NSString * strUrl = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:newsUrl] encoding:NSUTF8StringEncoding error:nil];
    if (strUrl) {
        [_webView loadHTMLString:strUrl baseURL:[NSURL URLWithString:newsUrl]];
    }
    else
    {
        [_webView loadRequest:request];
    }
    
    [self.view addSubview:_webView];
    self.WWSC = _webView.scrollView;
    _webView.scrollView.contentInset = UIEdgeInsetsMake(280, 0, 0, 0);
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
