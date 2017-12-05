//
//  GCDVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/26.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "GCDVC.h"

@interface GCDVC ()

@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 
 *  sync -- 主队列(不能用---会卡死)
 
 */

- (void)syncMainQueue

{
    
    NSLog(@"syncMainQueue----begin--");
    
    
    
//    1.主队列(添加到主队列中的任务，都会自动放到主线程中去执行)
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    
//    2.添加 任务 到主队列中 异步 执行
    
    dispatch_sync(queue, ^{
        
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
        
    });
    
    dispatch_sync(queue, ^{
        
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
        
    });
    
    dispatch_sync(queue, ^{
        
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
        
    });
    
    
    
    NSLog(@"syncMainQueue----end--");
    /* 并发队列
     GCD默认已经提供了全局的并发队列，供整个应用使用，不需要手动创建
     
     使用dispatch_get_global_queue函数获得全局的并发队列
     
     dispatch_queue_t dispatch_get_global_queue(
     
     dispatch_queue_priority_t priority,  队列的优先级
     
     unsigned long flags);  此参数暂时无用，用0即可
     
     全局并发队列
     
     dispatch_queue_t queue =
     
     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     
     (里面的参数第一个为优先级,可以默认为固定写法)列
     
     全局并发队列的优先级
     
     #define DISPATCH_QUEUE_PRIORITY_HIGH 2  高
     
     #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0  默认（中）
     
     #define DISPATCH_QUEUE_PRIORITY_LOW (-2)  低
     
     #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN  后台
     */
    
    
    /*
     串行队列
     
     GCD中获得串行有2种途径
     
     1.使用dispatch_queue_create函数创建串行队列
     
     dispatch_queue_t
     
     dispatch_queue_create(const char*label,  队列名称
     
     dispatch_queue_attr_t attr);  队列属性，一般用NULL即可
     
     创建一个串行队列
     
     dispatch_queue_t queue = dispatch_queue_create("cn.itcast.queue", NULL);
     
     dispatch_release(queue); 非ARC需要释放手动创建的队列
     
     2.使用主队列（跟主线程相关联的队列,肯定是串行队列）
     
     主队列是GCD自带的一种特殊的串行队列
     
     放在主队列中的任务，都会放到主线程中执行
     
     使用dispatch_get_main_queue()获得主队列
     
     dispatch_queue_t queue = dispatch_get_main_queue();
     */
    
    
//    从子线程回到主线程
    
    dispatch_async(
                   
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       
//                       执行耗时的异步操作...
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           
//                           回到主线程，执行UI刷新操作
                           
                       });
                       
                   });
    
    
    
    //延时
//afterDelay:延迟的时间
    //①
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    //②使用GCD函数(3秒后自动开启新线程 执行block中的代码,不会卡主当前的线程,在主/子线程调用都可以使用)
    
    
    //DISPATCH_TIME_NOW:现在开始的意
    
//    2.0 * NSEC_PER_SEC:设置的秒数(直接更改数字即可)
    
//    dispatch_get_main_queue():主队列的意思
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        2秒后执行这里的代码... 在哪个线程执行，跟队列类型有关
        
    });
    
    
    
    //一次性代码
//    使用dispatch_once函数能保证某段代码在程序运行过程中只被执行1次
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{

//        程序运行过程中,永远只执行1次的代码(这里面默认是线程安全的)
        
    });
    
    
    
    //队列组
    /*
     有这么1种需求
     
     首先：分别异步执行2个耗时的操作
     
     其次：等2个异步操作都执行完毕后，再回到主线程执行操作
     */
//    如果想要快速高效地实现上述需求，可以考虑用队列组(先创建一个队列组,再把要执行的一个异步操作放入队列组的block当中)
    
    dispatch_group_t group =  dispatch_group_create();
    
    
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
//        执行1个耗时的异步操作
        
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
//        执行1个耗时的异步操作
        
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
//        等前面的异步操作都执行完毕后，回到主线程...
        
    });
    
//    注意:这个组的特点,它会等组里面所有的任务(同上的两个block代码内容)都执行完了以后,它会调用_notify里面的这个block;
    

//    01 栅栏函数（控制任务的执行顺序）
    
    dispatch_barrier_async(queue, ^{
        
        NSLog(@"--dispatch_barrier_async-");
        
    });
    
    
}
//同步函数+主队列:死锁

-(void)syncWithMain

{
    
    NSLog(@"-----");
    
//    1.获得主队列
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    
    dispatch_sync(queue, ^{
        
        NSLog(@"1---%@",[NSThread currentThread]);
        
    });
    
}

//异步函数+主队列:不会开线程,串行执行
//
//凡是在主队列中的任务都在主线程中去执行

-(void)asyncWithMain

{
    
//    1.获得主队列
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    
//    异步函数
    
    dispatch_async(queue, ^{
        
        NSLog(@"1---%@",[NSThread currentThread]);
        
    });
    
}

//同步函数+并发队列:不会开线程,串行执行

-(void)syncWithConcuerrent

{
    
//    获得全局并发队列
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
//    同步函数
    
    dispatch_sync(queue, ^{
        
        NSLog(@"1---%@",[NSThread currentThread]);
        
    });
    
    
    
}



//同步函数+串行队列:不会开线程,串行执行

-(void)syncWithserial

{
    
//    1.创建队列(串行队列)
    
    dispatch_queue_t queue = dispatch_queue_create("com.520it.download", DISPATCH_QUEUE_SERIAL);
    
    
    
//    同步函数
    
    dispatch_sync(queue, ^{
        
        NSLog(@"1---%@",[NSThread currentThread]);
        
    });
    
}



//异步函数+串行队列:会开1条线程,串行执行

-(void)asyncWithserial

{
    
//    1.创建队列(串行队列)
    
    dispatch_queue_t queue = dispatch_queue_create("com.520it.download", DISPATCH_QUEUE_SERIAL);
    
    
    
//    异步函数
    
    dispatch_async(queue, ^{
        
        NSLog(@"1---%@",[NSThread currentThread]);
        
    });
    
    
    
}



//异步函数+并发队列:会开线程,会开启多条线程,并发执行

-(void)asyncWithConcurrent

{
    
//    1.创建队列(并发队列)
    
    
    
//    第一个参数:C语言的字符传,标签
    
//    第二个参数:队列的类型
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.520it.download", DISPATCH_QUEUE_CONCURRENT);
    
    
    
//    异步函数
    
    dispatch_async(queue, ^{
        
        NSLog(@"1---%@",[NSThread currentThread]);
        
    });
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
