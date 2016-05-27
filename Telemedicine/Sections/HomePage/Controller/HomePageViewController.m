//
//  HomePageViewController.m
//  Telemedicine
//
//  Created by RCChina on 16/5/10.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import "HomePageViewController.h"
#import "MainCollectionViewCell.h"
#import "UserInfoViewController.h"
#import "ConsultationAppViewController.h"
#import "UserApplicationViewController.h"
#import "ConsultationRecordViewController.h"
#import "ConsultationRoomViewController.h"
#import "ConsultationTimeViewController.h"

@interface HomePageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UIImageView *userIconImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sexImage;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, assign) NSInteger user_role;
@property (nonatomic, strong) NSArray *user_role2, *user_role3, *user_role4, *user_roleTest;
@property (nonatomic, strong) NSArray *imageArr2, *imageArr3, *imageArr4, *imageTest;
@end

@implementation HomePageViewController

- (NSUserDefaults *)userDefaults {
    if (_userDefaults == nil) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    MyLog(@"HomePageViewController : %@", [self.userDefaults objectForKey:@"userinfo"]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollection];
    self.view.backgroundColor = [UIColor lightTextColor];
    self.user_role2 = [NSArray arrayWithObjects:@"会诊室", @"会诊记录", @"个人中心", @"", nil];
    self.user_role3 = [NSArray arrayWithObjects:@"会诊申请", @"我的申请", @"会诊室", @"会诊记录", @"个人中心", @"", nil];
    self.user_role4 = [NSArray arrayWithObjects:@"我的申请", @"会诊室", @"会诊记录", @"会诊时刻表", @"个人中心", @"", nil];
    self.user_roleTest = [NSArray arrayWithObjects:@"会诊申请", @"我的申请", @"会诊室", @"会诊记录", @"会诊时刻表", @"个人中心",nil];
    
    self.imageArr2 = [NSArray arrayWithObjects:@"hangout-video", @"storage", @"person", @"", nil];
    self.imageArr3 = [NSArray arrayWithObjects:@"Group 3", @"Shap e", @"hangout-video", @"storage", @"person", @"", nil];
    self.imageArr4 = [NSArray arrayWithObjects:@"Shap e", @"hangout-video", @"storage", @"timer", @"person", @"", nil];
    self.imageTest = [NSArray arrayWithObjects:@"Group 3", @"Shap e", @"hangout-video", @"storage", @"timer", @"person", nil];
    self.user_role = [[self.userDefaults objectForKey:@"userinfo"][@"user_role"] integerValue];
    //self.user_role = 5;
}

- (void)createCollection {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 2;
    flowLayout.itemSize = CGSizeMake(((KDWidth - 2) / 2) , 120);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, KDWidth, KDHeight - 200) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor lightTextColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}


#pragma mark - UICollectionView Delegate Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (self.user_role) {
        case 2:
            return self.user_role2.count;
            break;
        case 3:
            return self.user_role3.count;
            break;
        case 4:
            return self.user_role4.count;
            break;
        case 5:
            return 2;
            break;
        case 6:
            return 2;
            break;
        default:
            return self.user_roleTest.count;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.user_role == 2) {
        cell.titleLabel.text = self.user_role2[indexPath.row];
        cell.topImage.image = [UIImage imageNamed:self.imageArr2[indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    if (self.user_role == 3) {
        cell.titleLabel.text = self.user_role3[indexPath.row];
        cell.topImage.image = [UIImage imageNamed:self.imageArr3[indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    if (self.user_role == 4) {
        cell.titleLabel.text = self.user_role4[indexPath.row];
        cell.topImage.image = [UIImage imageNamed:self.imageArr4[indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    if (self.user_role == 5 || self.user_role == 6) {
        if (indexPath.row == 0) {
            cell.topImage.image = [UIImage imageNamed:@"hangout-video"];
            cell.titleLabel.text = @"会诊室";
        }
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    cell.titleLabel.text = self.user_roleTest[indexPath.row];
    cell.topImage.image = [UIImage imageNamed:self.imageTest[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KDWidth, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoViewController *userVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UserInfo"];
    ConsultationAppViewController *consultationVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultationApp"];
    UserApplicationViewController *userAppVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UserApplication"];
    ConsultationRecordViewController *consultationRecordVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultationRecord"];
    ConsultationRoomViewController *consultationRoomVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"consultationRoom"];
    ConsultationTimeViewController *consultationTimeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"consultationTime"];
    if (self.user_role == 2) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:consultationRoomVC animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:consultationRecordVC animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:userVC animated:YES];
                break;
        }
        return;
    }
    
    if (self.user_role == 3) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:consultationVC animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:userAppVC animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:consultationRoomVC animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:consultationRecordVC animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:userVC animated:YES];
                break;
        }
        return;
    }
    if (self.user_role == 4) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:userAppVC animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:consultationRoomVC animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:consultationRecordVC animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:consultationTimeVC animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:userVC animated:YES];
                break;
        }
        return;
    }
    if (self.user_role == 5 || self.user_role == 6) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:consultationRoomVC animated:YES];
        }
        return;
    }
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:consultationVC animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:userAppVC animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:consultationRoomVC animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:consultationRecordVC animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:consultationTimeVC animated:YES];
            break;
        default:
            [self.navigationController pushViewController:userVC animated:YES];
            break;
    }
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
