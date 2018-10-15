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
#import <PassKit/PassKit.h>

#define MPSAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

@interface MPSPayManager()
{
    MPSChannel _currentChannel;
}

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
//    if (channel == MPSChannelApplePay)
//    {
//        PKMerchantCapability merchantCapabilities = PKMerchantCapability3DS | PKMerchantCapabilityEMV | PKMerchantCapabilityDebit;
//        
//        if(![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkChinaUnionPay] capabilities:merchantCapabilities])
//        {
//            MPSAlert(@"不支持ApplePay支付");
//            return;
//        }
//    }
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = [NSString stringWithFormat:@"%zd",[[NSDate date] timeIntervalSince1970]];
    charge.amount = price;
    charge.channel = channel;
    charge.subject = @"为账户充值：";

    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";

    _currentCharge = charge;
    [MOBPay payWithCharge:charge];
    
    //[MOBPay payWithTicketId:@"8FCC0EB468055FE17FC8CF88C6F43D1F"];
    
}

#pragma mark - MOBPayObserverDelegate
- (void)paymentTransaction:(MPSPaymentTransaction *)transaction statusDidChange:(MPSPayStatus)status
{
    // 具体回调结果开发者应根据后台服务器查询结果为准
    switch (status) {
            
        case MPSPayStatusBegin: //说明已获取到ticketId开始吊起支付
            NSLog(@"ticketId:%@",transaction.ticketId);
            break;
            
        case MPSPayStatusSuccess://支付成功
            [MPSPayStatusHUD showWithInfo:nil];
            break;
            
        case MPSPayStatusCancel://取消支付
#ifdef DEBUG
            MPSAlert(@"channel:%zd 取消支付",transaction.channel);
#else
            [MPSPayStatusHUD showWithInfo:@"付款失败，请稍后重试"];
#endif
            break;
            
        default://支付失败
            NSLog(@"%@",transaction.error);
#ifdef DEBUG
             MPSAlert(@"channel:%zd fail:%@",transaction.channel,transaction.error);
#else
            [MPSPayStatusHUD showWithInfo:@"付款失败，请稍后重试"];
#endif
            break;
    }
    
    if(status != MPSPayStatusBegin)
    {
        [self _persistenceOrderWithStatus:status];//缓存订单,demo演示用
    }
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
        
        if (_currentCharge.channel)
        {
            order.channel = _currentCharge.channel;
        }
        else
        {
            order.channel = _currentChannel;
        }
        
        NSArray *cachedData = [[MOBFDataService sharedInstance] cacheDataForKey:@"MPSDemo_orders" domain:@"MPSDemo"];
        
        [cachedData enumerateObjectsUsingBlock:^(MPSOrder* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSLog(@"-----MPSManager---00000--%lu", (unsigned long)obj.channel);
            
        }];
        
        
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
        
        [orders enumerateObjectsUsingBlock:^(MPSOrder* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSLog(@"-----MPSManager--1111---%lu", (unsigned long)obj.channel);
            
        }];
        
        [[MOBFDataService sharedInstance] setCacheData:orders forKey:@"MPSDemo_orders" domain:@"MPSDemo"];
    }
}

@end
