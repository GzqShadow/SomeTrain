//
//  bezierPath.m
//  SomeTrain
//
//  Created by listome on 2017/3/28.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "bezierPath.h"
#import "beelineView.h"
#define JYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface bezierPath ()

@end

@implementation bezierPath

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self beeline];
    
    // 线的路径  第一个三角形  1️⃣
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(40, 100)];//第一个点
    [trianglePath addLineToPoint:CGPointMake(120, 100)];//第二个点
    [trianglePath addLineToPoint:CGPointMake(80, 120)];//第三个点
    // 封闭曲线
    [trianglePath closePath];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = trianglePath.CGPath;
    layer1.strokeColor = [UIColor purpleColor].CGColor;//笔画颜色
    layer1.fillColor = [UIColor purpleColor].CGColor;//填充色
    [self.view.layer addSublayer:layer1];
    
    
    // 线的路径   2️⃣
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(40, 150)];
    // 其它点
    [linePath addLineToPoint:CGPointMake(80, 200)];
    [linePath addLineToPoint:CGPointMake(110, 180)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = linePath.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = JYColor(20, 160, 93).CGColor;
    [self.view.layer addSublayer:layer];
    
    
    //矩形  3️⃣
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(150, 100, 100, 100)];
    CAShapeLayer *square = [CAShapeLayer layer];
    square.path = bezierPath.CGPath;
    
    square.strokeColor = [UIColor blueColor].CGColor;
    square.fillColor = JYColor(20, 160, 93).CGColor;
    [self.view.layer addSublayer:square];
    
    
    // 4️⃣
    UIBezierPath *patha = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(280, 100, 100, 100) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(20, 0)];
    CAShapeLayer *layera = [CAShapeLayer layer];
    layera.path = patha.CGPath;
    layera.lineWidth = 2.f;
    layera.strokeColor = [UIColor redColor].CGColor;
    layera.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:layera];
    
    
    // 初始化 画圆弧 5️⃣
    UIBezierPath *pathy = [UIBezierPath bezierPathWithArcCenter:CGPointMake(60, 220) radius:50.f startAngle:0 endAngle:M_PI_2 clockwise:YES];
    // 添加一条线
    [pathy addLineToPoint:CGPointMake(80, 320)];
    // 再画 1/4 圆弧
    [pathy addArcWithCenter:CGPointMake(80, 320) radius:50 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    CAShapeLayer *layery = [CAShapeLayer layer];
    layery.path = pathy.CGPath;
    layery.lineWidth = 2.f;
    layery.strokeColor = [UIColor redColor].CGColor;
    layery.fillColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:layery];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(280, 240, 100, 100)];
    contentView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:contentView];

    
    //  6️⃣
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds cornerRadius:20.f];
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(40, 40, 100, 100)
    //                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
    //                                                     cornerRadii:CGSizeMake(20, 0)];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = path.CGPath;
    layer2.strokeColor = [UIColor redColor].CGColor;
    contentView.layer.mask = layer2; // layer的mask属性，添加蒙版
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
