//
//  SegMentVC1.m
//  SomeTrain
//
//  Created by listome on 2017/4/6.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "SegMentVC1.h"
#import "WJItemsControlView.h"
@interface SegMentVC1 ()<UIScrollViewDelegate,VFrameWorkDelegate>
{
    WJItemsControlView *_itemControlView;
    UITextField *personPricef1;
    UITextField *personPricef2;
    UILabel *leftLab;
    UILabel *rgZJ;//人工费总价label
    UITextView *tv;//其他项备注
    UITextField *tvf;
    UILabel *beizhu;
    UILabel *eg1;
    NSMutableArray *fA;
    UILabel *ee;//其他费用总计
    UITextField *moneyd1;
    UITextField *moneyd2;
    UITextField *money2;
    UITextField *money3;
    CGFloat m2;
    CGFloat m3;
    VFrameWork *vf2;
    VFrameWork *vf3;
}
@property(nonatomic,strong)UIScrollView *scroll;

@end

@implementation SegMentVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    fA = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    NSArray *array = @[@"①零件费用",@"②人工费",@"③差旅费",@"④其他"];
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-110)];
    scroll.delegate = self;
    
    self.scroll = scroll;
    scroll.userInteractionEnabled = YES;
    scroll.pagingEnabled = YES;
    scroll.backgroundColor = JYColor(242,242,242);
    self.automaticallyAdjustsScrollViewInsets = NO;
    scroll.showsHorizontalScrollIndicator= NO;
    scroll.contentSize = CGSizeMake(kScreenWidth*array.count, 110);
    [self.view addSubview:scroll];
//    NSArray *afa = @[@"人        数:",@"费        用:"];
//    NSArray *scanfPHodle = @[@"输入人数",@"输入人工费"];
    
    
    UIImageView *iii = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*4, kScreenHeight-110)];
    iii.userInteractionEnabled = YES;
    iii.image = [UIImage imageNamed:@"111.jpg"];
    [scroll addSubview:iii];
    
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth,kScreenHeight-110)];
    [iii addSubview:v1];
    
    vf2 = [[VFrameWork alloc]initWithFrame:CGRectMake(kScreenWidth, 44, kScreenWidth,kScreenHeight-110) LeftStr:@"费        用:" HoldStr:@"输入人工费"  ZJStrLeft:@"人工费总计:" WithTag:2];
    vf2.delegate = self;
    [iii addSubview:vf2];


    vf3 = [[VFrameWork alloc]initWithFrame:CGRectMake(kScreenWidth*2, 44, kScreenWidth,kScreenHeight-110) LeftStr:@"费        用:" HoldStr:@"输入差旅费" ZJStrLeft:@"差旅费总计:" WithTag:3];
    vf3.delegate = self;
    [iii addSubview:vf3];
    
    UIView *v4 =[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*3, 44, kScreenWidth,kScreenHeight-110)];
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textViewAct)];
    [v4 addGestureRecognizer:viewTap];
//    NSArray *aiyo = @[@"内        容:",@"单        价:",@"数        量:"];
//    NSArray *qq = @[@"输入费用内容",@"输入单价(单位:元)",@"输入数量"];
    NSArray *aiyo = @[@"内        容:",@"费        用:"];
    NSArray *qq = @[@"输入费用内容",@"输入价格(单位:元)"];
    for (int i=0; i<2; i++) {
        beizhu = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-130, 125+50*i, 75, 35)];
        beizhu.textColor = [UIColor blackColor];
        beizhu.text = aiyo[i];
        beizhu.textAlignment = NSTextAlignmentRight;
        [v4 addSubview:beizhu];
        tvf = [[UITextField alloc]initWithFrame:CGRectMake(beizhu.right+5,125+50*i, 170, 35)];
        tvf.placeholder = qq[i];
        
        [fA addObject:tvf];
        tvf.clearButtonMode = UITextFieldViewModeAlways;
        if (i==1) {
            tvf.keyboardType =UIKeyboardTypeDecimalPad;
        }
//        else if (i==2){
//            tvf.keyboardType =UIKeyboardTypeDecimalPad;
//        }
        UIView *vv= [[UIView alloc]initWithFrame:CGRectMake(0, 35-3, tvf.width, 0.5)];
        vv.backgroundColor = [UIColor blackColor];
        [tvf addSubview:vv];
        tvf.font = [UIFont systemFontOfSize:14];
