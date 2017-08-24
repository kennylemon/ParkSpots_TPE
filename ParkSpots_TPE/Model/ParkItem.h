//
//  ParkItem.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkItem : NSObject <NSCopying>

@property (nonatomic,strong) NSString *administrativeArea;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *introduction;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSString *longtitude;
@property (nonatomic,strong) NSString *mngTel;
@property (nonatomic,strong) NSString *mngName;
@property (nonatomic,strong) NSString *openTime;
@property (nonatomic,strong) NSString *parkName;
@property (nonatomic,strong) NSString *parkType;
@property (nonatomic,strong) NSString *yearBuilt;
@property (nonatomic,strong) NSString *parkId;

+ (ParkItem*)initWithDictionary:(NSDictionary*)dic;
+ (NSArray*)initWithArray:(NSArray*)array;
@end
