//
//  MPSPayStatusView.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "MPSPayStatusView.h"

@interface MPSPayStatusView()

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusAlert;

@end

@implementation MPSPayStatusView


- (void)setAlert:(NSString *)alert
{
    _alert = alert;
    
    if (alert)
    {
        _statusImageView.image = [UIImage imageNamed:@"failAlert"];
        _statusAlert.text = @"付款失败，请稍后重试";
    }
    else
    {
        _statusImageView.image = [UIImage imageNamed:@"successAlert"];
        _statusAlert.text = @"付款成功";
    }
}

@end
