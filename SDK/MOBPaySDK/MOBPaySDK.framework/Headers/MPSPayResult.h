//
//  MPSPayResult.h
//  MOBPaySDK
//
//  Created by youzu_Max on 2017/9/5.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import <MOBFoundation/MOBFDataModel.h>

@interface MPSPayResult : MOBFDataModel

/**
 支付渠道
 */
@property (nonatomic, assign) MPSChannel channel;

/**
 支付结果
 */
@property (nonatomic, assign) MPSPayStatus status;

/**
 错误信息
 */
@property (nonatomic, strong) NSError *error;

@end
