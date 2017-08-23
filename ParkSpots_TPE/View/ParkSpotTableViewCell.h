//
//  ParkSpotTableViewCell.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkSpotTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *parkName;
@property (weak, nonatomic) IBOutlet UILabel *parkSpotName;
@property (weak, nonatomic) IBOutlet UIImageView *parkImg;
@end
