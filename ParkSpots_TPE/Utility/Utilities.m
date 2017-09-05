//
//  Utilities.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "Utilities.h"
#import "Definitions.h"

@implementation Utilities

+ (NSString*)apiUrlWithRid:(NSString*)rid {
    
    NSString* qry = [NSString stringWithFormat:PST_QRY_RID, rid];
    NSString* result = [NSString stringWithFormat:@"%@%@", PST_API_URL, qry];
    
    return result;
}

+ (NSString*)apiUrlWithRid:(NSString*)rid withQry:(NSString*)query{
    
    NSString* qry = [NSString stringWithFormat:PST_QRY_RID, rid];
    qry = [qry stringByAppendingFormat:PST_QRY_QSTATEMENT, query];
    NSString* result = [NSString stringWithFormat:@"%@%@", PST_API_URL, qry];
    
    return result;
}

+ (NSString*)apiUrlWithRid:(NSString*)rid withLimt:(NSUInteger)limit withOffset:(NSUInteger)offset {
    
    NSString* qry = [NSString stringWithFormat:PST_QRY_RID, rid];
    qry = [qry stringByAppendingFormat:PST_QRY_LIMIT, [NSString stringWithFormat:@"%li", limit]];
    qry = [qry stringByAppendingFormat:PST_QRY_OFFSET, [NSString stringWithFormat:@"%li", offset]];
    NSString* result = [NSString stringWithFormat:@"%@%@", PST_API_URL, qry];
    
    return result;
}

@end
