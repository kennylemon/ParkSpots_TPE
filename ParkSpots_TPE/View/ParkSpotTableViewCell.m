//
//  ParkSpotTableViewCell.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/23.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "ParkSpotTableViewCell.h"

@implementation ParkSpotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"introduction = %@", self.introduction.text);
    
    CGSize expecIntroSize = [self.introduction sizeThatFits:CGSizeMake(CGRectGetWidth(self.introduction.frame), CGFLOAT_MAX)];
    NSLog(@"exptected size = %@", NSStringFromCGSize(expecIntroSize));
    
    CGRect introframe = self.introduction.frame;
    CGSize oriIntroSize = introframe.size;
    NSLog(@"ori intro size = %@", NSStringFromCGSize(oriIntroSize));
    NSLog(@"ori intro frame = %@", NSStringFromCGRect(introframe));
    
    introframe.size.height = expecIntroSize.height;
    self.introduction.frame = introframe;
    NSLog(@"final intro frame = %@", NSStringFromCGRect(self.introduction.frame));
    
    CGRect rc = self.contentView.frame;
    NSLog(@"contentView = %@", NSStringFromCGRect(rc));
    rc.size.height = rc.size.height+(expecIntroSize.height-oriIntroSize.height);
    self.contentView.frame = rc;
    NSLog(@"contentView = %@", NSStringFromCGRect(self.contentView.frame));
}
@end
