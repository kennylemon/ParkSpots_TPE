//
//  Definitions.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/22.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#ifndef Definitions_h
#define Definitions_h

// 臺北市公園、綠地、廣場資料
//static NSString * const PST_PARK_RID = @"8f6fcb24-290b-461d-9d34-72ed1b3f51f0";
// 臺北市公園、綠地、廣場內重要景點介紹
static NSString * const PST_SPOT_RID = @"bf073841-c734-49bf-a97f-3757a6013812";

// get
static NSString * const PST_API_URL = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire";
static NSString * const PST_QRY_RID = @"&rid=%@";
static NSString * const PST_QRY_QSTATEMENT = @"&q=%@";
static NSString * const PST_QRY_LIMIT = @"&limit=%@";
static NSString * const PST_QRY_OFFSET = @"&offset=%@";

#endif /* Definitions_h */
