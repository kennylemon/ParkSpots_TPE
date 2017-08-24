//
//  Utilities.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject


+ (NSString*)apiUrlWithRid:(NSString*)rid;

+ (NSString*)apiUrlWithRid:(NSString*)rid withLimt:(NSString*)limit withOffset:(NSUInteger)offset;

@end
