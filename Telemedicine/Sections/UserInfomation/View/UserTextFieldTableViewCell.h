//
//  UserTextFieldTableViewCell.h
//  Telemedicine
//
//  Created by RCChina on 16/5/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTextFieldTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *contentTF;

@end
