//
//  AppDelegate.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/8/28.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "AppDelegate.h"
#import "MPSPayManager.h"
#import "MPSPaymentViewController.h"
#import "MPSOrder.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MPSPaymentViewController *vc = [[MPSPaymentViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [MOBPay setDebugMode:YES];
    [MOBPay addObserver:[MPSPayManager defaultManager]];
    
    return YES;
}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
//{
//    NSLog(@"-------> %s ：调回成功",__func__);
//    return YES;
//}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    NSLog(@"-------> %s ：调回成功",__func__);
//    return YES;
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    NSLog(@"-------> %s ：调回成功",__func__);
//    return YES;
//}


@end
