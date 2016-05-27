//
//  BaseInfomationViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/17.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "BaseInfomationViewController.h"
#import "RoomCollectionViewCell.h"

@interface BaseInfomationViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (strong, nonatomic) IBOutlet UILabel *consultationLabel;
@property (strong, nonatomic) IBOutlet UILabel *styleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BaseInfomationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 70, 20);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //[button setBackgroundImage:[UIImage imageNamed:@"Fill 241"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    imageView.image = [UIImage imageNamed:@"Fill 241"];
    [button addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 20)];
    label.text = @"会诊室";
    label.font = [UIFont systemFontOfSize:15];
    [button addSubview:label];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"基本信息";
}

#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RoomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyLog(@"di");
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
