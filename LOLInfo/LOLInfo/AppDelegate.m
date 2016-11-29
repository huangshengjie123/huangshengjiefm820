//
//  AppDelegate.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "UMSocial.h"//友盟
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置使用权限
    [UMSocialData setAppKey:@"573ab64a67e58e3714001a41"];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置根视图
    self.window.rootViewController = [[MainTabBarViewController alloc]init];
    //更改状态栏样式操作
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    //统一设置控件效果
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
