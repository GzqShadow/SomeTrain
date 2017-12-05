//
//  ThreadVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/26.
//  Copyright © 2017年 listome. All rights reserved.
//印象笔记 我的导入笔记 iOS笔记② 重点三

#import "ThreadVC.h"

@interface ThreadVC ()
{
    NSThread *thread;
}
@end

@implementation ThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//① NSThread  程序员管理 (偶尔使用)
-(void)theThread{
    /*
     一个 NSThread 对象就是一条线程
     线程一启动，就会告诉 CPU 准备就绪,可以随时接受 CPU 调度! CPU 调度当前线程之后,就会在线程thread中执行self的run方法
     + (NSThread *)mainThread;  获得主线程
     
     - (BOOL)isMainThread;  是否为主线程
     
     + (BOOL)isMainThread;  是否为主线程
     
     线程的调度优先级
     
     + (double)threadPriority;
     
     + (BOOL)setThreadPriority:(double)p;
     
     - (double)threadPriority;
     
     - (BOOL)setThreadPriority:(double)p;
     
     调度优先级的取值范围是0.0 ~ 1.0，默认0.5，值越大，优先级越高
     */
    //创建和启动
    thread = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
    //其他创建线程方式
    //创建线程后自动启动线程
    
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
    //隐式创建并启动线程
    
    [self performSelectorInBackground:@selector(run) withObject:nil];
}

-(void)run{
    NSThread *current = [NSThread currentThread];//获得当前线程
    [current setName:@"currentThread1"];//线程的名字
//    设置线程的优先级,注意线程优先级的取值范围为0.0~1.0之间，1.0表示线程的优先级最高,如果不设置该值，那么理想状态下默认为0.5
    
    thread.threadPriority = 1.0;
    
//    常用的控制线程状态的方法
    
    [NSThread exit]; //退出当前线程
    
    [NSThread sleepForTimeInterval:2.0]; //阻塞线程
    
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]]; //阻塞线程
    
    //注意：线程死了不能复生
    
//    current.name = @"currentThread2";
    /*
     启动线程
     
     - (void)start;
     
     进入就绪状态 ->运行状态。当线程任务执行完毕，自动进入死亡状态
     
     
     
     阻塞（暂停）线程
     
     + (void)sleepUntilDate:(NSDate *)date;
     
     + (void)sleepForTimeInterval:(NSTimeInterval)ti;
     
     进入阻塞状态
     
     
     
     强制停止线程
     
     + (void)exit;
     
     进入死亡状态
     
     注意：一旦线程停止（死亡）了，就不能再次开启任务
     
     
     
     
     互斥锁使用格式
     
     @synchronized(锁对象) {  需要锁定的代码  }
     
     注意：锁定1份代码只用1把锁，用多把锁是无效的
     
     
     
     
     
     线程间通信常用方法
     
     - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait;
     
     - (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait;
     
     
     
     （6）如何计算代码段的执行时间
     
     
     
     第一种方法
     
     NSDate *start = [NSDate date];
     
     2.根据url地址下载图片数据到本地（二进制数据）
     
     NSData *data = [NSData dataWithContentsOfURL:url];
     
     
     
     NSDate *end = [NSDate date];
     
     NSLog(@"第二步操作花费的时间为%f",[end timeIntervalSinceDate:start]);
     
     
     
     第二种方法
     
     CFTimeInterval start = CFAbsoluteTimeGetCurrent();
     
     NSData *data = [NSData dataWithContentsOfURL:url];
     
     
     
     CFTimeInterval end = CFAbsoluteTimeGetCurrent();
     NSLog(@"第二步操作花费的时间为%f",end - start);
     */
}
//（5）线程间通信

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event

{
    
//    [self download2];
    
    
    
//    开启一条子线程来下载图片
    
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
    
}



-(void)downloadImage

{
    
//    1.确定要下载网络图片的url地址，一个url唯一对应着网络上的一个资源
    
    NSURL *url = [NSURL URLWithString:@"http://p6.qhimg.com/t01d2954e2799c461ab.jpg"];
    
    
    
//    2.根据url地址下载图片数据到本地（二进制数据
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    
//    3.把下载到本地的二进制数据转换成图片
    
    UIImage *image = [UIImage imageWithData:data];
    
    
    
//    4.回到主线程刷新UI
    
//    4.1 第一种方式
    
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
//    
//    
//    
////    4.2 第二种方式
//    
//    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//    
//    
//    
////    4.3 第三种方式
//    
//    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    
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
