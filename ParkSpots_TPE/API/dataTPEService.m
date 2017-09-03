//
//  dataTPEService.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "dataTPEService.h"
#import "AFHTTPSessionManager.h"
#import "Utilities.h"
#import "Definitions.h"
#import "ParkSpotItem.h"



@interface dataTPEService () {
    AFHTTPSessionManager *afSessionMngr;
}

@end


@implementation dataTPEService

+ (instancetype)instance
{
    static dataTPEService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[dataTPEService alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    
    afSessionMngr = [AFHTTPSessionManager manager];
    [afSessionMngr.requestSerializer setTimeoutInterval:10];
    ((AFJSONResponseSerializer *)afSessionMngr.responseSerializer).removesKeysWithNullValues = YES;

    return self;
}

- (void)getData:(NSString*)url
        success:(void (^)(NSUInteger, NSUInteger, NSUInteger, NSArray*))successHandler
           fail:(void (^)(NSError*))failHandler {
    
    [afSessionMngr GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        dispatch_async( dispatch_get_global_queue(0, 0), ^{
            NSUInteger count = 0;
            NSUInteger limit = 0;
            NSUInteger offset = 0;
            NSArray *itemList;
            
            NSDictionary* dic = [responseObject objectForKey:@"result"];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                count = [[dic objectForKey:@"count"] unsignedLongValue];
                limit = [[dic objectForKey:@"limit"] unsignedLongValue];
                offset = [[dic objectForKey:@"offset"] unsignedLongValue];
                itemList = [dic objectForKey:@"results"];
            }
            
            successHandler(count, limit, offset, itemList);
        });
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failHandler(error);
    }];

}

- (void)getParkSpotsWithOffset:(NSUInteger)offset
                       success:(void (^)(NSUInteger, NSUInteger, NSUInteger, NSDictionary*))successHandler
                          fail:(void (^)(NSError*))failHandler {
    
    NSString* api = [Utilities apiUrlWithRid:PST_SPOT_RID withLimt:PST_API_LIMIT withOffset:offset];
    
    NSLog(@"api = %@", api);
    [self getData:api success:^(NSUInteger count, NSUInteger limit, NSUInteger offset, NSArray *itemList) {

        // API 回傳的資料就是依照 ParkName 排序
        NSArray *parkSpotList = [ParkSpotItem initWithArray:itemList];
        NSMutableDictionary<NSString*, NSArray*> *dicParksSpots = [[NSMutableDictionary alloc] init];
        
        ParkSpotItem* spotItem = [parkSpotList firstObject];
        NSString* lastSpotName;
        if (spotItem) {
            NSMutableArray<ParkSpotItem*> *parkSpots = [[NSMutableArray alloc] init];
            lastSpotName = spotItem.parkName;
            for (ParkSpotItem* item in parkSpotList) {
                
                if ([item.parkName isEqualToString:lastSpotName]) {
                    [parkSpots addObject:item];
                    
                    if (item == [parkSpotList lastObject]) {
                        NSArray<ParkSpotItem*>* parkSpotsResult = [[NSArray alloc] initWithArray:parkSpots copyItems:YES];
                        [dicParksSpots setObject:parkSpotsResult forKey:lastSpotName];
                    }
                } else {
                    NSArray<ParkSpotItem*>* parkSpotsResult = [[NSArray alloc] initWithArray:parkSpots copyItems:YES];
                    [dicParksSpots setObject:parkSpotsResult forKey:lastSpotName];
                    
                    [parkSpots removeAllObjects];
                    // 新的 parkname 對應重新建立 parkspotlist
                    [parkSpots addObject:item];
                    lastSpotName = item.parkName;
                }
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            successHandler(count, limit, offset, dicParksSpots);
        });
    } fail:^(NSError *error) {
        failHandler(error);
    }];
}

@end
