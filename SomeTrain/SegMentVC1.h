//
//  SegMentVC1.h
//  SomeTrain
//
//  Created by listome on 2017/4/6.
//  Copyright © 2017年 listome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegMentVC1 : UIViewController

@end
@protocol VFrameWorkDelegate <NSObject>

-(void)fdata:(CGFloat)money WithTag:(NSInteger)tag;

@end
@interface VFrameWork : UIView
{
    CGFloat scrZJ;
    UIButton *scrSureBtn;
    UITextField *f1;
//    UITextField *f2;
    UILabel *danXZJ;
}
typedef void(^HCMoney)();
@property(nonatomic,strong)UITextField *f2;
@property (nonatomic, copy) HCMoney hcMoney;
@property(nonatomic,strong)NSArray *leftArr;
@property(nonatomic,copy)NSString *leftstr;
@property(nonatomic,strong)NSArray *holdArr;
@property(nonatomic,copy)NSString *zjStr;
@property(nonatomic,copy)NSString *holdstr;
@property(nonatomic,strong)UILabel *lefLab;
@property (weak, nonatomic) id<VFrameWorkDelegate> delegate;
//-(instancetype)initWithFrame:(CGRect)frame LeftArr:(NSArray *)leftArr HoldStr:(NSString *)holdstr ZJStrLeft:(NSString *)zjStr WithTag:(NSInteger)vtag;
-(instancetype)initWithFrame:(CGRect)frame LeftStr:(NSString *)leftstr HoldStr:(NSString *)holdstr ZJStrLeft:(NSString *)zjStr WithTag:(NSInteger)vtag;
@end
