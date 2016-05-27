//
//  UserInfoViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/10.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "UserInfoViewController.h"
#import "InfomationViewController.h"
#import "PasswordViewController.h"
#import "LoginHomePageViewController.h"

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation UserInfoViewController

- (NSUserDefaults *)userDefaults {
    if (_userDefaults == nil) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 15, 20);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"Fill 241"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    
}


#pragma mark - UITableView Datasource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改个人资料";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"修改密码";
    } else {
        cell.textLabel.text = @"切换账号";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        InfomationViewController *infoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Infomation"];
        [self.navigationController pushViewController:infoVC animated:YES];
    } else if (indexPath.row == 1) {
        PasswordViewController *passVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Password"];
        [self.navigationController pushViewController:passVC animated:YES];
    } else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *string = [NSString stringWithFormat:@"%@", [self.userDefaults objectForKey:@"userinfo"][@"id"]];
        [manager POST:[NSString stringWithFormat:@"%@%@", KDUrl, KDUrlLogout] parameters:@{@"client":@"ios", @"userid":string} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        [self.userDefaults setObject:nil forKey:@"userName"];
        [self.userDefaults setObject:nil forKey:@"password"];
        [self.userDefaults setObject:nil forKey:@"userinfo"];
        LoginHomePageViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginHomePage"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return KDHeight - 64 - 20 - 44 * 3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
