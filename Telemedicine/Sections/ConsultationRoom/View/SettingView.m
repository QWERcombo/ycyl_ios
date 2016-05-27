//
//  SettingView.m
//  Telemedicine
//
//  Created by RCChina on 16/5/17.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "SettingView.h"
#import "EvaluateViewController.h"
#import "VedioSourceViewController.h"
#import "BaseInfomationViewController.h"

@implementation SettingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cancel:(UIButton *)sender {
    [self removeFromSuperview];
}

- (IBAction)pause:(UIButton *)sender {
    MyLog(@"暂停");
}

- (IBAction)closeSound:(UIButton *)sender {
    MyLog(@"关闭话筒");
}

- (IBAction)evaluation:(UIButton *)sender {
    EvaluateViewController *evaluate = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"evaluate"];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:evaluate];
    [self.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

- (IBAction)closeVedio:(UIButton *)sender {
    MyLog(@"关闭摄像头");
}

- (IBAction)infomation:(UIButton *)sender {
    BaseInfomationViewController *baseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BaseInfomation"];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:baseVC];
    [self.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

- (IBAction)changeVedio:(UIButton *)sender {
    VedioSourceViewController *vedioVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"VedioSource"];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vedioVC];
    [self.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

@end
