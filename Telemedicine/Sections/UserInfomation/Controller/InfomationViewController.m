//
//  InfomationViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/10.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "InfomationViewController.h"
#import "UserInfoImageTableViewCell.h"
#import "UserTextViewTableViewCell.h"

@interface InfomationViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, assign) NSInteger user_role;
@property (nonatomic, strong) NSArray *dataSourceLeft;
@property (nonatomic, strong) NSArray *dataSourceRight;
@end

@implementation InfomationViewController

- (NSUserDefaults *)userDefaults {
    if (_userDefaults == nil) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

- (NSArray *)dataSourceOne {
    if (_dataSourceLeft == nil) {
        self.dataSourceLeft = [NSMutableArray array];
    }
    return _dataSourceLeft;
}

- (NSArray *)dataSourceTwo {
    if (_dataSourceRight == nil) {
        self.dataSourceRight = [NSMutableArray array];
    }
    return _dataSourceRight;
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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.user_role = [[self.userDefaults objectForKey:@"userinfo"][@"user_role"] integerValue];
//    self.user_role = 2;
    self.dataSourceLeft = [NSArray arrayWithObjects:@"真实姓名", @"性别", @"出生日期", @"QQ", @"手机号", @"邮箱", @"医生职称", @"所属医院", @"所属科室", nil];
    self.dataSourceRight = [NSArray arrayWithObjects:@"Lawrence Johnson", @"男 >", @"1990-01-01 >", @"662788233", @"18512345678", @"2345678@qq.com", @"主任医师 >", @"北京协和医院 >", @"泌尿外科 >", nil];
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.user_role == 2 || self.user_role == 3 || self.user_role == 4) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.user_role == 2 || self.user_role == 3 || self.user_role == 4) {
        if (section == 0) {
            return self.dataSourceLeft.count + 1;
        } else {
            return 1;
        }
    } else {
        return self.dataSourceLeft.count - 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.user_role == 2 || self.user_role == 3 || self.user_role == 4) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                UserInfoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.textLabel.text = self.dataSourceLeft[indexPath.row - 1];
                cell.detailTextLabel.text = self.dataSourceRight[indexPath.row - 1];
                return cell;
            }
        } else {
            UserTextViewTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
            infoCell.textview.delegate = self;
            infoCell.textview.tag = 1001;
            infoCell.contentLabel.text = @"请填写您的个人介绍";
            return infoCell;
        }
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = self.dataSourceLeft[indexPath.row];
        cell.detailTextLabel.text = self.dataSourceRight[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"个人简介";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 200;
    }
    return 44;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView.tag == 1001) {
        ((UserTextViewTableViewCell *)textView.superview.superview).contentLabel.hidden = YES;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.tag == 1001) {
        ((UserTextViewTableViewCell *)textView.superview.superview).contentLabel.hidden = NO;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
