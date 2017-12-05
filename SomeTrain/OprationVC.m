//
//  OprationVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/26.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "OprationVC.h"

@implementation OprationVC
/*
 使用NSOperation子类的方式有3种
 
 1.NSInvocationOperation
 
 2.NSBlockOperation
 
 3.自定义子类继承NSOperation，实现内部相应的方法
 */
//自定义NSOperation
//
//如何封装操作？
//
//自定义的NSOperation,通过重写内部的main方法实现封装操作

-(void)main

{
    
    NSLog(@"--main--%@",[NSThread currentThread]);
    
}
@end
