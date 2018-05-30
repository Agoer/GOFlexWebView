//
//  GoFlexWebViewController.m
//  GOFlexWebViewDemo
//
//  Created by 李二狗 on 2018/5/30.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "GoFlexWebViewController.h"
#import "GoFlexWebViewNavigationBar.h"
#import "GoWKWebView.h"
#import "GoFlexWebViewToolBar.h"
#import "GoFlexWebViewConstant.h"
@interface GoFlexWebViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
{
    CGFloat _scrollBeginDraggingY;
    BOOL _didScroll;
}
@property (strong, nonatomic)GoFlexWebViewNavigationBar *go_navigationBar;
@property (strong, nonatomic)GoWKWebView *go_webView;
@property (strong, nonatomic)GoFlexWebViewToolBar *go_toolBar;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic)UILabel *go_baseUrlLabel;  //category
@end

@implementation GoFlexWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGo_barColor;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self go_initView];
    
    [self.go_webView addObserver:self
                 forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                    options:0
                    context:nil];
    [self.go_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mp.weixin.qq.com/s/IAyBVAp-BED_8rD8zDrsXA"]]];
    // Do any additional setup after loading the view.
     self.go_baseUrlLabel.text = [NSString stringWithFormat:@"此网页由 %@ 提供",self.go_webView.URL.host];
    
}

- (void)go_initView
{
    [self.view addSubview:self.go_navigationBar];
    [self.go_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).offset(0);
        make.height.equalTo(@64);
    }];
    
    [self.view addSubview:self.go_toolBar];
    [self.go_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view).offset(0);
        make.height.equalTo(@0);
    }];
    
    [self.view addSubview:self.go_webView];
    [self.go_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.go_navigationBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.go_toolBar.mas_top).offset(0);
        
    }];
    
    
    
    [self.go_webView addSubview:self.go_baseUrlLabel];
    [self.go_baseUrlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.go_webView);
        make.top.equalTo(self.go_webView).offset(20);
    }];
    self.go_baseUrlLabel.hidden = YES;
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.go_navigationBar.mas_bottom).offset(0);
        make.height.equalTo(@3);
    }];
   
    __weak typeof(self) weakSelf = self;
    self.go_navigationBar.leftButtonPressed = ^(UIButton *button) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
}

//kvo 监听进度
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.go_webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.go_webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.go_webView.estimatedProgress
                              animated:animated];
        
        if (self.go_webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.5f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressView setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0.0f animated:NO];
                             }];
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}


-(void)dealloc{
    [self.go_webView removeObserver:self
                         forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让进度条显示
    self.progressView.hidden = NO;
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始记录 当前值
    _scrollBeginDraggingY = scrollView.contentOffset.y;
    _didScroll = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _didScroll = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsey_y = scrollView.contentOffset.y;
    
    CGFloat scroll_offset = offsey_y - _scrollBeginDraggingY;
    [self go_scrollHeight:scroll_offset];
    
    if (offsey_y > - 40) {
        self.go_baseUrlLabel.hidden = YES;
        self.go_baseUrlLabel.alpha = 0;
        
    } else {
        self.go_baseUrlLabel.hidden = NO;
        
        if (offsey_y < -100) {
            self.go_baseUrlLabel.alpha = 1;
        } else {
            self.go_baseUrlLabel.alpha = (-offsey_y-40)/60.0;
        }
    }
    
}

- (void)go_scrollHeight:(CGFloat)scroll_offset
{
 CGFloat reallyLength = fabs(scroll_offset);
    
    if (reallyLength == 0 || !_didScroll) {
        return;
    }
    if(scroll_offset < 0) {
        NSLog(@"------往下滚动");
        //
        if(self.go_navigationBar.go_y == -24 && reallyLength >= 64) {
            
            [UIView animateWithDuration:0.38 animations:^{
                [self.go_navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.height.equalTo(@(64));
                     make.top.equalTo(self.view).offset(0);
                }];
                 [self.view layoutIfNeeded];
                [self.go_navigationBar setIndent:NO];
            }];
            
//            [UIView animateWithDuration:0.38 delay:0.2  options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                [self.go_navigationBar setIndent:NO];
//            } completion:^(BOOL finished) {
//
//            }];
        }
        
        
        
    }if(scroll_offset > 0) {
        NSLog(@"------往上滚动");
        if(self.go_navigationBar.go_y == 0 && reallyLength >= 64) {
            
//            [UIView animateWithDuration:0.2 animations:^{
//                [self.go_navigationBar setIndent:YES];
//
//            }];
              [UIView animateWithDuration:0.38 animations:^{
                   [self.go_navigationBar setIndent:YES];
                  [self.go_navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
                      make.top.equalTo(self.view).offset(-24);
                  }];
                   [self.view layoutIfNeeded];
                  
               }];
            
           
        }
    }
    
}


#pragma mark- lazy init
- (GoFlexWebViewNavigationBar *)go_navigationBar
{
    if (!_go_navigationBar) {
        _go_navigationBar = [[GoFlexWebViewNavigationBar alloc]initWithFrame:CGRectZero];
    }
    return _go_navigationBar;
}

- (GoWKWebView *)go_webView
{
    if (!_go_webView) {
        _go_webView = [[GoWKWebView alloc]initWithFrame:CGRectZero];
        _go_webView.UIDelegate = self;
        _go_webView.navigationDelegate = self;
        [_go_webView setOpaque:NO];
        _go_webView.backgroundColor = kGo_barColor;
        _go_webView.scrollView.delegate = self;
    }
    return _go_webView;
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView  = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [_progressView setTrackTintColor:[UIColor clearColor]];
        _progressView.progressTintColor = kGo_progressBarColor;
    }
    return _progressView;
}



- (UILabel *)go_baseUrlLabel
{
    if (!_go_baseUrlLabel) {
        _go_baseUrlLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _go_baseUrlLabel.textColor = kGo_tipsTextColor;
        _go_baseUrlLabel.backgroundColor = kGo_barColor;
        _go_baseUrlLabel.font = [UIFont systemFontOfSize:14];
        _go_baseUrlLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _go_baseUrlLabel;
}

- (GoFlexWebViewToolBar *)go_toolBar
{
    if (!_go_toolBar) {
        _go_toolBar = [[GoFlexWebViewToolBar alloc]initWithFrame:CGRectZero];
    }
    return _go_toolBar;
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
