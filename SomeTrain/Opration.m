//
//  Opration.m
//  SomeTrain
//
//  Created by listome on 2017/4/26.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "Opration.h"
#import "OprationVC.h"
@interface Opration ()

@end

@implementation Opration

- (void)viewDidLoad {
    [super viewDidLoad];
//    1.封装操作
//
//    第一个参数：目标对象
//    
//    第二个参数：该操作要调用的方法，最多接受一个参数
//    
//    第三个参数：调用方法传递的参数，如果方法不接受参数，那么该值传nil
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]
                                        
                                        initWithTarget:self selector:@selector(run) object:nil];
//    2.启动操作
    
    [operation1 start];
    
    
//    NSBlockOperation提供了一个类方法，在该类方法中封装操作
//    任务数量 > 1 才会异步执行
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
//        在主线程中执行
        
        NSLog(@"---download1--%@",[NSThread currentThread]);
        
    }];
    
//    2.追加操作，追加的操作在子线程中执行
    
    [operation addExecutionBlock:^{
        
        NSLog(@"---download2--%@",[NSThread currentThread]);
        
    }];
    
    
    
    [operation addExecutionBlock:^{
        
        NSLog(@"---download3--%@",[NSThread currentThread]);
        
    }];
    
    // Do any additional setup after loading the view.
}
//
-(void)zidingyi{
    
//    1.创建队列
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
//    实例化一个自定义操作对象 
    OprationVC *op = [[OprationVC alloc]init];
    [op start];//执行操作
    [queue addOperation:op];//添加操作到队列中
//    耗时操作1
    
    for (int i = 0; i<1000; i++) {
        
        NSLog(@"任务1-%d--%@",i,[NSThread currentThread]);
        
    }
    
    NSLog(@"+++++++++++++++++++++++++++++++++");
    
    
    
//    苹果官方建议，每当执行完一次耗时操作之后，就查看一下当前队列是否为取消状态，如果是，那么就直接退出
//    
//    好处是可以提高程序的性能
    
//    if (self.isCancelled) {
//        
//        return;
//        
//    }
    
    
    
//    耗时操作2
    
    for (int i = 0; i<1000; i++) {
        
        NSLog(@"任务1-%d--%@",i,[NSThread currentThread]);
        
    }
    
    
    
    NSLog(@"+++++++++++++++++++++++++++++++++");
    //NSOperation实现线程间通信
//    2.使用简便方法封装操作并添加到队列中
    
    [queue addOperationWithBlock:^{
        
        
        
//        3.在该block中下载图片
        
        NSURL *url = [NSURL URLWithString:@"http://news.51sheyuan.com/uploads/allimg/111001/133442IB-2.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
        
        NSLog(@"下载图片操作--%@",[NSThread currentThread]);
        
        
        
//        4.回到主线程刷新UI
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
//            self.imageView.image = image;
            
            NSLog(@"刷新UI操作---%@",[NSThread currentThread]);
            
        }];
        
    }];
    //（2）下载多张图片合成综合案例（设置操作依赖）
    [self downLoad2];
}

-(void)downLoad2{
    NSLog(@"----");
    
//    1.创建队列
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    
    
//    2.封装操作下载图片1
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        
        NSURL *url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/6a63f6246b600c3320b14bb3184c510fd8f9a185.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        
        
//        拿到图片数据
        
//        self.image1 = [UIImage imageWithData:data];
        
    }];
    
    
    
    
    
//    3.封装操作下载图片2
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:@"http://pic.58pic.com/58pic/13/87/82/27Q58PICYje_1024.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        
        
//        拿到图片数据
        
//        self.image2 = [UIImage imageWithData:data];
        
    }];
    
    
    
//    4.合成图片
    
    NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
        
        
        
//        4.1 开启图形上下文
        
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        
        
        
//        4.2 画image1
        
//        [self.image1 drawInRect:CGRectMake(0, 0, 200, 100)];
        
        
        
//        4.3 画image2
//        
//        [self.image2 drawInRect:CGRectMake(0, 100, 200, 100)];
        
        
        
//        4.4 根据图形上下文拿到图片数据
//        
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        
        
//        4.5 关闭图形上下文
        
        UIGraphicsEndImageContext();
        
        
        
//        7.回到主线程刷新UI
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
//            self.imageView.image = image;
            
            NSLog(@"刷新UI---%@",[NSThread currentThread]);
            
        }];
        
        
        
    }];
    
    
    
//    5.设置操作依赖
    
    [combine addDependency:op1];
    
    [combine addDependency:op2];
    
    
    
//    6.添加操作到队列中执行
    
    [queue addOperation:op1];
    
    [queue addOperation:op2];
    
    [queue addOperation:combine];
}

//NSBlockOperation

- (void)block

{
    
//    1.创建队列
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 2;//设置最大并发数
//    设置暂停和恢复
    
//    suspended设置为YES表示暂停，suspended设置为NO表示恢复
    
//    暂停表示不继续执行队列中的下一个任务，暂停操作是可以恢复的
    
    if (queue.isSuspended) {
        
        queue.suspended = NO;
        
    }else
        
    {
        
        queue.suspended = YES;
        
    }
    
//    取消队列里面的所有操作
//    
//    取消之后，当前正在执行的操作的下一个操作将不再执行，而且永远都不在执行，就像后面的所有任务都从队列里面移除了一样
//    
//    取消操作是不可以恢复的
    
    [queue cancelAllOperations];
    
    
//    2.封装操作
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"1----%@",[NSThread currentThread]);
        
    }];
    
    
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"2----%@",[NSThread currentThread]);
        
        
        
    }];
    
    
    
    [op1 addExecutionBlock:^{
        
        NSLog(@"3----%@",[NSThread currentThread]);
        
    }];
    
    
    
    [op2 addExecutionBlock:^{
        
        NSLog(@"4----%@",[NSThread currentThread]);
        
    }];
    
    
    
//    3.添加操作到队列中
    
    [queue addOperation:op1];
    
    [queue addOperation:op2];
    
    
    
//    补充：简便方法
    
    [queue addOperationWithBlock:^{
        
        NSLog(@"5----%@",[NSThread currentThread]);
        
    }];
    
    
    
}

//NSInvocationOperation

- (void)invocation

{
    
    
    
//    GCD中的队列：
//    
//    串行队列：自己创建的，主队列
//    
//    并发队列：自己创建的，全局并发队列
    
    
    
//    NSOperationQueue
    
//    主队列：[NSOperationQueue mainqueue];凡事放在主队列中的操作都在主线程中执行
    
//    非主队列：[[NSOperationQueue alloc]init]，并发和串行，默认是并发执行的
    
//    1.创建队列
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    
    
//    2.封装操作
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download1) object:nil];
    
    
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download2) object:nil];
    
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download3) object:nil];
    
    
    
//    3.把封装好的操作添加到队列中
    
    [queue addOperation:op1];// 底层会调用->[op1 start]
    
    [queue addOperation:op2];
    
    [queue addOperation:op3];
    
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
