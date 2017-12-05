//
//  SingleCaseVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/26.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "SingleCaseVC.h"

@interface SingleCaseVC ()

@end
static id instance;//① 在.m中保留一个全局的 static 实例
@implementation SingleCaseVC

//② 重写allocWithZone: 方法，在这里创建唯一的实例 (注意线程安全)
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (instance == nil) {//防止频繁加锁
        @synchronized (self) {
            if (instance == nil) {//防止创建多次
                instance = [super allocWithZone:zone];
                
            }
        }
    }
    return instance;
}

//③ 提供1个类方法让外界访问唯一的实例
+(instancetype)sharedMusicTool{
    if (instance == nil) {//防止频繁加锁
        @synchronized (self) {
            if (instance == nil) {//防止创建多次
                instance = [[self alloc]init];
            }
            
        }
    }
    return instance;
}

//④ 实现copyWithZoon:方法
-(id)copyWithZoon:(struct _NSZone*)zone{
    return instance;
}

// 严谨起见，重写-copyWithZone方法和-MutableCopyWithZone方法
-(id)mutableCopy{
    return instance;
}


























@end
