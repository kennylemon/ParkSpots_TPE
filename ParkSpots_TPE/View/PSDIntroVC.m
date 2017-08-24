//
//  PSDIntroVC.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "PSDIntroVC.h"

@interface PSDIntroVC ()
@property (strong, nonatomic) NSString* intro;
@property (weak, nonatomic) IBOutlet UILabel *introL;
@end

@implementation PSDIntroVC

- (instancetype)initWithItro:(NSString *)intro
{
    NSString *nibName = @"PSDIntroVC";
    self = [super initWithNibName:nibName bundle:nil];
    if (self)
    {
        self.intro = intro;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.introL.text = self.intro;
    NSLog(@"introduction = %@", self.introL.text);
    
    CGRect rcIntro = self.introL.frame;
    NSLog(@"ori introL rect = %@", NSStringFromCGRect(rcIntro));
    
    CGSize expectSize = [self.introL sizeThatFits:CGSizeMake(CGRectGetWidth(self.introL.frame), CGFLOAT_MAX)];
    NSLog(@"exptected size = %@", NSStringFromCGSize(expectSize));
    
    
    
    
    int hegihtDiff = expectSize.height - rcIntro.size.height;
    rcIntro.size.height = expectSize.height;
    self.introL.frame = rcIntro;
    NSLog(@"new introL rect = %@", NSStringFromCGRect(self.introL.frame));
    
    CGRect rcView = self.view.frame;
    NSLog(@"ori self.view rect = %@", NSStringFromCGRect(rcView));
    rcView.size.height = rcView.size.height + hegihtDiff;
    self.view.frame = rcView;
    NSLog(@"new introL rect = %@", NSStringFromCGRect(self.view.frame));
    
    NSLog(@"123");
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
