//
//  ParkSpotItem.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "ParkSpotItem.h"

@implementation ParkSpotItem

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (ParkSpotItem*)copyWithZone:(NSZone*)zone {
    
    ParkSpotItem* copiedItem = [[ParkSpotItem allocWithZone:zone] init];
    copiedItem.imgUrl = [self.imgUrl copy];
    copiedItem.introduction = [self.introduction copy];
    copiedItem.spotName = [self.spotName copy];
    copiedItem.openTime = [self.openTime copy];
    copiedItem.parkName = [self.parkName copy];
    copiedItem.yearBuilt = [self.yearBuilt copy];
    copiedItem.parkSpotId = [self.parkSpotId copy];
    
    return copiedItem;
}

+ (ParkSpotItem*)initWithDictionary:(NSDictionary*)dic
{
    if ( !dic || ![dic isKindOfClass:[NSDictionary class]] ) {
        return nil;
    }
    ParkSpotItem* item = [[ParkSpotItem alloc] init];
    item.imgUrl = [dic objectForKey:@"Image"];
    item.introduction = [dic objectForKey:@"Introduction"];
    item.spotName = [dic objectForKey:@"Name"];
    item.openTime = [dic objectForKey:@"OpenTime"];
    item.parkName = [dic objectForKey:@"ParkName"];
    item.yearBuilt = [dic objectForKey:@"YearBuilt"];
    item.parkSpotId = [dic objectForKey:@"_id"];
    
    return item;
}

+ (NSArray*)initWithArray:(NSArray*)array
{
    if ( !array || ![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    
    NSMutableArray *itemList = [[NSMutableArray alloc] init];
    if ( array.count > 0 ) {
        for ( NSDictionary *dic in array) {
            ParkSpotItem* item = [ParkSpotItem initWithDictionary:dic];
            if ( item ) {
                [itemList addObject:item];
            }
        }
    }
    
    return [[NSArray alloc] initWithArray:itemList copyItems:YES];;
}

@end
