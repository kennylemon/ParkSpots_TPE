//
//  PSDRelatedVC.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "PSDRelatedVC.h"
#import "ParkSpotItem.h"
#import "ParkSpotDCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Definitions.h"
#import "PSDRcmdCollectionViewCell.h"

@interface PSDRelatedVC () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@property (strong, nonatomic) NSString* selectedSpot;
@property (strong, nonatomic) NSArray<ParkSpotItem*>* relatedItems;
@end

@implementation PSDRelatedVC

- (instancetype)initWithRelated:(NSString *)selectedSpot relatedItems:(NSArray*)relatedItems
{
    NSString *nibName = @"PSDRelatedVC";
    self = [super initWithNibName:nibName bundle:nil];
    if (self)
    {
        self.selectedSpot = selectedSpot;
        self.relatedItems = [[NSArray alloc] initWithArray:relatedItems copyItems:YES];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionview registerClass:[PSDRcmdCollectionViewCell class] forCellWithReuseIdentifier:PSD_RCMD_CELL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return self.relatedItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PSDRcmdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PSD_RCMD_CELL forIndexPath:indexPath];
    
    if (self.relatedItems.count>indexPath.row) {
        ParkSpotItem* item = [self.relatedItems objectAtIndex:indexPath.row];
        if (item) {
            cell.spotName.text = item.spotName;
            [cell.spotImg sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]];
        }
    }

    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
