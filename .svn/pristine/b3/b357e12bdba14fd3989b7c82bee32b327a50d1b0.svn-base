//
//  ConsultationRoomDetailViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/16.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "ConsultationRoomDetailViewController.h"
#import "SettingView.h"
#import "RoomCollectionViewCell.h"

@interface ConsultationRoomDetailViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, assign) BOOL isOpen;
@property (strong, nonatomic) IBOutlet UIImageView *backGroundIcon;
@property (nonatomic, strong) SettingView *settingView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ConsultationRoomDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(noting)];
    self.collectionView.hidden = YES;
}

- (void)noting {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pantograph:(UIButton *)sender {
    MyLog(@"缩放");
}

- (IBAction)setting:(UIButton *)sender {
    self.settingView = [[[NSBundle mainBundle] loadNibNamed:@"SettingView" owner:nil options:nil] firstObject];
    self.settingView.frame = self.view.frame;
    [self.view addSubview:self.settingView];
}

- (IBAction)cancel:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getMore:(UIButton *)sender {
    if (!self.isOpen) {
        [sender setBackgroundImage:[UIImage imageNamed:@"Gro up"] forState:UIControlStateNormal];
        self.isOpen = YES;
        self.collectionView.hidden = NO;
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"Gro  up 4"] forState:UIControlStateNormal];
        self.isOpen = NO;
        self.collectionView.hidden = YES;
    }
}

#pragma mark - UICollectionDataSource & Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RoomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyLog(@"123");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.navigationItem.title = @"基本信息";
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
