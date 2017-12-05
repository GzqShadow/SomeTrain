//
//  languageCS.m
//  SomeTrain
//
//  Created by listome on 2016/11/24.
//  Copyright © 2016年 listome. All rights reserved.
//

#import "languageCS.h"

@interface languageCS ()<UIAlertViewDelegate>
@end

@implementation languageCS

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIAlertController *a = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"REMIND", nil)  message:NSLocalizedString(@"NetworkConnectError", nil) preferredStyle:UIAlertControllerStyleActionSheet];
//    
    
    self.view.backgroundColor =[UIColor whiteColor];
    UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
    b.frame=CGRectMake(100, 100, 100, 100);
    b.backgroundColor=[UIColor redColor];
    [b addTarget:self action:@selector(act) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    
}

-(void)act{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"REMIND", nil) message:NSLocalizedString(@"NetworkConnectError", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
