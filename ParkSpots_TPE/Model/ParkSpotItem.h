//
//  ParkSpotItem.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkSpotItem : NSObject <NSCopying>

@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *introduction;
@property (nonatomic,strong) NSString *spotName;
@property (nonatomic,strong) NSString *openTime;
@property (nonatomic,strong) NSString *parkName;
@property (nonatomic,strong) NSString *yearBuilt;
@property (nonatomic,strong) NSString *parkSpotId;

+ (ParkSpotItem*)initWithDictionary:(NSDictionary*)dic;
+ (NSArray*)initWithArray:(NSArray*)array;
@end
