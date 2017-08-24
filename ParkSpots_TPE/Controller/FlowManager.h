//
//  FlowManager.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlowManager : NSObject

+ (FlowManager *)instance;
- (void)pushViewController:(UIViewController*)vc;
- (void)popViewController;
@end
