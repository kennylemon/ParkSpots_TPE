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

#import "PSDImageVC.h"
#import "PSDInfoVC.h"
#import "PSDIntroVC.h"
#import "PSDRelatedVC.h"


// PSD -> Park Spot Detail
typedef NS_ENUM(NSInteger, PSDetailCellType) {
    PSDCellImg = 0,
    PSDCellInfo,
    PSDCellIntro,
    PSDCellRelated,
    PSDTotalCellType
};

@interface ParkSpotDetailVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ParkSpotItem* PSItem;
@property (strong, nonatomic) NSMutableArray<UIViewController*> *parkItemInfoVCList;
@end

@implementation ParkSpotDetailVC


- (void)dealloc {
    self.tableview.dataSource = nil;
    self.tableview.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parkItemInfoVCList = [[NSMutableArray alloc] init];
    
    for ( ParkSpotItem* item in self.parkSpotList ) {
        if ([item.spotName isEqualToString:self.currentSelectedSpotName]) {
            self.PSItem = [item copy];
            break;
        }
    }
    
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
                }
            }
            
            if (vc) {
                [self.parkItemInfoVCList addObject:vc];
            }
            
        }
    }
    
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

    return self.parkItemInfoVCList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( indexPath.row < self.parkItemInfoVCList.count ) {
        UIViewController* infoVC = [self.parkItemInfoVCList objectAtIndex:indexPath.row];
        return CGRectGetHeight(infoVC.view.frame);
    }
    
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"PSDTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }

    if ( indexPath.row < self.parkItemInfoVCList.count ) {
        UIViewController* vc = [self.parkItemInfoVCList objectAtIndex:indexPath.row];
        cell.frame = vc.view.frame;
        [cell addSubview:vc.view];
    }
    
    return cell;
}

- (IBAction)backToPSList:(id)sender {
    [[FlowManager instance] popViewController];
}

@end
