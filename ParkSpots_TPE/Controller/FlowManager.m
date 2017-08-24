//
//  FlowManager.m
//  ParkSpots_TPE
//
//  Created by Kenny Lin on 2017/8/24.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "FlowManager.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface FlowManager ()

@property (nonatomic, strong) UINavigationController* nav;
@end

@implementation FlowManager


+ (instancetype)instance
{
    static FlowManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        sharedInstance.nav = (UINavigationController*)appDelegate.window.rootViewController;

        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)pushViewController:(UIViewController*)vc {
    if (!vc) {
        return;
    }
    
    [self.nav pushViewController:vc animated:YES];
}

- (void)popViewController {
    [self.nav popViewControllerAnimated:YES];
}

@end
