//
//  FoldingVC.m
//  SomeTrain
//
//  Created by listome on 2017/4/1.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "FoldingVC.h"
#import "foldingCell.h"
#define kCloseCellHeight    179.f
#define kOpenCellHeight     488.f
#define kRowsCount          10
static NSString * identifier = @"cxCellID";
@interface FoldingVC ()
@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeights;
@end


@implementation FoldingVC

- (void)createCellHeightsArray
{
    for (int i = 0; i < kRowsCount; i ++) {
        [self.cellHeights addObject:@(kCloseCellHeight)];
    }
}


-(instancetype)initWithStyle:(UITableViewStyle)style{
    self= [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"foldingCell" bundle:nil] forCellReuseIdentifier:@"foldingCell"];
        self.tableView.showsVerticalScrollIndicator=NO;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCellHeightsArray];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeights[indexPath.row].floatValue;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return kRowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    foldingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"foldingCell"];
//    foldingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foldingCell" forIndexPath:indexPath];
    cell = [[[UINib nibWithNibName:@"foldingCell" bundle:nil]instantiateWithOwner:self options:nil]lastObject];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(foldingCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![cell isKindOfClass:[foldingCell class]]) return;
    
    cell.backgroundColor = [UIColor clearColor];
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    if (cellHeight == kCloseCellHeight) {
        [cell selectedAnimationByIsSelected:NO animated:NO completion:nil];
    }else
    {
        [cell selectedAnimationByIsSelected:YES animated:NO completion:nil];
    }
    
    [cell setNumber:indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    foldingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell isKindOfClass:[foldingCell class]]) return;
    
    if (cell.isAnimating) return;
    
    NSTimeInterval duration = 0.f;
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    
    if (cellHeight == kCloseCellHeight) {
        self.cellHeights[indexPath.row] = @(kOpenCellHeight);
        [cell selectedAnimationByIsSelected:YES animated:YES completion:nil];
        duration = 1.f;
    }else
    {
        self.cellHeights[indexPath.row] = @(kCloseCellHeight);
        [cell selectedAnimationByIsSelected:NO animated:YES completion:nil];
        duration = 1.f;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [tableView beginUpdates];
        [tableView endUpdates];
    } completion:nil];
    
}
- (NSMutableArray<NSNumber *> *)cellHeights
{
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}
@end
