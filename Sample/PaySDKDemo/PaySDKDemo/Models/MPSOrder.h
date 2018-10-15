//
//  MPSOrder.h
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import <MOBFoundation/MOBFDataModel.h>
#import <MOBPaySDK/MOBPay.h>

@interface MPSOrder : MOBFDataModel

@property (nonatomic, assign) NSTimeInterval timestamp;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, assign) MPSPayStatus status;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, assign) MPSChannel channel;

@end
