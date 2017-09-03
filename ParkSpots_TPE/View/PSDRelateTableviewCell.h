//
//  PSDRelateTableviewCell.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/30.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParkSpotItem;
@protocol PSDRelatedDelegate <NSObject>

@optional
- (void)onSelectedParkSpot:(ParkSpotItem*)selectedPSItem;
@end

@interface PSDRelateTableviewCell : UITableViewCell

@property (nonatomic, weak) id<PSDRelatedDelegate> delegate;
@property (strong, nonatomic) NSArray<ParkSpotItem*>* relatedItems;

- (void)reloadData;
@end
