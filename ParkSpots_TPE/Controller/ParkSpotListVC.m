//
//  ParkSpotListVC.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/21.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "ParkSpotListVC.h"
#import "Utilities.h"
#import "Definitions.h"
#import "ParkSpotItem.h"
#import "dataTPEService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ParkSpotTableViewCell.h"
#import "ParkSpotDetailVC.h"
#import "FlowManager.h"
#import "UIImage+Helper.h"

@interface ParkSpotListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSUInteger currentOffset;
@property (nonatomic, assign) NSUInteger lastGetAPISection;
@property (nonatomic, strong) NSIndexPath *selectedIdx;
@property (nonatomic, strong) NSMutableDictionary<NSString*,NSArray*> *parkSpotList;
@property (nonatomic, strong) NSMutableArray<NSString*> *parkKeyList;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ParkSpotListVC


- (void)dealloc {
    self.tableview.dataSource = nil;
    self.tableview.delegate = nil;
}

-(void)dataInit {
    self.currentOffset = 0;
    self.lastGetAPISection = 0;
    self.parkSpotList = [[NSMutableDictionary alloc] init];
    self.parkKeyList = [[NSMutableArray alloc] init];
    
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 45;
}

- (void)getParkSpotsData {
    
    __weak ParkSpotListVC* tmpSelf = self;//使用weak物件不會被retain
    [[dataTPEService instance] getParkSpotsWithOffset:_currentOffset success:^(NSUInteger count, NSUInteger limit, NSUInteger offset, NSDictionary *parkSpostsList) {
        
        
        dispatch_async( dispatch_get_global_queue(0, 0), ^{
            NSLog(@"currentoffset = %ld, limit = %ld", tmpSelf.currentOffset, limit);
            tmpSelf.currentOffset = tmpSelf.currentOffset + limit;
            
            NSMutableArray *newParkKeyList = [[NSMutableArray alloc] init];
            for ( NSString* parkKey in [parkSpostsList allKeys]) {
                
                if ([tmpSelf.parkKeyList containsObject:parkKey]) {
                    
                    NSMutableArray* resultParkSpots = [NSMutableArray arrayWithArray:[tmpSelf.parkSpotList objectForKey:parkKey]];
                    NSArray* newParkSpots = [parkSpostsList objectForKey:parkKey];
                    [resultParkSpots addObjectsFromArray:newParkSpots];
                    [tmpSelf.parkSpotList setObject:resultParkSpots forKey:parkKey];
                } else {
                    [newParkKeyList addObject:parkKey];
                    [tmpSelf.parkSpotList setObject:[parkSpostsList objectForKey:parkKey] forKey:parkKey];
                }
            }
            [tmpSelf.parkKeyList addObjectsFromArray:newParkKeyList];

            
            //
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
            
            
            NSUInteger nTotalParkSpots = 0;
            for ( NSArray* parkSpotList in [tmpSelf.parkSpotList allValues]) {
                nTotalParkSpots = nTotalParkSpots+parkSpotList.count;
            }
        });
        
        
    } fail:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self dataInit];
    
    [self getParkSpotsData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _parkSpotList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.parkKeyList.count>section) {
        NSArray<ParkSpotItem*> *itemlist = [_parkSpotList objectForKey:[self.parkKeyList objectAtIndex:section]];
        return itemlist.count;
    } else {
        return 0;
    }
    
}

#pragma mark - UITableViewDelegate
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.parkKeyList.count>section) {
        return [self.parkKeyList objectAtIndex:section];
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseId = @"ParkSpotTableViewCell";
    ParkSpotTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];

    ParkSpotItem* item = nil;
    if (_parkKeyList.count>indexPath.section) {
        NSString* parkKey = [_parkKeyList objectAtIndex:indexPath.section];
        NSArray* spotList = [_parkSpotList objectForKey:parkKey];
        if (spotList.count>indexPath.row) {
            item = [spotList objectAtIndex:indexPath.row];
            cell.parkName.text = item.parkName;
            cell.parkSpotName.text = item.spotName;
            cell.introduction.text = item.introduction;
            [cell.parkImg sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]];
        }
    }
    
    NSLog(@"=== row = %ld ====", indexPath.row);
    NSLog(@"cell frame = %@, contentview frame = %@", NSStringFromCGRect(cell.frame),NSStringFromCGRect(cell.contentView.frame));
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIdx = [indexPath copy];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ParkSpotDetailVC *destVC = [storyboard instantiateViewControllerWithIdentifier:@"ParkSpotDetailVC"];
    
    if (self.parkKeyList.count>self.selectedIdx.section) {
        NSString* key = [self.parkKeyList objectAtIndex:self.selectedIdx.section];
        
        NSArray* array = [self.parkSpotList objectForKey:key];
        if (array) {
            destVC.parkSpotList = [[NSArray alloc] initWithArray:array copyItems:YES];
        }
        
        
        ParkSpotItem* PSItem = [array objectAtIndex:self.selectedIdx.row];
        destVC.currentSelectedSpotName = PSItem.spotName;
    }
    
    [[FlowManager instance] pushViewController:destVC];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger lazyLoadingSection = (self.parkKeyList.count - TLLBS_COUNT);
    if ( ( lazyLoadingSection == indexPath.section) && (self.lastGetAPISection != indexPath.section) ) {
        self.lastGetAPISection = indexPath.section;
        [self getParkSpotsData];
    }
}

@end
