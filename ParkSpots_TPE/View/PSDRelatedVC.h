//
//  PSDRelatedVC.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSDRelatedVC;
@class ParkSpotItem;
@protocol PSDRelatedDelegate <NSObject>

@optional
- (void)onSelectedParkSpot:(ParkSpotItem*)selectedPSItem;
@end

@interface PSDRelatedVC : UIViewController

@property (nonatomic, weak) id<PSDRelatedDelegate> delegate;
@property (nonatomic, strong) UITableView* parentTableview;
- (instancetype)initWithRelated:(NSString *)selectedSpot relatedItems:(NSArray*)relatedItems;
@end
