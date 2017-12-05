//
//  VerificationVC.m
//  SomeTrain
//
//  Created by listome on 2017/6/5.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "VerificationVC.h"

@interface VerificationVC ()

{
    UITextField *field;
}
@end
//
@implementation VerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    field = [[UITextField alloc]initWithFrame:CGRectMake(70, 140, kScreenWidth-140, 35)];
    field.borderStyle = UITextBorderStyleLine;
    field.clearButtonMode = UITextFieldViewModeAlways;
    UIButton *fo = [UIButton buttonWithType:UIButtonTypeCustom];
    fo.frame = CGRectMake(field.right-70, field.bottom+30, 60, 33);
    [fo setTitle:@"手机" forState:UIControlStateNormal];
    [fo addTarget:self action:@selector(VerificationAct1) forControlEvents:UIControlEventTouchUpInside];
    fo.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:field];
    [self.view addSubview:fo];
    
    UIButton *fo1 = [UIButton buttonWithType:UIButtonTypeCustom];
    fo1.frame = CGRectMake(field.right-70, fo.bottom+30, 60, 33);
    [fo1 setTitle:@"邮箱" forState:UIControlStateNormal];
    [fo1 addTarget:self action:@selector(VerificationAct2) forControlEvents:UIControlEventTouchUpInside];
    fo1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:fo1];
    UIButton *fo2 = [UIButton buttonWithType:UIButtonTypeCustom];
    fo2.frame = CGRectMake(field.right-70, fo1.bottom+30, 60, 33);
    [fo2 setTitle:@"身份证" forState:UIControlStateNormal];
    [fo2 addTarget:self action:@selector(VerificationAct3) forControlEvents:UIControlEventTouchUpInside];
    fo2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:fo2];
    // Do any additional setup after loading the view.
}

-(void)VerificationAct1{
    [self checkTel:field.text];

}
-(void)VerificationAct2{
    
    [self validateEmail:field.text];
    
}
-(void)VerificationAct3{

    [self checkIdentityCardNo:field.text];
}
//电话号码
- (BOOL)checkTel:(NSString *)mobileNumbel

{
    /**
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    
    
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        NSLog(@"手机号验证可用");
        return YES;
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    return NO;
    
    
}

-(BOOL)validateEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if( [emailTest evaluateWithObject:email]){
        
        NSLog(@"恭喜！您输入的邮箱验证合法");
        return YES;
        
    }else{
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的邮箱" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
    }
    return NO;
    
}

- (BOOL)checkIdentityCardNo:(NSString*)cardNo

{
    
    if (cardNo.length != 18) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起!身份证的位数不够或过多" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return  NO;
        
    }
    
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    
    
    int val;
    
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    
    if (!isNum) {
        NSLog(@"输入的身份证号码不对");
        return NO;
    }
    
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
        
    }
    
    
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        NSLog(@"验证身份证号码可用");
        return YES;
        
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"身份证号码错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    return  NO;
    
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
