//
//  UserApplicationViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/12.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "UserApplicationViewController.h"
#import "ApplicationTableViewCell.h"
#import "UserAppDetailViewController.h"
#import "searchView.h"

@interface UserApplicationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)searchView *searchView;
@property (nonatomic, strong)UIView *backView;
@end

@implementation UserApplicationViewController

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 15, 20);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"Fill 241"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的申请";
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(KDWidth - 50, 10, 25, 25);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"Filter@2x"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    for (int i = 0; i < 4; i++) {
        NSString *string = [NSString stringWithFormat:@"%d", i];
        [self.dataSource addObject:string];
    }
    [self.tableView reloadData];
    
}

- (void)search {
    self.searchView = [[[NSBundle mainBundle] loadNibNamed:@"searchView" owner:nil options:nil] firstObject];
    self.searchView.frame = CGRectMake(0, 0, KDWidth, 600);
    self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.5;
    [self.tableView addSubview:self.backView];
    [self.view addSubview:self.searchView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 20, 20);
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"Group@2x"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
}

- (void)cancel {
    [self.searchView removeFromSuperview];
    [self.backView removeFromSuperview];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 15, 20);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"Fill 241"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(KDWidth - 50, 10, 25, 25);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"Filter@2x"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)done {
    MyLog(@"确定");
}

#pragma Mark - UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.size.width, 0, cell.frame.size.width, cell.frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:view];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width, 0, 82, 82)];
    imageView.center = CGPointMake(cell.frame.size.width + 41, cell.frame.size.height/2);
    imageView.image = [UIImage imageNamed:@"Group 4"];
    imageView.userInteractionEnabled = YES;
    [cell.contentView addSubview:imageView];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserAppDetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UserAppDetail"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
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
