//
//  DrawView.m
//  SomeTrain
//
//  Created by listome on 2017/4/17.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self setNeedsDisplay];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
//    [self drawLine];/*画线*/
//    [self drawARect];/*矩形*/
//    [self drawCircle];/*画圆*/
//    [self drawArc];//
//    [self drawText];/*文字*/
    [self drawBeize];//贝塞尔曲线  也是圆
    // Drawing code.
    //获得处理的上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //设置线条样式
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    //设置线条粗细宽度
//    CGContextSetLineWidth(context, 1.0);
//    
//    //设置颜色
//    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
//    //开始一个起始路径
//    CGContextBeginPath(context);
//    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
//    CGContextMoveToPoint(context, 0, 0);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, 100, 100);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, 0, 150);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, 50, 180);
//    //连接上面定义的坐标点
//    CGContextStrokePath(context);
}

#pragma mark - 画线
-(void)drawLine{
    //第一步:获取上下文
    //CGContextRef 用来保存图形信息.输出目标
    CGContextRef context = UIGraphicsGetCurrentContext();
    //第二步:画图形
    //设置线的颜色
    CGContextSetRGBStrokeColor(context, 255/255.0, 255/255.0, 255/255.0, 1);
    //设置线的宽度
    CGContextSetLineWidth(context, 13);
    //设置连接点得样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //设置线头尾的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //起点
    CGContextMoveToPoint(context, 10, 20);
    //画线
    CGContextAddLineToPoint(context, 100, 100);
    
    CGContextAddLineToPoint(context, 100, 150);
    
    //第三步:渲染到视图上
    CGContextStrokePath(context);
    
}


- (void)drawARect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 110, 10);
    CGContextAddLineToPoint(context, 110, 110);
    CGContextAddLineToPoint(context, 10, 110);
    CGContextAddLineToPoint(context, 10, 10);
    
    
    //第二种
    CGContextAddRect(context, CGRectMake(0, 0, 100, 100));
    CGContextStrokePath(context);
    //填充
    //    CGContextFillPath(context);
    
    //只画线
    CGContextStrokePath(context);
    
}
//画圆
- (void)drawCircle{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 100, 100));
    
    
    
    CGContextStrokePath(context);
    
    
}

- (void)drawArc{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  <#Description#>
     *
     *  @param c#>          上下文 description#>
     *  @param x#>          圆点x坐标 description#>
     *  @param y#>          圆点y坐标 description#>
     *  @param radius#>     半径 description#>
     *  @param startAngle#> 开始角度 description#>
     *  @param endAngle#>   结束角度 description#>
     *  @param clockwise#>  是否顺时针 description#>
     */
    
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddArc(context, 100, 100, 60, 0, M_PI_4, 0);
    //闭合
    CGContextClosePath(context);
    
    CGContextStrokePath(context);
    
}


- (void)drawText{
    NSString *string = @"SDFDFWDF:FEEFF:DFWFEFW";
    [string drawAtPoint:CGPointMake(100, 100) withAttributes:nil];
    
    [string drawInRect:CGRectMake(0, 0, 100, 100) withAttributes:nil];
    
    
    
}

- (void)drawBeize{
    //贝塞尔曲线  宽高各100 内径大小
    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:60 startAngle:0 endAngle:3.14*2 clockwise:YES];
    UIColor *color = [UIColor orangeColor];
    [color setFill];
    
    [bezier setLineWidth:20];
    [bezier fill];
    
}


@end
