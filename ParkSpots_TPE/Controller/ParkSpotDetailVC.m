//
//  ParkSpotDetailVC.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "ParkSpotDetailVC.h"
#import "Definitions.h"
#import "ParkSpotItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FlowManager.h"

//#import "PSDImageVC.h"
//#import "PSDInfoVC.h"
//#import "PSDIntroVC.h"
//#import "PSDRelatedVC.h"

#import "PSDImgTableviewCell.h"
#import "PSDInfoTableviewCell.h"
#import "PSDIntroTableviewCell.h"
#import "PSDRelateTableviewCell.h"


// PSD -> Park Spot Detail
typedef NS_ENUM(NSInteger, PSDetailCellType) {
    PSDCellImg = 0,
    PSDCellInfo,
    PSDCellIntro,
    PSDCellRelated,
    PSDTotalCellType
};

@interface ParkSpotDetailVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, PSDRelatedDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ParkSpotItem* PSItem;
@property (strong, nonatomic) NSMutableArray<UIViewController*> *parkItemInfoVCList;
@property (strong, nonatomic) NSMutableArray<ParkSpotItem*> *relatedPSItems;
@property (assign, nonatomic) BOOL isImgAvailable;
@end

@implementation ParkSpotDetailVC


- (void)dealloc {
    self.tableview.dataSource = nil;
    self.tableview.delegate = nil;
}

- (void)updateCurrentSelectedParkSpotItem {
    for ( ParkSpotItem* item in self.parkSpotList ) {
        if ([item.spotName isEqualToString:self.currentSelectedSpotName]) {
            self.PSItem = [item copy];
            break;
        }
    }
}

- (void)createParkSpotDetailUI {
    
    BOOL bJpg = [[self.PSItem.imgUrl lowercaseString] containsString:@".jpg"];
    BOOL bPng = [[self.PSItem.imgUrl lowercaseString] containsString:@".png"];
    if (self.PSItem.imgUrl.length>0 && (bJpg||bPng)) {
        self.isImgAvailable = YES;
    } else {
        self.isImgAvailable = NO;
    }
    
    for (ParkSpotItem* item in self.parkSpotList) {
        if (![item.spotName isEqualToString:self.PSItem.spotName]) {
            [self.relatedPSItems addObject:item];
        }
    }
    
    /*
    for (int idx = 0; idx< PSDTotalCellType; idx++) {
     
        if (self.PSItem) {
     
            UIViewController* vc;
            if (idx==PSDCellImg) {
                
                BOOL bJpg = [[self.PSItem.imgUrl lowercaseString] containsString:@".jpg"];
                BOOL bPng = [[self.PSItem.imgUrl lowercaseString] containsString:@".png"];
                if (self.PSItem.imgUrl.length>0 && (bJpg||bPng)) {
                    vc = [[PSDImageVC alloc] initWithImgUrl:self.PSItem.imgUrl];
                }
            } else if (idx==PSDCellInfo) {
                vc = [[PSDInfoVC alloc] initWithInfo:self.PSItem.parkName spotName:self.PSItem.spotName openTime:self.PSItem.openTime];
            } else if (idx==PSDCellIntro) {
                vc = [[PSDIntroVC alloc] initWithItro:self.PSItem.introduction];
            } else if (idx==PSDCellRelated) {
                
                NSMutableArray* filterArray = [[NSMutableArray alloc] init];
                for (ParkSpotItem* item in self.parkSpotList) {
                    if (![item.spotName isEqualToString:self.PSItem.spotName]) {
                        [filterArray addObject:item];
                    }
                }
                if ( filterArray.count > 0 ) {
                    vc = [[PSDRelatedVC alloc] initWithRelated:self.PSItem.spotName relatedItems:filterArray];
                    ((PSDRelatedVC*)vc).delegate = self;
                }
            }
            
            if (vc) {
                [self.parkItemInfoVCList addObject:vc];
            }
            
        }
    }
     */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parkItemInfoVCList = [[NSMutableArray alloc] init];
    self.relatedPSItems = [[NSMutableArray alloc] init];
    [self updateCurrentSelectedParkSpotItem];
    [self createParkSpotDetailUI];

    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 45;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    return self.parkItemInfoVCList.count;
    int defaultComponent = 4;
    if (!self.isImgAvailable) {
        defaultComponent--;
    }
    
    if ( self.relatedPSItems.count == 0 ) {
        defaultComponent--;
    }
    
    return defaultComponent;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( indexPath.row < self.parkItemInfoVCList.count ) {
        UIViewController* infoVC = [self.parkItemInfoVCList objectAtIndex:indexPath.row];
        NSLog(@"indexpath row = %d, contentvc = %@", indexPath.row, NSStringFromCGRect(infoVC.view.frame));
        return CGRectGetHeight(infoVC.view.frame);
    }
    
    return 44;
}
*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableviewCell;

    if ( indexPath.row == PSDCellImg) {
        NSString *identifier = @"PSDImgTableviewCell";
        PSDImgTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        [cell.PSDImgView sd_setImageWithURL:[NSURL URLWithString:self.PSItem.imgUrl]];
        tableviewCell = cell;
    } else if ( indexPath.row == PSDCellInfo ) {
        NSString *identifier = @"PSDInfoTableviewCell";
        PSDInfoTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.parkNameL.text = self.PSItem.parkName;
        cell.spotNameL.text = self.PSItem.spotName;
        cell.openTimeL.text = self.PSItem.openTime;
        
        tableviewCell = cell;
    } else if ( indexPath.row == PSDCellIntro ) {
        NSString *identifier = @"PSDIntroTableviewCell";
        PSDIntroTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.introL.text = self.PSItem.introduction;
        
        tableviewCell = cell;
    } else if ( indexPath.row == PSDCellRelated ) {
        NSString *identifier = @"PSDRelateTableviewCell";
        PSDRelateTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        NSMutableArray* filterArray = [[NSMutableArray alloc] init];
        for (ParkSpotItem* item in self.parkSpotList) {
            if (![item.spotName isEqualToString:self.PSItem.spotName]) {
                [filterArray addObject:item];
            }
        }
        if ( filterArray.count > 0 ) {
            [cell setRelatedItems:filterArray];
            cell.delegate = self;
        }

        tableviewCell = cell;
    }
    else {
        tableviewCell = [[UITableViewCell alloc] init];
    }
    
    /*
    static NSString *identifier = @"PSDTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }

    if ( indexPath.row < self.parkItemInfoVCList.count ) {
        UIViewController* vc = [self.parkItemInfoVCList objectAtIndex:indexPath.row];
        cell.frame = vc.view.frame;
        NSLog(@"indexpath row = %d, contentvc = %@", indexPath.row, NSStringFromCGRect(vc.view.frame));
        NSLog(@"indexpath row = %d, cell = %@", indexPath.row, NSStringFromCGRect(cell.frame));
        [cell addSubview:vc.view];
    }
     */
    
    return tableviewCell;
}

- (IBAction)backToPSList:(id)sender {
    [[FlowManager instance] popViewController];
}


#pragma mark - PSDRelatedDelegate
- (void)onSelectedParkSpot:(ParkSpotItem*)selectedPSItem {
    
    if (selectedPSItem) {
        dispatch_async( dispatch_get_global_queue(0, 0), ^{
            self.currentSelectedSpotName = selectedPSItem.spotName;
            [self updateCurrentSelectedParkSpotItem];
            if (self.parkItemInfoVCList.count) {
                [self.parkItemInfoVCList removeAllObjects];
            }
            [self createParkSpotDetailUI];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
        });
    }
}
@end
