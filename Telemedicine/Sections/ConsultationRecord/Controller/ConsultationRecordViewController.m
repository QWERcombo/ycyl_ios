//
//  ConsultationRecordViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/12.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "ConsultationRecordViewController.h"
#import "ConsultationRecordDetailViewController.h"
#import "ConsultationRecordTableViewCell.h"
#import "ReportViewController.h"

@interface ConsultationRecordViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ConsultationRecordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
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

- (void)search {
    MyLog(@"筛选");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会诊记录";
}

#pragma mark - UITableViewDataSource & Delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsultationRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.writeButton addTarget:self action:@selector(getIntoWrite) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)getIntoWrite {
    ReportViewController *reportVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"report"];
    [self.navigationController pushViewController:reportVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ConsultationRecordDetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultationRecordDetail"];
    [self.navigationController pushViewController:detailVC animated:YES];
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
