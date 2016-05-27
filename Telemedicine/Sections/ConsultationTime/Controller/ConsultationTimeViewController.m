//
//  ConsultationTimeViewController.m
//  Telemedicine
//
//  Created by 徐云鹏 on 16/5/15.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ConsultationTimeViewController.h"
#import "LDCalendarView.h"
#import "ArrangeView.h"

@interface ConsultationTimeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)LDCalendarView *calendarView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)ArrangeView *arrangeView;
@property (nonatomic, strong)UIView *backView;
@end

@implementation ConsultationTimeViewController

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
        [self.dataSource addObject:@"8:00~11:00"];
        [self.dataSource addObject:@"添加会诊安排"];
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
    self.navigationController.navigationBar.translucent = NO;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会诊时刻表";
    self.calendarView = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, KDWidth,KDWidth+50)];
//    self.calendarView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.calendarView];
    [self createTableView];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarView.frame), KDWidth, KDHeight - CGRectGetMaxY(self.calendarView.frame)) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == self.dataSource.count - 1) {
        cell.textLabel.textColor = [UIColor cyanColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.dataSource.count - 1) {
        self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.backView.backgroundColor = [UIColor blackColor];
        self.backView.alpha = 0.3;
        [self.view addSubview:self.backView];
        self.arrangeView = [[[NSBundle mainBundle] loadNibNamed:@"ArrangeView" owner:nil options:nil] firstObject];
        self.arrangeView.frame = self.view.bounds;
        [self.view addSubview:self.arrangeView];
        [self.arrangeView.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self.arrangeView.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)cancel {
    [self.backView removeFromSuperview];
    [self.arrangeView removeFromSuperview];
}

- (void)confirm {
    MyLog(@"确定");
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
