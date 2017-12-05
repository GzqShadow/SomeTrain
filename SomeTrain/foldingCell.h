//
//  foldingCell.h
//  SomeTrain
//
//  Created by listome on 2017/4/1.
//  Copyright © 2017年 listome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFoldCell.h"
@interface foldingCell : CCFoldCell
@property (weak, nonatomic) IBOutlet UILabel *CloseNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *OpenNumberLabel;

- (void)setNumber:(NSInteger)number;

@end
