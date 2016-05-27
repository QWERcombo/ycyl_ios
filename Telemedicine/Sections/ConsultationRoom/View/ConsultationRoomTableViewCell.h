//
//  ConsultationRoomTableViewCell.h
//  Telemedicine
//
//  Created by RCChina on 16/5/16.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultationRoomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *styleLabel;
@property (strong, nonatomic) IBOutlet UILabel *doctorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *stateImageView;

@end
