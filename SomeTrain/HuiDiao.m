//
//  HuiDiao.m
//  SomeTrain
//
//  Created by listome on 2016/11/25.
//  Copyright © 2016年 listome. All rights reserved.
//

#import "HuiDiao.h"

@interface HuiDiao ()

@end

@implementation HuiDiao

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled=YES;
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //防止循环引用，，所以在block 内部使用弱应用
    __weak typeof(self)weaksele = self ;
    if (self.backgroundColor) {
        //声明一个颜色
        UIColor *color = [UIColor redColor];
        //用刚刚声明的那个Block去回调修改上一界面的背景色
        weaksele.backgroundColor(color);
        NSString *t=@"你好";
        weaksele.tit(t);  //用刚刚声明的block去回调修改上一界面的title
        weaksele.nichaun2(t);
        weaksele.l(@"h");
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
