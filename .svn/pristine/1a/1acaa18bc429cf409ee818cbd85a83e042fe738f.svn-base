//
//  EvaluateViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/16.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "EvaluateViewController.h"

@interface EvaluateViewController ()

@end

@implementation EvaluateViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 15, 20);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"Fill 241"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会诊评价";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(upload)];
}

- (void)upload {
    MyLog(@"提交");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
