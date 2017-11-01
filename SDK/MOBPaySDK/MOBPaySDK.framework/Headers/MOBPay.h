//
//  MOBPay.h
//  MOBPaySDK
//
//  Created by youzu_Max on 2017/6/28.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPSCharge.h"
#import "MPSPayResult.h"

/**
 支付结果
 */
@protocol MOBPayObserverDelegate <NSObject>

- (void)paymentCallback:(MPSPayResult *)result;

@end


@interface MOBPay : NSObject

/**
 设置观察者，监听支付状态改变与回调

 @param observer 回调代理
 */
+ (void)addObserver:(id<MOBPayObserverDelegate>)observer;

/**
 支付接口

 @param charge 支付信息模型
 */
+ (void)payWithCharge:(MPSCharge *)charge;

/**
 使用ticketId进行支付

 @param ticketId 支付标示
 */
+ (void)payWithTicketId:(NSString *)ticketId;

/**
 版本号

 @return 版本信息
 */
+ (NSString *)version;

@end
