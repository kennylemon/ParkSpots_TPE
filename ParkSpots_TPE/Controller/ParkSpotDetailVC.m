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
@property (strong, nonatomic) NSMutableArray<ParkSpotItem*> *relatedPSItems;
@property (assign, nonatomic) BOOL isImgAvailable;

@end


static int const DEF_PSD_TOTAL_CELL = 4;

@implementation ParkSpotDetailVC


- (void)dealloc {
    self.tableview.dataSource = nil;
    self.tableview.delegate = nil;
}


- (void)updateDetailData {
    
    BOOL bJpg = [[self.PSItem.imgUrl lowercaseString] containsString:@".jpg"];
    BOOL bPng = [[self.PSItem.imgUrl lowercaseString] containsString:@".png"];
    if ( (self.PSItem.imgUrl.length > 0 ) && ( bJpg || bPng ) ) {
        self.isImgAvailable = YES;
    } else {
        self.isImgAvailable = NO;
    }
    
    if ( !self.relatedPSItems ) {
        self.relatedPSItems = [[NSMutableArray alloc] init];
    }
    for ( ParkSpotItem* item in self.parkSpotList ) {
        if (![item.spotName isEqualToString:self.PSItem.spotName]) {
            [self.relatedPSItems addObject:item];
        }
    }
}

- (void)setCurrentSelectedSpotName:(NSString*)selectedParkSpot {
    _currentSelectedSpotName = selectedParkSpot;
    
    for ( ParkSpotItem* item in self.parkSpotList ) {
        if ([item.spotName isEqualToString:self.currentSelectedSpotName]) {
            self.PSItem = [item copy];
            break;
        }
    }
    
    [self updateDetailData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    int defaultComponent = DEF_PSD_TOTAL_CELL;
    
    if ( !self.isImgAvailable ) {
        defaultComponent--;
    }
    
    if ( self.relatedPSItems.count == 0 ) {
        defaultComponent--;
    }
    
    return defaultComponent;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableviewCell;

    int nIdxExtent = self.isImgAvailable ? 0 : -1;
    
    if ( indexPath.row == PSDCellImg + nIdxExtent ) {
        NSString *identifier = @"PSDImgTableviewCell";
        PSDImgTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        [cell.PSDImgView sd_setImageWithURL:[NSURL URLWithString:self.PSItem.imgUrl]];
        tableviewCell = cell;
    } else if ( indexPath.row == PSDCellInfo + nIdxExtent ) {
        NSString *identifier = @"PSDInfoTableviewCell";
        PSDInfoTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.parkNameL.text = self.PSItem.parkName;
        cell.spotNameL.text = self.PSItem.spotName;
        cell.openTimeL.text = self.PSItem.openTime;
        
        tableviewCell = cell;
    } else if ( indexPath.row == PSDCellIntro + nIdxExtent ) {
        NSString *identifier = @"PSDIntroTableviewCell";
        PSDIntroTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.introL.text = self.PSItem.introduction;
        
        tableviewCell = cell;
    } else if ( indexPath.row == PSDCellRelated + nIdxExtent ) {
        NSString *identifier = @"PSDRelateTableviewCell";
        PSDRelateTableviewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        NSPredicate* filter = [NSPredicate predicateWithFormat:@"NOT (spotName IN %@)", self.PSItem.spotName];
        NSArray* filterArray = [self.parkSpotList filteredArrayUsingPredicate:filter];
        
        if ( filterArray.count > 0 ) {
            [cell setRelatedItems:filterArray];
            cell.delegate = self;
        }

        tableviewCell = cell;
    }
    else {
        tableviewCell = [[UITableViewCell alloc] init];
    }
    
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
        });
    }
}
@end
