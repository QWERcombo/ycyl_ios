//
//  ConsultationRecordDetailViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/12.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "ConsultationRecordDetailViewController.h"
#import "ConferenceEvaluationTableViewCell.h"

@interface ConsultationRecordDetailViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *viewLeft;
@property (strong, nonatomic) IBOutlet UIView *viewCenter;
@property (strong, nonatomic) IBOutlet UIView *viewRight;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *centerButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ConsultationRecordDetailViewController

- (IBAction)buttonLeft:(UIButton *)sender {
    [sender setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.viewLeft.backgroundColor = [UIColor cyanColor];
    self.viewCenter.backgroundColor = [UIColor clearColor];
    self.viewRight.backgroundColor = [UIColor clearColor];
    [self.centerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}
- (IBAction)buttonCenter:(UIButton *)sender {
    [sender setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.viewCenter.backgroundColor = [UIColor cyanColor];
    self.viewLeft.backgroundColor = [UIColor clearColor];
    self.viewRight.backgroundColor = [UIColor clearColor];
    [self.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width / 3, 0) animated:NO];
}
- (IBAction)buttonRight:(UIButton *)sender {
    [sender setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.viewRight.backgroundColor = [UIColor cyanColor];
    self.viewCenter.backgroundColor = [UIColor clearColor];
    self.viewLeft.backgroundColor = [UIColor clearColor];
    [self.centerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width / 3 * 2, 0) animated:NO];
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
    self.navigationItem.title = @"会诊详情";
    [self.leftButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.viewLeft.backgroundColor = [UIColor cyanColor];
    [self configaturationScrollView];
}

- (void)configaturationScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 70, KDWidth - 20, KDHeight - 80 - 64)];
    [self.view addSubview:self.scrollView];
    self.scrollView.layer.cornerRadius = 5;
    self.scrollView.layer.borderWidth = 2;
    self.scrollView.layer.masksToBounds = YES;
    self.scrollView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.scrollView.contentSize = CGSizeMake((KDWidth - 20) * 3, KDHeight - 64 - 80);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    firstImageView.image = [UIImage imageNamed:@"Fill 143 1"];
    [self.scrollView addSubview:firstImageView];
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstImageView.frame) + 10, 20, 100, 20)];
    infoLabel.text = @"基本信息";
    [self.scrollView addSubview:infoLabel];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(firstImageView.frame) + 20, KDWidth - 20 - 30, 2)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:view1];
    UILabel *label1A = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(view1.frame) + 10, 100, 20)];
    label1A.font = [UIFont systemFontOfSize:15];
    label1A.textColor = [UIColor lightGrayColor];
    label1A.text = @"申请单号";
    [self.scrollView addSubview:label1A];
    UILabel *label1B = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1A.frame) + 50, CGRectGetMaxY(view1.frame) + 10, KDWidth - 95 - 100, 20)];
    label1B.textAlignment = NSTextAlignmentRight;
    label1B.text = @"FJ001";
    [self.scrollView addSubview:label1B];
    UILabel *label2A = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label1A.frame) + 10, 100, 20)];
    label2A.font = [UIFont systemFontOfSize:15];
    label2A.textColor = [UIColor lightGrayColor];
    label2A.text = @"患者姓名";
    [self.scrollView addSubview:label2A];
    UILabel *label2B = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2A.frame) + 50, CGRectGetMaxY(label1B.frame) + 10, KDWidth - 95 - 100, 20)];
    label2B.textAlignment = NSTextAlignmentRight;
    label2B.text = @"李四";
    [self.scrollView addSubview:label2B];
    UILabel *label3A = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label2A.frame) + 10, 100, 20)];
    label3A.font = [UIFont systemFontOfSize:15];
    label3A.textColor = [UIColor lightGrayColor];
    label3A.text = @"申请医院";
    [self.scrollView addSubview:label3A];
    UILabel *label3B = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3A.frame) + 50, CGRectGetMaxY(label2B.frame) + 10, KDWidth - 95 - 100, 20)];
    label3B.textAlignment = NSTextAlignmentRight;
    label3B.text = @"北京协和医院";
    [self.scrollView addSubview:label3B];
    UILabel *label4A = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label3A.frame) + 10, 100, 20)];
    label4A.font = [UIFont systemFontOfSize:15];
    label4A.textColor = [UIColor lightGrayColor];
    label4A.text = @"会诊名称";
    [self.scrollView addSubview:label4A];
    UILabel *label4B = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label4A.frame) + 50, CGRectGetMaxY(label3B.frame) + 10, KDWidth - 95 - 100, 20)];
    label4B.textAlignment = NSTextAlignmentRight;
    label4B.text = @"王五";
    [self.scrollView addSubview:label4B];
    UILabel *label5A = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label4A.frame) + 10, 100, 20)];
    label5A.font = [UIFont systemFontOfSize:15];
    label5A.textColor = [UIColor lightGrayColor];
    label5A.text = @"会诊级别";
    [self.scrollView addSubview:label5A];
    UILabel *label5B = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5A.frame) + 50, CGRectGetMaxY(label4B.frame) + 10, KDWidth - 95 - 100, 20)];
    label5B.textAlignment = NSTextAlignmentRight;
    label5B.text = @"普通外科";
    [self.scrollView addSubview:label5B];
    UILabel *label6A = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label5A.frame) + 10, 100, 20)];
    label6A.font = [UIFont systemFontOfSize:15];
    label6A.textColor = [UIColor lightGrayColor];
    label6A.text = @"会诊时间";
    [self.scrollView addSubview:label6A];
    UILabel *label6B = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label6A.frame) + 50, CGRectGetMaxY(label5B.frame) + 10, KDWidth - 95 - 100, 20)];
    label6B.textAlignment = NSTextAlignmentRight;
    label6B.text = @"2016.05.01 16:00";
    [self.scrollView addSubview:label6B];
    UILabel *label7A = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label6A.frame) + 10, 100, 20)];
    label7A.font = [UIFont systemFontOfSize:15];
    label7A.textColor = [UIColor lightGrayColor];
    label7A.text = @"参与人员";
    [self.scrollView addSubview:label7A];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label7A.frame) + 10, 60, 60)];
    imageView1.image = [UIImage imageNamed:@"G roup"];
    [self.scrollView addSubview:imageView1];
    UILabel *label1E = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView1.frame) + 10, 60, 20)];
    label1E.text = @"王主任";
    label1E.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label1E];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + 10, CGRectGetMaxY(label7A.frame) + 10, 60, 60)];
    imageView2.image = [UIImage imageNamed:@"G roup"];
    [self.scrollView addSubview:imageView2];
    UILabel *label2E = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + 10, CGRectGetMaxY(imageView1.frame) + 10, 60, 20)];
    label2E.text = @"李主任";
    label2E.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label2E];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + 10, CGRectGetMaxY(label7A.frame) + 10, 60, 60)];
    imageView3.image = [UIImage imageNamed:@"G roup"];
    [self.scrollView addSubview:imageView3];
    UILabel *label3E = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + 10, CGRectGetMaxY(imageView1.frame) + 10, 60, 20)];
    label3E.text = @"黄主任";
    label3E.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label3E];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label2E.frame) + 10, KDWidth - 20 - 30, 2)];
    view2.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:view2];
    UIImageView *secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(view2.frame) + 10, 20, 20)];
    secondImageView.image = [UIImage imageNamed:@"P age 1"];
    [self.scrollView addSubview:secondImageView];
    UILabel *label2f = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondImageView.frame) + 10, CGRectGetMaxY(view2.frame) + 10, 100, 20)];
    label2f.text = @"说明";
    [self.scrollView addSubview:label2f];
    UILabel *infomationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(secondImageView.frame) + 10, KDWidth - 20 - 40, KDHeight - secondImageView.frame.origin.y - 30 - 20 - 64 - 70)];
    infomationLabel.font = [UIFont systemFontOfSize:13];
    infomationLabel.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    infomationLabel.numberOfLines = 0;
    [self.scrollView addSubview:infomationLabel];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.scrollView.contentSize.width / 3, 0, self.scrollView.contentSize.width / 3, self.scrollView.contentSize.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceEvaluationTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview:self.tableView];
    
    
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.contentSize.width / 3 * 2 + 20, 20, 20, 20)];
    lastImageView.image = [UIImage imageNamed:@"Fill 1429"];
    [self.scrollView addSubview:lastImageView];
    UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lastImageView.frame) + 10, 20, 100, 20)];
    lastLabel.text = @"会诊报告";
    [self.scrollView addSubview:lastLabel];
    UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.contentSize.width / 3 * 2 + 15, CGRectGetMaxY(lastImageView.frame) + 20, KDWidth - 20 - 30, 2)];
    lastView.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:lastView];
    UILabel *lastContentLabel = [[UILabel alloc] init];
    lastContentLabel.text = @"Lorem ipsum dolor sit er elit lamet,consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    CGRect rect = [lastContentLabel.text boundingRectWithSize:CGSizeMake(KDWidth - 60, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
    lastContentLabel.frame = CGRectMake(self.scrollView.contentSize.width / 3 * 2 + 20, CGRectGetMaxY(lastView.frame) + 20, KDWidth - 20 - 40, rect.size.height);
    [self.scrollView addSubview:lastContentLabel];
    //lastContentLabel.backgroundColor = [UIColor yellowColor];
    lastContentLabel.numberOfLines = 0;
}

#pragma mark - UITableViewDataSource & Delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConferenceEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marl - UIScrollViewDelegate 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger num = self.scrollView.contentOffset.x / (self.scrollView.contentSize.width / 3);
        switch (num) {
            case 0:
                [self.leftButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
                self.viewLeft.backgroundColor = [UIColor cyanColor];
                [self.centerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                self.viewRight.backgroundColor = [UIColor clearColor];
                self.viewCenter.backgroundColor = [UIColor clearColor];
                break;
            case 1:
                [self.centerButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
                self.viewCenter.backgroundColor = [UIColor cyanColor];
                [self.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                self.viewRight.backgroundColor = [UIColor clearColor];
                self.viewLeft.backgroundColor = [UIColor clearColor];
                break;
            default:
                [self.rightButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
                self.viewRight.backgroundColor = [UIColor cyanColor];
                [self.centerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [self.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                self.viewLeft.backgroundColor = [UIColor clearColor];
                self.viewCenter.backgroundColor = [UIColor clearColor];
                break;
        }
    }
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
