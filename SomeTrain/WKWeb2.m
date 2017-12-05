//
//  WKWeb2.m
//  SomeTrain
//
//  Created by listome on 2017/7/4.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "WKWeb2.h"
#import <WebKit/WebKit.h>
@interface WKWeb2 ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
{
    NSMutableArray *nameArr;
}
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)UIProgressView *jdProgress;//加载进度条
@property(nonatomic,strong)UIBarButtonItem *backItem;
@property(nonatomic,strong)UIBarButtonItem *goItem;
@end

@implementation WKWeb2

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除监听
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    nameArr = [NSMutableArray array];
    
    [self createWeb];
    [self creatProgress];
    [self createToolBar];
    //添加KVO监听
    /*
     [self.webView addObserver:self
     forKeyPath:@"loading"
     options:NSKeyValueObservingOptionNew
     context:nil];
     [self.webView addObserver:self
     forKeyPath:@"title"
     options:NSKeyValueObservingOptionNew
     context:nil];
     [self.webView addObserver:self
     forKeyPath:@"estimatedProgress"
     options:NSKeyValueObservingOptionNew
     context:nil];
     
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(gofarward)];
     */
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    
    
    
    
}

-(void)goback{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        NSLog(@"back");
    }
}

-(void)goItemAction{
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}


-(void)createWeb{
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.minimumFontSize = 10;//抽象点的字体
    config.preferences.javaScriptEnabled = YES;//是否支持JavaScript
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;//不通过用户交互，是否可以打开新窗口
    config.userContentController = [WKUserContentController new];//通过JS与webView内容交互
    
    //注入JS对象名称 senderModel，当JS通过senderModel来调用时，我们可以在WKScriptMessagehandler代理中收到
    [config.userContentController addScriptMessageHandler:self name:@"senderModel"];
    [config.userContentController addScriptMessageHandler:self name:@"addSome"];
    [nameArr addObject:@"senderModel"];
    [nameArr addObject:@"addSome"];
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    //加载本地HTML文件
    NSURL *path = [[NSBundle mainBundle]URLForResource:@"WKWebViewText" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    //加载本地URL文件
    //加载二进制数据
    [self.view addSubview:self.webView];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
}

-(void)creatProgress{

    self.jdProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 1)];
    self.jdProgress.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.jdProgress];
}

-(void)createToolBar{
    //创建toolBar
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
    [self.view addSubview:toolBar];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    backItem.enabled = NO;
    self.backItem = backItem;
    
    
    UIBarButtonItem *fiexible = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *goItem = [[UIBarButtonItem alloc]initWithTitle:@"前进" style:UIBarButtonItemStylePlain target:self action:@selector(goItemAction)];
    goItem.enabled = NO;
    self.goItem = goItem;
    
    toolBar.items = @[backItem,fiexible,goItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - KVO监听函数
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }else if([keyPath isEqualToString:@"loading"]){
        NSLog(@"loading");
    }
    else if ([keyPath isEqualToString:@"estimatedProgress"]){
        //estimatedProgress取值范围是0-1;
        self.jdProgress.progress = self.webView.estimatedProgress;
    }
    
    if (!self.webView.loading) {
        [UIView animateWithDuration:0.5 animations:^{
            self.jdProgress.alpha = 0;
        }];
    }
}

#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"senderModel"]) {
        //// 打印所传过来的参数，body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
        //do something
        NSLog(@"%@",message.body);
        [self senderModel];
        
    }
    if ([message.name isEqualToString:@"addSome"]) {
        //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
        NSLog(@"是这样走的吗:%@",message.body);
        [self addSome];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新主线程处理（如UI更新）
            
        });
    }
    
  
}

-(void)senderModel{
    NSLog(@"走了senderModel");
}
-(void)addSome{
    NSLog(@"走了addSome");
    NSString *nih = @"wer";
    //传值给js那边
    [self.webView evaluateJavaScript:nih completionHandler:^(id _Nullable value, NSError * _Nullable error) {
        
    }];
    
}

#pragma mark = WKNavigationDelegate
// 决定导航的动作，通常用于处理跨域的链接能否导航。WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接
// 单独处理。但是，对于Safari是允许跨域的，不用这么处理。
//在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    NSLog(@"%@",hostname);
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && ![hostname containsString:@".baidu.com"]) {
        // 对于跨域，需要手动跳转
        [[UIApplication sharedApplication]openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:nil];
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        self.jdProgress.alpha = 1.0;
        decisionHandler(WKNavigationActionPolicyAllow);
    }
 
}
// 决定是否接收响应
// 这个是决定是否接收response
// 要获取response，通过WKNavigationResponse对象获取
//在响应完成时，调用的方法。如果设置为不允许响应，web内容就不会传过来

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}
//接收到服务器跳转请求之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"已经接收到服务器跳转请求");
}

//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.backItem.enabled = webView.canGoBack;
    self.goItem.enabled = webView.canGoForward;
    NSLog(@"开始加载");
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"内容开始返回");
}
//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"title:%@",webView.title);
    self.backItem.enabled = webView.canGoBack;
    self.goItem.enabled = webView.canGoForward;
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面加载失败");
}

#pragma mark WKUIDelegate

//alert 警告框
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"调用alert提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"alert message:%@",message);
    
}

//confirm 确认框
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:@"调用confirm提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"confirm message:%@",message);
    
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"输入框" message:@"调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);//回传文字
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
}



-(void)dealloc{
    if (self.webView.navigationDelegate) {
        self.webView.navigationDelegate = nil;
    }
    if (self.webView.UIDelegate) {
        self.webView.UIDelegate = nil;
    }
}








@end
