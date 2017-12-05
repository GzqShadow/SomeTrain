//
//  BlockVC.m
//  SomeTrain
//
//  Created by listome on 2016/11/24.
//  Copyright © 2016年 listome. All rights reserved.
//

#import "BlockVC.h"
#import "HuiDiao.h"
@interface BlockVC ()

@end

@implementation BlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.view.userInteractionEnabled=YES;
    UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
    b.frame=CGRectMake(100, 100, 100, 100);
    b.backgroundColor=[UIColor redColor];
    [b addTarget:self action:@selector(act) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:b];
    [self noCanNOReturn];
    [self haveCanNoReturn];
    [self haveCanHaveReturn];
    
}
//无参无返回值的block
-(void)noCanNOReturn{
    /**
     *  void ：就是无返回值
     *  emptyBlock：就是该block的名字
     *  ()：这里相当于放参数。由于这里是无参数，所以就什么都不写
     */
    void (^myBlock)()=^(){
        
    };
    myBlock();
    
    void (^the)()=^(){
        
    };
    the();
    
    void (^wcwf)()=^(){};
    wcwf();
    
    void (^block1)()=^(){}; block1();
    void (^block2)()=^(){}; block2();
    
    void (^emptyBlock)() = ^(){
        NSLog(@"无参数,无返回值的Block");
    };
    emptyBlock();
}

-(void)haveCanNoReturn{
    /**
     *  调用这个block进行两个参数相加
     *
     *  @pragma int 参数A
     *  @pragma int 参数B
     *
     *  @return 无返回值
     */
    void (^sumBlock)(int ,int ) = ^(int a,int b){
        NSLog(@"%d + %d = %d",a,b,a+b);
    };
    /**
     *  调用这个sumBlock的Block，得到的结果是20
     */
    sumBlock(10,10);
    
    void (^hcwf)(CGFloat,CGFloat)=^(CGFloat x,CGFloat y){
        NSLog(@"%f + %f = %f",x,y,x+y);
    };
    hcwf(2,4);
    
    void (^hcwf2)(NSInteger,NSInteger)=^(NSInteger m,NSInteger n){
        NSLog(@"m-n=%ld",m-n);
    };
    hcwf2(4,2);
    
}

-(void)haveCanHaveReturn{
    /**
     *  有参数有返回值
     *
     *  param NSString 字符串1
     *  param NSString 字符串2
     *
     *  return 返回拼接好的字符串3
     */
    NSString* (^logBlock)(NSString *,NSString *) = ^(NSString * str1,NSString *str2){
        return [NSString stringWithFormat:@"%@%@",str1,str2];
    };
    //调用logBlock,输出的是 我是Block
    NSLog(@"%@", logBlock(@"我是",@"Block"));
    
    NSString *a=@"nnnn";
    a=@"vvv";
    NSString *(^hchr)(NSString *,NSString *) = ^(NSString *a,NSString *b){
        return [NSString stringWithFormat:@"%@,%@",a,b];
    };
    
    NSLog(@"%@",hchr(a,@"王"));
    CGFloat q=1;
    
    CGFloat (^hchr2)(CGFloat ,CGFloat)=^(CGFloat x,CGFloat y){
        return x+y;
    };
    NSLog(@"---------%f",hchr2(q,4));
    
    __block int x = 5;//内部修改x的值
    int (^block4)(int) = ^(int y) {
        int z = x + y;
        return z;
    };
    NSLog(@"打印：%d,%d",x +=5,block4(5));
    
}
-(void)act{
//    HuiDiao *vc =[[HuiDiao alloc]init];
//    // 回调修改颜色
//    vc.backgroundColor = ^(UIColor *color){
//        self.view.backgroundColor = color;
//    };
//    
//    [self.navigationController pushViewController:vc animated:YES];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.title=nil;
    self.view.backgroundColor=[UIColor whiteColor];
    
    HuiDiao *vc =[[HuiDiao alloc]init];
    // 回调修改颜色
    vc.backgroundColor = ^(UIColor *color){
        self.view.backgroundColor = color;
    };
    vc.tit=^(NSString *ti){
        self.title=ti;
    };
    vc.nichaun2=^(NSString *two){
        NSString *h=self.title;
        self.title=[NSString stringWithFormat:@"%@,%@",h,two];
    };
    vc.l =^(NSString *ll){
        NSString *h=ll;
        NSLog(@"%@",h);
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
