//
//  HuiDiao.h
//  SomeTrain
//
//  Created by listome on 2016/11/25.
//  Copyright © 2016年 listome. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef
@interface HuiDiao : UIViewController
/**
 *  定义了一个changeColor的Block。这个changeColor必须带一个参数，这个参数的类型必须为id类型的
 *  无返回值
 *  param id
 */
typedef void(^changeColor)(id);
typedef void(^changeTitle)(NSString *tit);
typedef void(^lll)(NSString *ll);
/**
 *  用上面定义的changeColor声明一个Block,声明的这个Block必须遵守声明的要求。
 */
@property (nonatomic, copy) changeColor backgroundColor;
@property(nonatomic,copy)changeTitle tit;
@property(nonatomic,copy)lll l;
@property(nonatomic,copy)void (^nichaun2)(NSString*);
@property(nonatomic,copy)void (^nichaun3)(NSString * strText);
@end
