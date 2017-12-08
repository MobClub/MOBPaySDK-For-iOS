//
//  MPSPayManager.h
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MOBPaySDK/MOBPay.h>

@interface MPSPayManager : NSObject<MOBPayObserverDelegate>

+ (instancetype)defaultManager;

/**
 支付接口

 @param price 支付价格
 @param channel 支付渠道
 */
- (void)payWithPrice:(NSInteger)price channel:(MPSChannel)channel;

@end
