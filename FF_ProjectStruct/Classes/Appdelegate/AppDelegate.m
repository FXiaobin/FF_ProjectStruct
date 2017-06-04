//
//  AppDelegate.m
//  FF_ProjectStruct
//
//  Created by fanxiaobin on 2017/6/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "AppDelegate+Tools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self customizeNavigationBarAppearance];
    
    
    self.window.rootViewController = [[RootTabBarViewController alloc] init];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}


@end
