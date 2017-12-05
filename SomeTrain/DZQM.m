//
//  DZQM.m
//  SomeTrain
//
//  Created by listome on 2017/7/18.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "DZQM.h"
#import "SignViewController.h"
@interface DZQM ()
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation DZQM

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(kScreenWidth/2-50, 70, 100, 40);
    [self.btn setTitle:@"电子签名" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 150, self.view.width-50, 200)];
    self.imgView = imgView;
    self.imgView.layer.borderColor = [UIColor redColor].CGColor;
    self.imgView.layer.borderWidth = 1.0;
    [self.view addSubview:imgView];
    // Do any additional setup after loading the view.
}

-(void)btnAction{
    //跳转只能用present的方式
    SignViewController *signVC = [[SignViewController alloc] init];
    signVC.signLineColor = [UIColor blueColor];
    [self presentViewController:signVC animated:YES completion:nil];
    [signVC signResultWithBlock:^(UIImage *signImage) {
        self.imgView.image = signImage;
    }];
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
