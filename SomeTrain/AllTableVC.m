//
//  AllTableVC.m
//  SomeTrain
//
//  Created by listome on 2017/3/28.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "AllTableVC.h"
#import "FoldingVC.h"
#define JYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface AllTableVC ()
{
    NSArray     *titles;
    NSArray *mapTitles;
    NSArray     *className;
    NSArray *mapClass;
}
@end

@implementation AllTableVC
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self= [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tableView.backgroundColor=JYColor(242, 242, 246);
        self.tableView.showsVerticalScrollIndicator=NO;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitles];
    [self initClassName];
//    [self initMapTitles];
//    [self initMapClass];
}
- (void)initTitles
{
    ///主页面标签title
    titles = @[@"高德地图",
                @"block",
                @"国际化语言",
                @"贝塞尔曲线",
                @"分段选择",
                @"label自适应",
               @"DrawRect渲染",
               @"手机邮箱身份证验证",
               @"WKWeb2",
               @"电子签名?",
               @"友盟分享"
                ];
}
- (void)initClassName
{
    ///标签目标类
    className = @[@"MapVC",
                  @"BlockVC",
                  @"languageCS",
                  @"bezierPath",
                  @"SegMentVC1",
                  @"LabelAutoVC",
                  @"DrawRectVC",
                  @"VerificationVC",
                  @"WKWeb2",
                  @"DZQM",
                  @"UMShareVC"
                  ];
}

//- (void)initMapTitles
//{
//    ///主页面标签title
//    titles = @[@"地图自带大头针样式的点标注",
//               @"自定义样式的点标注",
//               @"动画效果的点标注",
//               @"定位、跟随、旋转"
//               ];
//}
//- (void)initMapClass
//{
//    ///标签目标类
//    className = @[@"DefaultPointMarkVC",
//                  @"CustomPointMarkVC",
//                  @"languageCS",
//                  @"bezierPath",
//                  
//                  ];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [titles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainCellIdentifier = @"com.autonavi.mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
//        cell.detailTextLabel.numberOfLines = 0;
    }
    
    cell.textLabel.text = titles[indexPath.row];
    

    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *classNamee = className[indexPath.row];
    
    UIViewController *subViewController = [[NSClassFromString(classNamee) alloc] init];
    subViewController.title = titles[indexPath.row];
    
    [self.navigationController pushViewController:subViewController animated:YES];
}

@end
