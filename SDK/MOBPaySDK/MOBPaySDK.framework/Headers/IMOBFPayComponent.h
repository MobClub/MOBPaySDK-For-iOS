//
//  IMOBFPayComponent.h
//  MOBPaySDK
//
//  Created by youzu_Max on 2017/9/15.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MOBFoundation/IMOBFServiceComponent.h>

@protocol IMOBFPayComponent <IMOBFServiceComponent>

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
 是否开启沙盒调试模式
 
 @param enabled YES:开启,默认关闭
 */
+ (void)setSandBoxMode:(BOOL)enabled;

@end
