//
//  UMShareVC.m
//  SomeTrain
//
//  Created by listome on 2017/7/20.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "UMShareVC.h"
#import <UShareUI/UShareUI.h>
#import "UMObj.h"
@interface UMShareVC ()<UMSocialShareMenuViewDelegate>

@end

@implementation UMShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
 
    NSInteger width = self.view.bounds.size.width;
    //    NSInteger height = self.view.bounds.size.height;
    
    btn.frame = CGRectMake(width/2-100,300 , 200, 30);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"share" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    //    NSInteger width = self.view.bounds.size.width;
    //    NSInteger height = self.view.bounds.size.height;
    btnLogin.frame = CGRectMake(width/2-100,400 , 200, 30);
    btnLogin.backgroundColor = [UIColor blueColor];
    [btnLogin setTitle:@"其他方式登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    // Do any additional setup after loading the view.
}
//不需要改变父窗口则不需要重写此协议
//-(UIView *)UMSocialParentView:(UIView *)defaultSuperView{
//    return defaultSuperView;
//}

-(void)shareAction{
    //设置分享面板的代理，从而监控其显示和隐藏的状态
//    [UMSocialUIManager setShareMenuViewDelegate:self];
    
    //1.自定义分享面板预定义平台(顺序)
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//    }];
    
    
    //2.配置上面需求的参数
//    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
//    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Middle;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForPortraitAndMid = 2;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndMid = 3;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndMid = 2;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndMid = 6;
//    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = NO;
    
  
    
    //2.shareScrollView背景色为红色
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewBackgroundColor = [UIColor redColor];
//    //每页的背景颜色为黄色
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageBGColor = [UIColor yellowColor];
//    //去掉毛玻璃效果
//    [UMSocialShareUIConfig shareInstance].shareContainerConfig.isShareContainerHaveGradient = NO;
    
    //4.自定义分享面板中的icon与事件
//    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+2
//                                     withPlatformIcon:[UIImage imageNamed:@"auth_icon"]
//                                     withPlatformName:@"copy"];
//    
//    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        //在回调里面获得点击的
//        if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
//            NSLog(@"do your operation for copy");
//        }
//        else{
////            [self runShareWithType:platformType];
//        }
//    }];
//    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [[UMObj shared]shareText:@"你说什么" WithType:platformType WithVC:self];
        
        
    }];
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    NSLog(@"点击了分享");
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}

-(void)loginAction{
    [[UMObj shared] getAuthWithUserInfoFromWechat];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
