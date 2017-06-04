//
//  AppDelegate+Tools.m
//  FF_ProjectStruct
//
//  Created by fanxiaobin on 2017/6/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "AppDelegate+Tools.h"

@implementation AppDelegate (Tools)

#pragma mark - Appearance Customize 自定义导航条显示
- (void)customizeNavigationBarAppearance {
    [[UIWindow appearance] setTintColor:MAIN_COLOR];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: MAIN_COLOR} forState:UIControlStateSelected];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:MAIN_COLOR] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"nav_back_white"];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:@"nav_back_white"];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:MAIN_COLOR]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size:17]}];
    //HelveticaNeue
    
}

@end
