//
//  MPSPayStatusHUD.h
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPSPayStatusView.h"

@interface MPSPayStatusHUD : NSObject

+ (void)showWithInfo:(NSString *)errorInfo;

@end
