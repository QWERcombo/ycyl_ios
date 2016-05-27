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
#import "UserTextFieldTableViewCell.h"

@interface InfomationViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, assign) NSInteger user_role;
@property (nonatomic, strong) NSArray *dataSourceLeft;
@property (nonatomic, strong) NSArray *dataSourceRight;
@property (nonatomic, strong) NSMutableArray *listDataSource;
@property (nonatomic, assign) BOOL isOpen;
@end

@implementation InfomationViewController

- (NSUserDefaults *)userDefaults {
    if (_userDefaults == nil) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

- (NSArray *)dataSourceLeft {
    if (_dataSourceLeft == nil) {
        self.dataSourceLeft = [NSMutableArray array];
    }
    return _dataSourceLeft;
}

- (NSArray *)dataSourceRight {
    if (_dataSourceRight == nil) {
        self.dataSourceRight = [NSMutableArray array];
    }
    return _dataSourceRight;
}

- (NSMutableArray *)listDataSource {
    if (_listDataSource == nil) {
        self.listDataSource = [NSMutableArray array];
    }
    return _listDataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 15, 20);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"Fill 241"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(changeInfo:)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.user_role = [[self.userDefaults objectForKey:@"userinfo"][@"user_role"] integerValue];
    //self.user_role = 2;
    self.dataSourceLeft = [NSArray arrayWithObjects:@"真实姓名", @"性别", @"出生日期", @"QQ", @"手机号", @"邮箱", @"医生职称", @"所属医院", @"所属科室", nil];
    self.dataSourceRight = [NSArray arrayWithObjects:@"Lawrence Johnson", @"男 >", @"1990-01-01 >", @"662788233", @"18512345678", @"2345678@qq.com", @"主任医师 >", @"北京协和医院 >", @"泌尿外科 >", nil];
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listCell"];
}

- (void)changeInfo:(UIBarButtonItem *)sender {
    MyLog(@"修改");
//    for (NSIndexPath *index in self.tableView.indexPathsForVisibleRows) {
//        MyLog(@"%ld---%ld", index.section, index.row);
//    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo:)];
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        UserTextFieldTableViewCell *tfCell = (UserTextFieldTableViewCell *)cell;
        if ([cell isKindOfClass:[UserTextFieldTableViewCell class]]) {
            tfCell.contentTF.userInteractionEnabled = YES;
        }
    }
}

- (void)saveInfo:(UIBarButtonItem *)sender {
    MyLog(@"%ld", self.user_role);
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        UserTextFieldTableViewCell *tfCell = (UserTextFieldTableViewCell *)cell;
        if ([cell isKindOfClass:[UserTextFieldTableViewCell class]]) {
            MyLog(@"%@", tfCell.titleLabel.text);
            NSArray *tempArr = [NSArray arrayWithObjects:@"真实姓名", @"性别", @"出生日期", @"手机号", nil];
            NSArray *tempArray = [NSArray arrayWithObjects:@"医生职称", @"所属科室", nil];
            if (self.user_role == 2 || self.user_role == 3) {
                if ([tfCell.titleLabel.text isEqualToString:@"所属医院"]) {
                    tfCell.contentTF.userInteractionEnabled = NO;
                }
                if ([tempArray containsObject:tfCell.titleLabel.text]) {
                    if (tfCell.contentTF.text.length == 0) {
                        [self showAlertWithString:@"医生职称, 所属科室不能为空"];
                        return;
                    }
                }
            }
            if (self.user_role == 4) {
                if ([tfCell.titleLabel.text isEqualToString:@"医生职称"]) {
                    if (tfCell.contentTF.text.length == 0) {
                        [self showAlertWithString:@"医生职称不能为空"];
                        return;
                    }
                }
            }
            if ([tempArr containsObject:tfCell.titleLabel.text]) {
                if (tfCell.contentTF.text.length == 0) {
                    [self showAlertWithString:@"真实姓名, 性别, 出生日期, 手机号等不能为空"];
                    return;
                }
            }
        }
        //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //    [manager POST:[NSString stringWithFormat:@"%@%@", KDUrl, KDUrl] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        MyLog(@"%@", responseObject);
        //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        MyLog(@"%@", error);
        //    }];
        //[tfCell.contentTF endEditing:YES];
//        tfCell.contentTF.userInteractionEnabled = NO;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(changeInfo:)];
}

- (void)showAlertWithString:(NSString *)string {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        if (self.user_role == 2 || self.user_role == 3 || self.user_role == 4) {
            return 2;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (self.user_role == 2 || self.user_role == 3 || self.user_role == 4) {
            if (section == 0) {
                return self.dataSourceLeft.count + 1;
            } else {
                return 1;
            }
        } else {
            return self.dataSourceLeft.count - 3;
        }
    } else {
        return self.listDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (self.user_role == 2 || self.user_role == 3 || self.user_role == 4) {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    UserInfoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
                    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:@" "] placeholderImage:[UIImage imageNamed:@"G roup.png"]];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                } else {
                    UserTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                    cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.dataSourceLeft[indexPath.row - 1]];
                    cell.contentTF.placeholder = [NSString stringWithFormat:@"%@", self.dataSourceRight[indexPath.row - 1]];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.contentTF.userInteractionEnabled = NO;
                    return cell;
                }
            } else {
                UserTextViewTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
                infoCell.textview.delegate = self;
                infoCell.textview.tag = 1001;
                infoCell.contentLabel.text = @"请填写您的个人介绍";
                infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return infoCell;
            }
        } else {
            UserTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.dataSourceLeft[indexPath.row]];
            cell.contentTF.placeholder = [NSString stringWithFormat:@"%@", self.dataSourceRight[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentTF.userInteractionEnabled = NO;
            return cell;
        }
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"forIndexPath:indexPath];
        cell.textLabel.text = self.listDataSource[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tableView) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        if (!self.isOpen) {
            if (indexPath.row == 7) {
                [self customListTableViewInitWithRowIndexPath:indexPath];
                [manager POST:[NSString stringWithFormat:@"%@%@", KDUrl, KDUrlGetgrade] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    for (NSDictionary *dic in responseObject) {
                        [self.listDataSource addObject:dic[@"name"]];
                    }
                    MyLog(@"%ld", self.listDataSource.count);
                    [self.listTableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            }
            if (indexPath.row == 8) {
                [self customListTableViewInitWithRowIndexPath:indexPath];
                [manager POST:[NSString stringWithFormat:@"%@%@", KDUrl, KDUrlGethospital] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    MyLog(@"%@", responseObject);
                    [self.listTableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //MyLog(@"%@", error);
                }];
            }
            if (indexPath.row == 9) {
                [self customListTableViewInitWithRowIndexPath:indexPath];
                [manager POST:[NSString stringWithFormat:@"%@%@", KDUrl, KDUrlGetdept] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    MyLog(@"%@", responseObject);
                    [self.listTableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //MyLog(@"%@", error);
                }];
            }
            self.isOpen = YES;
        } else {
            [self.listTableView removeFromSuperview];
            [self.listDataSource removeAllObjects];
            self.isOpen = NO;
        }
    } else {
        MyLog(@"this is listTableview-------");
    }
}

- (void)customListTableViewInitWithRowIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.listTableView.frame = CGRectMake(0, CGRectGetMaxY(cell.frame), cell.frame.size.width, KDHeight - 64 - CGRectGetMaxY(cell.frame));
    self.listTableView.backgroundColor = [UIColor yellowColor];
    [self.tableView addSubview:self.listTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (section == 0) {
            return 10;
        } else {
            return 50;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 10;
    } else {
        return 0;
    }
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
