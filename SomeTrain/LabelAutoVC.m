//
//  LabelAutoVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/14.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "LabelAutoVC.h"

@interface LabelAutoVC ()

{
    NSString * str;
    UILabel * label;
    CGFloat labelW;
}
@property (nonatomic,copy) NSString * name1;
@property (nonatomic,strong) NSString * name2;
@end

@implementation LabelAutoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableString * string = [NSMutableString stringWithFormat:@"11111"];
    string = @"aaa";
    string = [NSMutableString stringWithFormat:@"ABC"];
    self.name1 = string;
    self.name2 = string;
    NSLog(@"string=%p,%@",string,string);
    NSLog(@"A1=%p，%@\n",self.name1,self.name1);
    NSLog(@"B1=%p，%@\n",self.name2,self.name2);
//    string = [NSMutableString stringWithFormat:@"ABC"];
//    NSLog(@"string=%p,%@",string,string);
//    NSLog(@"A2=%p，%@\n",self.name1,self.name1);
//    NSLog(@"B2=%p，%@\n",self.name2,self.name2);
    
//    NSMutableArray * muArr = [[NSMutableArray alloc]init];
//    [muArr arrayByAddingObject:@"sssssss"];
//    NSMutableArray * arr = [muArr copy];
//    NSArray * mArr = [muArr mutableCopy];
//    NSLog(@"arr=%@,mArr=%@",arr,mArr);
    
    NSMutableArray * numberArray = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,nil];;
    for (int i = 0; i < numberArray.count; i++) {
        for (int j = 0; j < numberArray.count - 1; j++) {
            if (numberArray[i]<numberArray[j]) {
                [numberArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
        NSLog(@"哈哈 = %@",numberArray);
    }
    //根据文本长度计算label的宽高
    self.view.backgroundColor = [UIColor whiteColor];
    labelW=110;//tempRect和label的宽度要相同
    str=@"天将降大任于斯人也,必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行夫乱其所为。\n天将降大任于斯人也,必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行夫乱其所为。天将降大任于斯人也,必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行夫乱其所为。天将降大任于斯人也,必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行夫乱其所为。\n";
//    [self one];
    label = [[UILabel alloc]init];

    label.backgroundColor =[UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = str;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines =0;
//    [self.view addSubview:label];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth-20-100,44 )];
    textView.backgroundColor = [UIColor redColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor yellowColor];
//    [self.view addSubview:textView];
    
//    [self one];
//    [self two];
//    [self three]
    [self four];
    
}
-(void)one{
    
    CGRect tempRect = [str boundingRectWithSize:CGSizeMake(labelW,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}context:nil];
    
    label.frame =CGRectMake(10,100, labelW, tempRect.size.height);
 
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(10, label.height+label.origin.y+10,200,200)];
    image.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:image];
}

-(void)two{
    CGSize maximumLabelSize = CGSizeMake(labelW, 9999);
    //labelsize的最大值
    //关键语句
    CGSize expectSize = [label sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    label.frame = CGRectMake(20, 80, expectSize.width, expectSize.height);

}

-(void)three{
    CGSize size = CGSizeMake(labelW,2000);
    CGSize labelsize = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];//该方法以已经弃用  现在用第一种的

    label.frame =CGRectMake(0,0, label.width, label.height);
}

-(void)four{
    UILabel *smLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 80, labelW, 0)];
    smLab.numberOfLines =0;
    smLab.font = [UIFont systemFontOfSize:14];
    smLab.lineBreakMode = NSLineBreakByTruncatingTail;
    smLab.textColor = [UIColor blackColor];
    smLab.backgroundColor = [UIColor lightGrayColor];
    smLab.text=str;
    [smLab sizeToFit];
    [self.view addSubview:smLab];
    
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
