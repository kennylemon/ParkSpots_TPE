//
//  ParkListVC.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/21.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "ParkListVC.h"
#import "Utilities.h"
#import "Definitions.h"
#import "ParkSpotItem.h"
#import "dataTPEService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ParkSpotTableViewCell.h"


@interface ParkListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSUInteger currentOffset;
@property (nonatomic, strong) NSMutableDictionary<NSString*,NSArray*> *parkSpotList;
@property (nonatomic, strong) NSArray<NSString*> *parkKeyList;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ParkListVC

-(void)dataInit {
    self.currentOffset = 0;
    self.parkSpotList = [[NSMutableDictionary alloc] init];
}

- (void)getParkSpotsData {
    
    __weak ParkListVC* tmpSelf = self;//使用weak物件不會被retain
    [[dataTPEService instance] getParkSpotsWithOffset:_currentOffset success:^(NSUInteger count, NSUInteger limit, NSUInteger offset, NSDictionary *parkSpostsList) {
        
        NSLog(@"currentoffset = %ld, limit = %ld", _currentOffset, limit);
        
        tmpSelf.currentOffset = _currentOffset + limit;
        [tmpSelf.parkSpotList addEntriesFromDictionary:parkSpostsList];
        tmpSelf.parkKeyList = [tmpSelf.parkSpotList allKeys];
        [self.tableview reloadData];
        
        
        NSLog(@"currentoffset = %ld", _currentOffset);
        NSLog(@"parkspotlist count = %ld", tmpSelf.parkSpotList.count);
        NSLog(@"parkKEYlist count = %ld", tmpSelf.parkKeyList.count);
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
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string;
    if (self.parkKeyList.count>section) {
        string = [self.parkKeyList objectAtIndex:section];
    }
    if (string.length>0) {
        [label setText:string];
    }
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    /*
    if (indexPath.row == 0 && isiPhone)
    {
        return _movieInfoGroup.view.frame.size.height;
    }
    else if (indexPath.row == 1)
    {
        return _movieInfoRecommendGroup.view.frame.size.height;
    }
    else if (indexPath.row == 2)
    {
        return _promoteBannerGroup.view.frame.size.height;
    }
    */
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseId = @"ParkSpotTableViewCell";
    ParkSpotTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];

//    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ParkSpotItem* item = nil;
    NSArray<NSString*>* parkKeyList = [_parkSpotList allKeys];
    if (parkKeyList.count>indexPath.section) {
        NSString* keyName = [parkKeyList objectAtIndex:indexPath.section];
        NSArray* spotList = [_parkSpotList objectForKey:keyName];
        if (spotList.count>indexPath.row) {
            item = [spotList objectAtIndex:indexPath.row];
//            cell.textLabel.text = item.spotName;
//            cell.detailTextLabel.text = item.parkName;
//            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]];
            cell.parkName.text = item.parkName;
            cell.parkSpotName.text = item.spotName;
            [cell.parkImg sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]];
            
            NSLog(@"========  index section = %ld, row = %ld", indexPath.section, indexPath.row);
            NSLog(@"key name = %@, parkname = %@", keyName, item.parkName);
            NSLog(@"spot name = %@", item.spotName);
            
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: push parkspotvc
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // lazy loading by section
    if (self.parkKeyList.count - 2  == indexPath.section ) {
        NSLog(@"parkkeylist = %ld, will display section = %ld row = %ld", self.parkKeyList.count, indexPath.section, indexPath.row);
        [self getParkSpotsData];
    }
}
@end
