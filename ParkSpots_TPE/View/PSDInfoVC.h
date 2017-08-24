//
//  PSDInfoVC.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSDInfoVC : UIViewController

- (instancetype)initWithInfo:(NSString*)parkName
                    spotName:(NSString*)spotName
                    openTime:(NSString*)openTime;
@end
