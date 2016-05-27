//
//  PasswordViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/10.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "PasswordViewController.h"
#import "LoginHomePageViewController.h"

@interface PasswordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *NEWPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *againPasswordTF;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation PasswordViewController

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
    //MyLog(@"%@", [self.userDefaults objectForKey:@"password"]);
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
}

- (IBAction)cancelAction:(UIButton *)sender {
    self.oldPasswordTF.text = nil;
    self.NEWPasswordTF.text = nil;
    self.againPasswordTF.text = nil;
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (self.oldPasswordTF.text.length == 0 || self.NEWPasswordTF.text.length == 0 || self.againPasswordTF.text.length == 0) {
        [self showAlertWithString:@"输入的内容不能为空"];
        return;
    }
    if (![self.NEWPasswordTF.text isEqualToString:self.againPasswordTF.text]) {
        [self showAlertWithString:@"两次输入的新密码不正确, 请重新输入"];
        return;
    }
    if ([self.oldPasswordTF.text isEqualToString:self.NEWPasswordTF.text]) {
        [self showAlertWithString:@"新旧密码不能一样, 请重新输入"];
        return;
    }
    if (![self.oldPasswordTF.text isEqualToString:[self.userDefaults objectForKey:@"password"]]) {
        [self showAlertWithString:@"旧密码输入不正确, 请重新输入"];
        return;
    }
    if (self.NEWPasswordTF.text.length < 6) {
        [self showAlertWithString:@"新密码位数至少6位"];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *useridStr = [NSString stringWithFormat:@"%@", [self.userDefaults objectForKey:@"userinfo"][@"id"]];
    [manager POST:[NSString stringWithFormat:@"%@%@", KDUrl, KDUrlChangePassword] parameters:@{@"userid": useridStr, @"oldpsd": self.oldPasswordTF.text, @"newpsd": self.NEWPasswordTF.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"status"] == 0) {
            [self showAlertWithString:responseObject[@"msg"]];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.userDefaults setObject:nil forKey:@"userName"];
                [self.userDefaults setObject:nil forKey:@"password"];
                [self.userDefaults setObject:nil forKey:@"userinfo"];
                LoginHomePageViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginHomePage"];
                [self presentViewController:loginVC animated:YES completion:nil];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"%@", error);
    }];    
}

- (void)showAlertWithString:(NSString *)string {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
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
