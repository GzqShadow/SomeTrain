//
//  UMObj.h
//  SomeTrain
//
//  Created by listome on 2017/7/20.
//  Copyright © 2017年 listome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMObj : NSObject
+ (instancetype )shared;
#pragma mark Login

/**
 人人登录
 */
- (void)getAuthWithUserInfoFromRenren;


/**
 豆瓣登录
 */
- (void)getAuthWithUserInfoFromDouban;

/**
 腾讯微博登录
 */
- (void)getAuthWithUserInfoFromTencentWeibo;


/**
 Twitter登录
 */
- (void)getAuthWithUserInfoFromTwitter;

/**
 Facebook登录
 */
- (void)getAuthWithUserInfoFromFacebook;


/**
 Linkedin(领英)登录
 */
- (void)getAuthWithUserInfoFromLinkedin;

/**
 新浪微博登录
 */
- (void)getAuthWithUserInfoFromSina;


/**
 qq登录
 */
- (void)getAuthWithUserInfoFromQQ;

/**
 微信登录
 */
- (void)getAuthWithUserInfoFromWechat;

#pragma mark Share
/**
 分享文本
 */
-(void)shareText:(NSString *)str WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC;

/**
 分享图片
 */
-(void)shareImg:(NSString *)imgStr WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC;
/**
 分享图文
 */
-(void)shareImg:(NSString *)imgStr AndText:(NSString *)str WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC;

/**
 分享网页
 */
-(void)shareUrl:(NSString *)urlstr withTitle:(NSString*)title WithDescr:(NSString *)descr WithImgStr:(NSString*)imgName WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC;
/**
 分享音乐
 */
-(void)shareMusicUrl:(NSString*)MusicUrl withTitle:(NSString*)title WithDescr:(NSString *)descr WithImgStr:(NSString*)imgName WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC;
/**
 分享视频
 */
-(void)shareVideoUrl:(NSString*)videoUrl withTitle:(NSString*)title WithDescr:(NSString *)descr WithImgStr:(NSString*)imgName WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC;
@end
