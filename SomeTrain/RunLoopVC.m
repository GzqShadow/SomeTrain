//
//  RunLoopVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/27.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "RunLoopVC.h"

@interface RunLoopVC ()

{
    NSTimer *timer;
}

@end

@implementation RunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20-100,44 )];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor darkTextColor];
    /*
     每条线程都有唯一的一个与之对应的Runloop对象
     RunLoop在第一次获取是创建，在线程结束时销毁
     一、什么是runloop？
     1、从字面意思看，运行循环，跑圈
     其实它内部对应do-while循环，在这个循环内部不断地处理各种任务(比如Source、Timer、Observer)
     一个线程对应一个RunLoop，主线程的RunLoop默认已经启动，子线程的 RunLoop得手动启动(调用run方法)
     RunLoop只能选择一个Mode启动，如果当前Mode中没有任何Source(Sources0、Sources1)、Timer，那么就直接退出RunLoop
     二、自动释放池什么时候释放？
     通过Observer监听RunLoop的状态
     三、在开发中如何使用RunLoop？什么应用场景？
     开启一个常驻线程(让一个子线程不进入消亡状态，等其他线程发来消息，处理其他事件)
     在子线程中开启一个定时器
     在子线程中进行一些长期监控
     可以控制定时器在特定模式下执行
     可以添加Observer监听RunLoop的状态，比如监听点击事件的处理（在所有点击事件之前做一些事情）
     */
    
    // Foundation
    [NSRunLoop currentRunLoop];//获得当前线程的RunLoop对象
    [NSRunLoop mainRunLoop];   //获得主线程的RunLoop对象
    
    // Core Foundation
    CFRunLoopGetCurrent();     //获得当前线程的RunLoop对象
    CFRunLoopGetMain();        //获得主线程的RunLoop对象
    
    /*
     Core Foundation中关于RunLoop的5个类:
     CFRunLoopRef: 它自己，也就代表一个RunLoop对象
     CFRunLoopModeRef: RunLoop的运行模式
     CFRunLoopSourceRef: 事件源
     CFRunLoopTimerRef: 时间的触发器
     CFRunLoopObserver: 观察者 监听CFRunLoopRef的状态改变
     */
    
    /*
     CFRunLoopModeRef
     一个RunLoop包含若干个Mode，每个Mode又包含若干个source/Timer/Observer
     每次RunLoop启动时，只能指定其中一个Mode，这个Mode被称作CurrentMode
     如果需要切换Mode，只能退出Loop，再重新指定一个Mode进入
     这样做主要是为了分隔开不同组的Source/Timer/Observer
     
     系统默认注册了5个Mode模式
     kCFRunLoopDefaultMode: APP的默认Mode，通常主线程是在这个Mode下运行
     UITrackingRunLoopMode: 界面跟踪的Mode，用于scrollVIew追踪触摸滑动，保证界面滑动时不受其他Mode影响
     UIInitializationRunLoopMode: 在刚启动APP时进入的第一个Mode，启动完成后就不再使用
     GSEventRecriveRunLoopMode: 接受系统事件的内部Mode，通常用不到
     kCFRunLoopCommonModes: 这是 一个占位用的Mode，不是一种真正的Mode
     被标记为common modes 模式 kCFRunLoopDefaultMode UITrackingRunLoopMode两种模式
     */
    
    /*
     CFRUnLoopSourceRef 事件源 (输入源)
     以前的分法
     
     Port-Based Sources
     
     Custom Input Sources
     
     Cocoa Perform Selector Sources
     
     现在的分法
     Source0: 非基于Port的
     Source1: 基于Port的
     */
    
    
    /*
     CFRunLoopTimerRef 时间的触发器 基本上说的就是NSTimer
     */
    
    /*
     CFRunLoopObserverRef 是观察者，能够监听RunLoop的状态改变
     */
    
    /*
     自动释放池与RunLoop
     kCFRunLoopEntry;  创建一个自动释放池
     
     kCFRunLoopBeforeWaiting;  销毁自动释放池，创建一个新的自动释放池
     
     kCFRunLoopExit;  销毁自动释放池
     */
    
    
    
}

#pragma mark NSTimer相关代码
/*
 说明：
 
 （1）runloop一启动就会选中一种模式，当选中了一种模式之后其它的模式就都不鸟。一个mode里面可以添加多个NSTimer,也就是说以后当创建NSTimer的时候，可以指定它是在什么模式下运行的。
 
 （2）它是基于时间的触发器，说直白点那就是时间到了我就触发一个事件，触发一个操作。基本上说的就是NSTimer
 
 （3）相关代码
 */

- (void)timer2

