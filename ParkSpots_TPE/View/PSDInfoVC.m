//
//  PSDInfoVC.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "PSDInfoVC.h"

@interface PSDInfoVC ()

@property (strong, nonatomic) NSString* parkName;
@property (strong, nonatomic) NSString* spotName;
@property (strong, nonatomic) NSString* openTime;

@property (weak, nonatomic) IBOutlet UILabel *parkNameL;
@property (weak, nonatomic) IBOutlet UILabel *spotNameL;
@property (weak, nonatomic) IBOutlet UILabel *openTimeL;
@end

@implementation PSDInfoVC

- (instancetype)initWithInfo:(NSString*)parkName
                    spotName:(NSString*)spotName
                    openTime:(NSString*)openTime
{
    NSString *nibName = @"PSDInfoVC";
    self = [super initWithNibName:nibName bundle:nil];
    if (self)
    {
        self.parkName = parkName;
        self.spotName = spotName;
        self.openTime = openTime;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.parkNameL.text = self.parkName;
    self.spotNameL.text = self.spotName;
    self.openTimeL.text = self.openTime;
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