//        tvf.borderStyle = UITextBorderStyleNone;
        [v4 addSubview:tvf];

    }
    

    
    UIButton *otherSure = [UIButton buttonWithType:UIButtonTypeCustom];
    otherSure.frame =CGRectMake(tvf.right-55, 225, 55, 31);
    otherSure.backgroundColor = JYColor(236,34,28);
    otherSure.layer.cornerRadius = 4;
    otherSure.layer.masksToBounds = YES;
    //    surePersPrize.titleLabel.font = [UIFont systemFontOfSize:14];
    [otherSure setTitle:@"确定" forState:UIControlStateNormal];
    [otherSure addTarget:self action:@selector(otherSureAct) forControlEvents:UIControlEventTouchUpInside];
    [v4 addSubview:otherSure];
    
    
    ee = [[UILabel alloc]initWithFrame:CGRectMake(0, 231+120, kScreenWidth, 35)];
    ee.textColor = [UIColor blackColor];
    //    rgZJ.text = [NSString stringWithFormat:@"%@  %.2f元",self.zjStr,/* 从后台取的数据 */];
    ee.text =[NSString stringWithFormat:@"其他费用总计    0.00元"];
    //    @"人工费总计:  0.00元";
    ee.textAlignment = NSTextAlignmentCenter;
    [v4 addSubview:ee];
    [iii addSubview:v4];

    

    
    //头部控制的segMent
    WJItemsConfig *config = [[WJItemsConfig alloc]init];
    config.itemWidth = kScreenWidth/4.0;
    _itemControlView = [[WJItemsControlView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    _itemControlView.tapAnimation = YES;
    _itemControlView.backgroundColor = [UIColor whiteColor];
    _itemControlView.alpha = 0.6;
    _itemControlView.config = config;
    _itemControlView.titleArray = array;
    __weak typeof (scroll)weakScrollView = scroll;
    [_itemControlView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        
        
        [weakScrollView scrollRectToVisible:CGRectMake(index*weakScrollView.frame.size.width, 0.0, weakScrollView.frame.size.width,weakScrollView.frame.size.height) animated:animation];
        
    }];
    [self.view addSubview:_itemControlView];
    UIButton *fhhjk = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [fhhjk addTarget:self action:@selector(allF) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:fhhjk];
    
    
}
-(void)allF{
    if (vf2) {
        [vf2.f2 resignFirstResponder];
    }
    if (vf3) {
        [vf3.f2 resignFirstResponder];
    }
    for (UITextField *scc in fA) {
        [scc resignFirstResponder];
    }
    moneyd1 = fA[0];
    moneyd2 = fA[1];
    NSLog(@"2:%.2f\n3:%.2f\n4:%@%@",m2,m3,moneyd1.text,moneyd2.text);
}
-(void)fdata:(CGFloat)money WithTag:(NSInteger)tag{
    
    if (tag == 2) {
        money2.text =[NSString stringWithFormat:@"%.2f",money];
        NSLog(@"传回来的mongey:%.2f",money);
//        [money stringValue];
        m2 = money;
    }else if (tag ==3){
//        money3.text =[NSString stringWithFormat:@"%.2f",money];
        m3 = money;
    }
}
-(void)textViewAct{
//    [tvf resignFirstResponder];
    for (UITextField *scc in fA) {
        [scc resignFirstResponder];
    }
    moneyd1 = fA[0];
    moneyd2 = fA[1];
    
}
-(void)otherSureAct{
//    [tvf resignFirstResponder];
    for (UITextField *scc in fA) {
        [scc resignFirstResponder];
    }
    moneyd1 = fA[0];
    moneyd2 = fA[1];
    NSLog(@"内容%@,费用%.2f",moneyd1.text,[moneyd2.text floatValue]);
    ee.text =[NSString stringWithFormat:@"其他费用总计    %.2f元",[moneyd2.text floatValue]];
}
-(void)textViewListen{
    if (tv.text.length>0) {
        eg1.hidden=YES;
    }else{
        eg1.hidden = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [_itemControlView moveToIndex:offset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [_itemControlView endMoveToIndex:offset];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

@interface VFrameWork ()<UITextFieldDelegate>

@end

@implementation VFrameWork

-(instancetype)initWithFrame:(CGRect)frame LeftStr:(NSString *)leftstr HoldStr:(NSString *)holdstr ZJStrLeft:(NSString *)zjStr WithTag:(NSInteger)vtag{
    
    self = [super init];
    if (self) {
        
        self.frame = frame;
//        self.image = [UIImage imageNamed:@"hhhh.jpg"];
//        self.leftArr = leftArr;
//        self.holdArr = holdArr;
        self.leftstr = leftstr;
        self.holdstr = holdstr;
        self.zjStr = zjStr;
        self.tag = vtag;
        [self scroUI];
            }
    return self;
}

-(void)scroUI{
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resAction)];
    [self addGestureRecognizer:viewTap];
//    for (int i=0; i<2; i++) {//150+70 130  135
//        self.lefLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-130, 100+50*i, 75, 35)];
//        self.lefLab.text = self.leftstr;
//        self.lefLab.textAlignment = NSTextAlignmentRight;
//        self.lefLab.textColor = [UIColor blackColor];
//        [self addSubview:self.lefLab];
//    }
    self.lefLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-130, 150, 75, 35)];
    self.lefLab.text = self.leftstr;
    self.lefLab.textAlignment = NSTextAlignmentRight;
    self.lefLab.textColor = [UIColor blackColor];
    [self addSubview:self.lefLab];
