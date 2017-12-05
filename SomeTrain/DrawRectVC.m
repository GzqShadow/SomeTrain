//
//  DrawRectVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/17.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "DrawRectVC.h"
#import "DrawView.h"
@interface DrawRectVC ()

@end

@implementation DrawRectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DrawView *dv = [[DrawView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight-150)];
    
   
    [self.view addSubview:dv];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
