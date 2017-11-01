//
//  MPSPayManager.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "MPSPayManager.h"
#import "MPSPayStatusHUD.h"
#import <MOBFoundation/MOBFoundation.h>
#import "MPSOrder.h"

#define MPSAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

@interface MPSPayManager()

@property (nonatomic, strong) MPSCharge *currentCharge;

@end

@implementation MPSPayManager

+ (instancetype)defaultManager
{
    static MPSPayManager *shared = nil;
    static dispatch_once_t instanceToken;
    dispatch_once(&instanceToken, ^{
        shared = [[MPSPayManager alloc] init];
    });
    return shared;
}

//主要支付逻辑
- (void)payWithPrice:(NSInteger)price channel:(MPSChannel)channel
{
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = [NSString stringWithFormat:@"%zd",[[NSDate date] timeIntervalSince1970]];
    charge.amount = price;
    charge.channel = channel;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"订单商品的描述：这是一个测试商品";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    _currentCharge = charge;
    [MOBPay payWithCharge:charge];
}

#pragma mark - MOBPayObserverDelegate

// 具体回调结果开发者应根据后台服务器查询结果为准
- (void)paymentCallback:(MPSPayResult *)result
{
    if (result.status == MPSPayStatusSuccess)
    {
        [MPSPayStatusHUD showWithInfo:nil];
//        MPSAlert(@"支付成功");
    }
    else
    {
        [MPSPayStatusHUD showWithInfo:@"付款失败，请稍后重试"];
        
//        if(result.status == MPSPayStatusCancel)
//        {
//            MPSAlert(@"支付取消");
//        }
//        else
//        {
//            MPSAlert(@"支付失败：%@",result.error);
//        }
    }
    
    [self _persistenceOrderWithStatus:result.status];//缓存订单,demo演示用
}

- (void) _persistenceOrderWithStatus:(MPSPayStatus)status
{
    if (_currentCharge)
    {
        MPSOrder *order = [[MPSOrder alloc] init];
        order.orderId = _currentCharge.orderId;
        order.timestamp = [[NSDate date] timeIntervalSince1970];
        order.subject = _currentCharge.subject;
        order.price = _currentCharge.amount;
        order.status = status;
        
        NSArray *cachedData = [[MOBFDataService sharedInstance] cacheDataForKey:@"MPSDemo_orders" domain:@"MPSDemo"];
        
        NSMutableArray *orders;
        if ([cachedData isKindOfClass:NSArray.class])
        {
            orders = cachedData.mutableCopy;
        }
        else
        {
            orders = @[].mutableCopy;
        }
        
        [orders insertObject:order atIndex:0];
        
        [[MOBFDataService sharedInstance] setCacheData:orders forKey:@"MPSDemo_orders" domain:@"MPSDemo"];
    }
}

@end