//    f1 = [[UITextField alloc]initWithFrame:CGRectMake(self.lefLab.right+5, 100, 150, 35)];
//    f1.font = [UIFont systemFontOfSize:14];
//    f1.placeholder = self.holdArr[0];
//    UIView *vv1= [[UIView alloc]initWithFrame:CGRectMake(0, 35-3, f1.width, 0.5)];
//    vv1.backgroundColor = [UIColor blackColor];
//    [f1 addSubview:vv1];
//    f1.clearButtonMode = UITextFieldViewModeNever;
//    f1.keyboardType =UIKeyboardTypeNumberPad;
////    f1.borderStyle = UITextBorderStyleRoundedRect;
//    [self addSubview:f1];
//    UILabel *ren = [[UILabel alloc]initWithFrame:CGRectMake(f1.right+3, 100, 20, 35)];
//    ren.textColor = [UIColor whiteColor];
//    ren.text=@"人";
//    [self addSubview:ren];
    
    self.f2 = [[UITextField alloc]initWithFrame:CGRectMake(self.lefLab.right+5, 150, 150, 35)];
    self.f2.font = [UIFont systemFontOfSize:14];
    self.f2.placeholder = self.holdstr;
    self.f2.delegate = self;
    UIView *vv2= [[UIView alloc]initWithFrame:CGRectMake(0, 35-3, self.f2.width, 0.5)];
    vv2.backgroundColor = [UIColor blackColor];
    [self.f2 addSubview:vv2];
    self.f2.clearButtonMode = UITextFieldViewModeAlways;
    self.f2.keyboardType = UIKeyboardTypeDecimalPad;
//    f2.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.f2];
    UILabel *danwei = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 35)];
    danwei.text = @"元";
    danwei.backgroundColor = [UIColor redColor];
    self.f2.rightView = danwei;
    UILabel *yuan = [[UILabel alloc]initWithFrame:CGRectMake(self.f2.right+3, 150, 20, 35)];
    yuan.textColor = [UIColor blackColor];
    
    yuan.text=@"元";
    [self addSubview:yuan];
    
    scrSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scrSureBtn.frame =CGRectMake(self.f2.right-55, 200, 55, 31);
    scrSureBtn.backgroundColor = JYColor(236,34,28);
    scrSureBtn.layer.cornerRadius = 4;
    scrSureBtn.layer.masksToBounds = YES;
    //    surePersPrize.titleLabel.font = [UIFont systemFontOfSize:14];
    [scrSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [scrSureBtn addTarget:self action:@selector(scrSureAct) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scrSureBtn];
    
    danXZJ= [[UILabel alloc]initWithFrame:CGRectMake(0, scrSureBtn.bottom+120, kScreenWidth, 35)];
    danXZJ.textColor = [UIColor blackColor];
    //    rgZJ.text = [NSString stringWithFormat:@"%@  %.2f元",self.zjStr,/* 从后台取的数据 */];
    danXZJ.text =[NSString stringWithFormat:@"%@    0.00元",self.zjStr];
//    @"人工费总计:  0.00元";
    danXZJ.textAlignment = NSTextAlignmentCenter;
    [self addSubview:danXZJ];

}

-(void)scrSureAct{
    //    NSLog(@"人工费确定");

//        [f1 endEditing:YES];
        [self.f2 endEditing:YES];
//        scrZJ = [f1.text intValue]*[f2.text floatValue];
        
        danXZJ.text =[NSString stringWithFormat:@"%@  %.2f元",self.zjStr,[self.f2.text floatValue]];
        [self.delegate fdata:[self.f2.text floatValue] WithTag:self.tag];

    
}
-(void)resAction{
    
//    if (f1) {
//        [f1 endEditing:YES];
//    }
    if (self.f2) {
        [self.f2 endEditing:YES];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (f1) {
//        [f1 endEditing:YES];
//    }
    if (self.f2) {
        [self.f2 endEditing:YES];
    }
    [self.delegate fdata:[self.f2.text floatValue] WithTag:self.tag];
}
@end






