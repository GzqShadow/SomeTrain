//
//  TheNSURLCacheVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/27.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "TheNSURLCacheVC.h"

@interface TheNSURLCacheVC ()

@end

@implementation TheNSURLCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //获得全局缓存对象
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache setMemoryCapacity:73463786];//设置内存缓存的最大容量
    [cache setDiskCapacity:479]; //设置内存缓存的最大容量
    [cache removeCachedResponseForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];//取得某个请求的缓存
    [cache removeCachedResponseForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];//清楚某个请求的缓存
    [cache removeAllCachedResponses];//清楚所有的缓存
    
    //对某个get请求进行数据缓存
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    /*
     iOS对NSURLRequest提供了7种缓存策略：（实际上能用的只有3种）
     
     NSURLRequestUseProtocolCachePolicy  默认的缓存策略（取决于协议）
     
     NSURLRequestReloadIgnoringLocalCacheData  忽略缓存，重新请求
     
     NSURLRequestReloadIgnoringLocalAndRemoteCacheData  未实现
     
     NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData  忽略缓存，重新请求
     
     NSURLRequestReturnCacheDataElseLoad
     有缓存就用缓存，没有缓存就重新请求
     
     NSURLRequestReturnCacheDataDontLoad
     
     有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
     
     
     
     NSURLRequestReloadRevalidatingCacheData  未实现
     */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end






