{
    
//    NSTimer 调用了scheduledTimer方法，那么会自动添加到当前的runloop里面去，而且runloop的运行模式kCFRunLoopDefaultMode
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
  
//    更改模式
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

- (void)timer1

{
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    
    
//    定时器添加到UITrackingRunLoopMode模式，一旦runloop切换模式，那么定时器就不工作
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    
    
//    定时器添加到NSDefaultRunLoopMode模式，一旦runloop切换模式，那么定时器就不工作
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    
//    占位模式：common modes标记
//    
//    被标记为common modes的模式 kCFRunLoopDefaultMode  UITrackingRunLoopMode
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    
}



- (void)run

{
    
    NSLog(@"---run---%@",[NSRunLoop currentRunLoop].currentMode);
    
}
#pragma mark GCD中计时器
-(void)cgdJSQ{
//    0.创建一个队列
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
  
//    1.创建一个GCD的定时器
//    第一个参数：说明这是一个定时器
//    第四个参数：GCD的回调任务添加到那个队列中执行，如果是主队列则在主线程执行
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
//    2.设置定时器的开始时间，间隔时间以及精准度
    
    
    
//    设置开始时间，三秒钟之后调用
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW,3.0 *NSEC_PER_SEC);
    
//    设置定时器工作的间隔时间
    
    uint64_t intevel = 1.0 * NSEC_PER_SEC;
    
    
    
//    第一个参数：要给哪个定时器设置
    
//    第二个参数：定时器的开始时间DISPATCH_TIME_NOW表示从当前开始
    
//    第三个参数：定时器调用方法的间隔时间
    
//    第四个参数：定时器的精准度，如果传0则表示采用最精准的方式计算，如果传大于0的数值，则表示该定时切换i可以接收该值范围内的误差，通常传0
    
//    该参数的意义：可以适当的提高程序的性能
    
//    注意点：GCD定时器中的时间以纳秒为单位（面试）
    
    
    
    
    
    dispatch_source_set_timer(timer, start, intevel, 0 * NSEC_PER_SEC);
    
    
    
//    3.设置定时器开启后回调的方法
    
    
    
//    第一个参数：要给哪个定时器设置
    
//    第二个参数：回调block
    
    
    
    dispatch_source_set_event_handler(timer, ^{
        
        NSLog(@"------%@",[NSThread currentThread]);
        
    });
    
    
    
//    4.执行定时器
    
    dispatch_resume(timer);
    
    
    
//    注意：dispatch_source_t本质上是OC类，在这里是个局部变量，需要强引用
    
    self->timer = timer;
}

#pragma mark 如何监听
-(void)jianTing{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(),kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
      NSLog(@"监听runloop状态改变---%zd",activity);
    });
    
//    为runloop添加一个监听者
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    
    
    CFRelease(observer);
    /*
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     
     kCFRunLoopEntry = (1UL << 0),   //即将进入Runloop
     
     kCFRunLoopBeforeTimers = (1UL << 1),    //即将处理NSTimer
     
     kCFRunLoopBeforeSources = (1UL << 2),   //即将处理Sources
     
     kCFRunLoopBeforeWaiting = (1UL << 5),   //即将进入休眠
     
     kCFRunLoopAfterWaiting = (1UL << 6),    //刚从休眠中唤醒
     
     kCFRunLoopExit = (1UL << 7),            //即将退出runloop
     
     kCFRunLoopAllActivities = 0x0FFFFFFFU   //所有状态改变
     
     };
     */
}



#pragma mark M
/*
 面试:runloop和NSURLConnection
 
 1.发送请求
 
 默认情况下，NSURLConnection发送的是一个异步请求
 
 默认情况下，NSURLConnection的代理方法在主线程中进行调用（方便在拿到数据后，直接处理一些和UI相关的操作，而不需要考虑线程间通信）
 
 
 
 方法一，不严谨
 
 
 
 通过该方法设置代理，会自动的发送请求
 
 [[NSURLConnection alloc]initWithRequest:request delegate:self];
 
 
 
 方法二
 
 知识点A 设置代理方法在子线程中调用
 
 
 
 设置代理，startImmediately为NO的时候，该方法不会自动发送请求
 
 NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
 
 手动通过代码的方式来发送请求
 
 注意该方法内部会自动的把connect添加到当前线程的RunLoop中在默认模式下执行
 
 [connect start];
 
 
 
 （2）如何控制代理方法在哪个线程调用
 
 
 
 说明：默认情况下，代理方法会在主线程中进行调用（为了方便开发者拿到数据后处理一些刷新UI的操作不需要考虑到线程间通信）
 
 设置代理方法的执行队列
 
 [connect setDelegateQueue:[[NSOperationQueue alloc]init]];
 
 
 
 方法三:
 
 设置代理，startImmediately为NO的时候，该方法不会自动发送请求
 
 NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:request delegate:self
 
 startImmediately:NO];
 
 设置代理方法的执行队列
 
 [connect setDelegateQueue:[[NSOperationQueue alloc]init]];
 
 发送请求
 
 注意该方法内部会自动的把connect添加到当前线程的RunLoop中在默认模式下执行
 
 [connect start];
 
 
 
 知识点B 如果把发送网络请求的方法也放在子线程中执行如何
 
 使用GCD开启一个子线程来发送网络请求
 
 
 
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
 
 使用非自动发送网络请求模式,发送请求OK
 
 创建NSURLConnection对象，设置代理，暂不发送
 
 NSURLConnection *connect =  [[NSURLConnection alloc]initWithRequest:request delegate:self
 
 startImmediately:NO];
 
 设置代理方法的执行队列
 
 [connect setDelegateQueue:[[NSOperationQueue alloc]init]];
 
 
 
 调用start发送网络请求
 
 [connect start];
 
 
 
 NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:request delegate:self];
 
 connect setDelegateQueue:[[NSOperationQueue alloc]init]];
 
 创建当前线程的runloop，并开启runloop
 
 [[NSRunLoop currentRunLoop] run];
 
 
 
 });
 
 
 
 }
 
 
 
 使用上面的方法一，发送请求失败,为什么呢?（需要改造代码）
 
 (runloop和NSURLConnection的关系)?
 
 01 网络请求发送和数据接收是否成功，和一些因素相关，比如客户端的网速、服务器端的查询速度等等。
 
 02 而在子线程中创建的NSURLConnection对象是一个临时变量，当请求发送完成之后就被释放了，所以这个时候它的代理方法不会调用用。
 
 03 为什么使用方法二是OK的。因为在方法二中，调用了start来开始发送网络请求，该方法内部会自动将当前的connect作为一个Source添加到当前线程所在的Runloop中，如果当前线程是子线程（即当前线程的runloop并未创建），那么该方法内部会默认先创建当前线程的Runloop,设置在runloop的默认模式下运行。此时runloop会对这个Connect对象进行强引用，保证了代理方法被调用的前提
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end






















