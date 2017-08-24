//
//  Definitions.h
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/22.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#ifndef Definitions_h
#define Definitions_h

// 臺北市公園、綠地、廣場內重要景點介紹
static NSString * const PST_SPOT_RID = @"bf073841-c734-49bf-a97f-3757a6013812";

// API related
static NSString * const PST_API_URL = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire";
static NSString * const PST_API_LIMIT = @"100";
static NSString * const PST_QRY_RID = @"&rid=%@";
static NSString * const PST_QRY_QSTATEMENT = @"&q=%@";
static NSString * const PST_QRY_LIMIT = @"&limit=%@";
static NSString * const PST_QRY_OFFSET = @"&offset=%@";

// trigger lazy loading before section
static int const TLLBS_COUNT = 10;

static NSString * const SHOW_PARKSPOTDETAILVC = @"ParkSpotDetail";

// park spot detail cell type reuse id
static NSString * const PSD_RCMD_CELL = @"PSDRcmdCell";



#endif /* Definitions_h */
