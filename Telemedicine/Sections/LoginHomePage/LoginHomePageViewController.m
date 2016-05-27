//
//  LoginHomePageViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/23.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LoginHomePageViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"

@interface LoginHomePageViewController ()
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation LoginHomePageViewController

- (NSUserDefaults *)userDefaults {
    if (_userDefaults == nil) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPresentView];
    
}

- (void)initPresentView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KDWidth/3, 60)];
    label.center = CGPointMake(KDWidth/2, KDHeight/6);
    label.text = @"远程医疗";
    label.font = [UIFont boldSystemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    self.userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(KDWidth / 4, CGRectGetMaxY(label.frame) + 100, KDWidth / 2, 40)];
    self.userNameTF.placeholder = @"用户名";
    [self.userNameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.userNameTF setValue:[UIFont systemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    self.userNameTF.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.userNameTF];
    UIView *userNameView = [[UIView alloc] initWithFrame:CGRectMake(KDWidth / 4, CGRectGetMaxY(self.userNameTF.frame) + 5, KDWidth / 2, 2)];
    userNameView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:userNameView];
    
    self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(KDWidth / 4, CGRectGetMaxY(userNameView.frame) + 50, KDWidth / 2, 40)];
    self.passwordTF.placeholder = @"密码";
    [self.passwordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:[UIFont systemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    self.passwordTF.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.passwordTF];
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(KDWidth / 4, CGRectGetMaxY(self.passwordTF.frame) + 5, KDWidth / 2, 2)];
    passwordView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:passwordView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KDWidth / 5 * 2, CGRectGetMaxY(passwordView.frame) + 60, KDWidth / 4, 40);
    button.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 2;
    button.layer.masksToBounds = YES;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)buttonAction {
    MyLog(@"%@---%@", self.userNameTF.text, self.passwordTF.text);
    if (self.userNameTF.text.length == 0 || self.passwordTF.text.length == 0) {
        [self showAlertWithString:@"用户名或密码不能为空"];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@%@", KDUrl, KDUrlLogin] parameters:@{@"username": self.userNameTF.text, @"password":self.passwordTF.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToNumber:@0]) {
            [self showAlertWithString:@"用户名或密码不正确, 请重新输入"];
        }
        else {
            [self.userDefaults setObject:self.userNameTF.text forKey:@"userName"];
            [self.userDefaults setObject:self.passwordTF.text forKey:@"password"];
            [self.userDefaults setObject:responseObject[@"userinfo"] forKey:@"userinfo"];
                HomePageViewController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomePage"];
                UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:homeVC];
                [self presentViewController:navigation animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"%@", error);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%ld", error.code] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)showAlertWithString:(NSString *)string {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancel];
    [alert addAction:confirm];
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
