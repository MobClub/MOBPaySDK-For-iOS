//
//  MPSPayStatusHUD.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "MPSPayStatusHUD.h"

@interface MPSPayStatusHUD()

@property (nonatomic, strong) MPSPayStatusView *statusView;
@property (nonatomic, weak) UIView *keyWindow;

@end

@implementation MPSPayStatusHUD

+ (instancetype)shared
{
    static MPSPayStatusHUD *shared = nil;
    static dispatch_once_t instanceToken;
    dispatch_once(&instanceToken, ^{
        shared = [[MPSPayStatusHUD alloc] init];
    });
    return shared;
}

+ (void)showWithInfo:(NSString *)errorInfo
{
    MPSPayStatusView *statusView = [MPSPayStatusHUD shared].statusView;
    statusView.alert = errorInfo;
    UIView *keyWindow = [MPSPayStatusHUD shared].keyWindow;
    
    if (statusView.superview == nil)
    {
        [keyWindow addSubview:statusView];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [statusView removeFromSuperview];
    });
}


- (MPSPayStatusView *)statusView
{
    if (!_statusView)
    {
        _statusView = [[NSBundle mainBundle] loadNibNamed:@"MPSPayStatusView" owner:nil options:nil].firstObject;
        _statusView.frame = [UIScreen mainScreen].bounds;
    }
    
    return _statusView;
}

- (UIView *)keyWindow
{
    if (!_keyWindow)
    {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    return _keyWindow;
}

@end
