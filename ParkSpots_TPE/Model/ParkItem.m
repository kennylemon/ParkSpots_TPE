//
//  ParkItem.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "ParkItem.h"

@implementation ParkItem

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (ParkItem*)copyWithZone:(NSZone*)zone {
    
    ParkItem* copiedItem = [[ParkItem allocWithZone:zone] init];
    copiedItem.administrativeArea = [self.administrativeArea copy];
    copiedItem.area = [self.area copy];
    copiedItem.image = [self.image copy];
    copiedItem.introduction = [self.introduction copy];
    copiedItem.latitude = [self.latitude copy];
    copiedItem.location = [self.location copy];
    copiedItem.longtitude = [self.longtitude copy];
    copiedItem.mngTel = [self.mngTel copy];
    copiedItem.mngName = [self.mngName copy];
    copiedItem.openTime = [self.openTime copy];
    copiedItem.parkName = [self.parkName copy];
    copiedItem.parkType = [self.parkType copy];
    copiedItem.yearBuilt = [self.yearBuilt copy];
    copiedItem.parkId = [self.parkId copy];
    
    return copiedItem;
}

+ (ParkItem*)initWithDictionary:(NSDictionary*)dic
{
    if ( !dic || ![dic isKindOfClass:[NSDictionary class]] ) {
        return nil;
    }
    ParkItem* item = [[ParkItem alloc] init];
    
    item.administrativeArea = [dic objectForKey:@"AdministrativeArea"];
    item.area = [dic objectForKey:@"Area"];
    item.image = [dic objectForKey:@"Image"];
    item.introduction = [dic objectForKey:@"Introduction"];
    item.latitude = [dic objectForKey:@"Latitude"];
    item.location = [dic objectForKey:@"Location"];
    item.longtitude = [dic objectForKey:@"Longtitude"];
    item.mngTel = [dic objectForKey:@"ManageTelephone"];
    item.mngName = [dic objectForKey:@"ManagementName"];
    item.openTime = [dic objectForKey:@"OpenTime"];
    item.parkName = [dic objectForKey:@"ParkName"];
    item.parkType = [dic objectForKey:@"ParkType"];
    item.yearBuilt = [dic objectForKey:@"YearBuilt"];
    item.parkId = [dic objectForKey:@"_id"];
    
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
            ParkItem* item = [ParkItem initWithDictionary:dic];
            if ( item ) {
                [itemList addObject:item];
            }
        }
    }
    
    return [[NSArray alloc] initWithArray:itemList copyItems:YES];;
}

@end
