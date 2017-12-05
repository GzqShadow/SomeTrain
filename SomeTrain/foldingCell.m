//
//  foldingCell.m
//  SomeTrain
//
//  Created by listome on 2017/4/1.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "foldingCell.h"

@implementation foldingCell
//采用xib自定义cell xib上的信息要放在这里更新
- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.CXimageView.image = [UIImage imageNamed:@"caishen.jpg"];
//    self.upLabel.text = @"恭喜发财";
//    self.downLable.text = @"财源广进";
//    self.foregroundView.backgroundColor = [UIColor redColor];
//    self.containerView.backgroundColor = [UIColor blueColor];
    self.foregroundView.layer.cornerRadius = 10;
    self.foregroundView.layer.masksToBounds = YES;
    
}
- (void)setNumber:(NSInteger)number
{
    self.CloseNumberLabel.text = @(number).stringValue;
//    self.closeNumberLabel.text = @(number).stringValue;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //不要把控件add到view上
        //add到contentView才是你最正确的选择
        [self.contentView addSubview:self.foregroundView];
        
        [self.contentView addSubview:self.containerView];
        
//        [self.contentView addSubview:self.downLable];
    }
    return self;
}



- (NSTimeInterval)animationDurationWithItemIndex:(NSInteger)itemIndex animationType:(AnimationType)type
{
    NSArray<NSNumber *> *array = @[@(0.5f),@(.25f),@(.25f)];
    return array[itemIndex].doubleValue;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
