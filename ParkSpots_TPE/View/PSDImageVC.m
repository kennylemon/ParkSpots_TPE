//
//  PSDImageVC.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "PSDImageVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PSDImageVC ()

@property (strong, nonatomic) NSString* imgUrl;

@property (weak, nonatomic) IBOutlet UIImageView *spotImage;
@end

@implementation PSDImageVC


- (instancetype)initWithImgUrl:(NSString *)imgUrl;
{
    NSString *nibName = @"PSDImageVC";
    self = [super initWithNibName:nibName bundle:nil];
    if (self)
    {
        self.imgUrl = imgUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.spotImage sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
