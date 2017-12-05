//
//  UMObj.m
//  SomeTrain
//
//  Created by listome on 2017/7/20.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "UMObj.h"
#import <UShareUI/UShareUI.h>
@implementation UMObj
+ (instancetype )shared{
    static UMObj *someViews = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        someViews = [[UMObj alloc] init];
        
    });
    
    return someViews;
}


- (void)getAuthWithUserInfoFromRenren
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Renren currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Renren uid: %@", resp.uid);
            NSLog(@"Renren accessToken: %@", resp.accessToken);
            NSLog(@"Renren expiration: %@", resp.expiration);
            
            // 第三方平台SDK源数据
            NSLog(@"Renren originalResponse: %@", resp.originalResponse);
        }
    }];
}


-(void)getAuthWithUserInfoFromDouban{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Douban currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Douban uid: %@", resp.uid);
            NSLog(@"Douban accessToken: %@", resp.accessToken);
            NSLog(@"Douban expiration: %@", resp.expiration);
            
            // 第三方平台SDK源数据
            NSLog(@"Douban originalResponse: %@", resp.originalResponse);
        }
    }];
}


-(void)getAuthWithUserInfoFromTencentWeibo{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_TencentWb currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"TencentWeibo uid: %@", resp.uid);
            NSLog(@"TencentWeibo accessToken: %@", resp.accessToken);
            NSLog(@"TencentWeibo expiration: %@", resp.expiration);
            
            // 第三方平台SDK源数据
            NSLog(@"TencentWeibo originalResponse: %@", resp.originalResponse);
        }
    }];
}


-(void)getAuthWithUserInfoFromTwitter{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Twitter currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Twitter uid: %@", resp.uid);
            NSLog(@"Twitter accessToken: %@", resp.accessToken);
            
            // 用户信息
            NSLog(@"Twitter name: %@", resp.name);
            NSLog(@"Twitter iconurl: %@", resp.iconurl);
            
            // 第三方平台SDK源数据
            NSLog(@"Twitter originalResponse: %@", resp.originalResponse);
        }
    }];
}

-(void)getAuthWithUserInfoFromFacebook{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Facebook currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Facebook uid: %@", resp.uid);
            NSLog(@"Facebook accessToken: %@", resp.accessToken);
            NSLog(@"Facebook expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Facebook name: %@", resp.name);
            
            // 第三方平台SDK源数据
            NSLog(@"Facebook originalResponse: %@", resp.originalResponse);
        }
    }];
}


-(void)getAuthWithUserInfoFromLinkedin{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Linkedin currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Linkedin uid: %@", resp.uid);
            NSLog(@"Linkedin accessToken: %@", resp.accessToken);
            NSLog(@"Linkedin expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Linkedin name: %@", resp.name);
            
            // 第三方平台SDK源数据
            NSLog(@"Linkedin originalResponse: %@", resp.originalResponse);
        }
    }];
}

-(void)getAuthWithUserInfoFromSina{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
        }
    }];
}


-(void)getAuthWithUserInfoFromQQ{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}


//微信登录
-(void)getAuthWithUserInfoFromWechat{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}


//分享文本
-(void)shareText:(NSString *)str WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC{
    
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = str;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:VC completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

//分享图片
-(void)shareImg:(NSString *)imgStr WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC{


    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:imgStr];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

//分享图文
-(void)shareImg:(NSString *)imgStr AndText:(NSString *)str WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = str;
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:imgStr];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

//分享网页
-(void)shareUrl:(NSString *)urlstr withTitle:(NSString*)title WithDescr:(NSString *)descr WithImgStr:(NSString*)imgName WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:[UIImage imageNamed:imgName]];
    //设置网页地址
    shareObject.webpageUrl =urlstr;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

//分享音乐
-(void)shareMusicUrl:(NSString*)MusicUrl withTitle:(NSString*)title WithDescr:(NSString *)descr WithImgStr:(NSString*)imgName WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
//    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:descr thumImage:[UIImage imageNamed:imgName]];
    //设置音乐网页播放地址
//    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    shareObject.musicUrl = MusicUrl;
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


//分享视频
-(void)shareVideoUrl:(NSString*)videoUrl withTitle:(NSString*)title WithDescr:(NSString *)descr WithImgStr:(NSString*)imgName WithType:(UMSocialPlatformType)platformType WithVC:(UIViewController *)VC{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:descr thumImage:[UIImage imageNamed:imgName]];
    //设置视频网页播放地址
    shareObject.videoUrl = videoUrl;
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


@end










