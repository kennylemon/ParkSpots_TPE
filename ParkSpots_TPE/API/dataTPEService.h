//
//  dataTPEService.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataTPEService : NSObject

+ (instancetype)instance;

- (void)getParkSpotsWithOffset:(NSUInteger)offset
                       success:(void (^)(NSUInteger, NSUInteger, NSUInteger, NSDictionary*))successHandler
                          fail:(void (^)(NSError*))failHandler;

@end
