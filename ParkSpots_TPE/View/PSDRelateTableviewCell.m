//
//  PSDRelateTableviewCell.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/30.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "PSDRelateTableviewCell.h"
#import "ParkSpotItem.h"
#import "PSDRcmdCollectionViewCell.h"
#import "Definitions.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PSDRelateTableviewCell () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (strong, nonatomic) UIImage *defaultImg;
@end

@implementation PSDRelateTableviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRelatedItems:(NSArray*)array {
    _relatedItems = [array copy];
    [self.collectionview reloadData];
}

- (void)layoutSubviews {
    self.defaultImg = [UIImage imageNamed:DEF_IMG];
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
        if ( item ) {
            cell.spotName.text = item.spotName;
            [cell.spotImg sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:self.defaultImg];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ( self.relatedItems.count > indexPath.row ) {
        
        if ([self.delegate respondsToSelector:@selector(onSelectedParkSpot:)]) {
            [self.delegate onSelectedParkSpot:[self.relatedItems objectAtIndex:indexPath.row]];
        }
    }
}
@end
