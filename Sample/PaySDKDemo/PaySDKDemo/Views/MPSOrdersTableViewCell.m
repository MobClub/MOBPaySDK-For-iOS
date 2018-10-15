//
//  MPSOrdersTableViewCell.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "MPSOrdersTableViewCell.h"
#import "MPSOrder.h"
#import <MOBFoundation/MOBFoundation.h>

@interface MPSOrdersTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *channelImageView;
@property (weak, nonatomic) IBOutlet UILabel *channelNameLabel;

@end

@implementation MPSOrdersTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setOrder:(MPSOrder *)order
{
    _order = order;
    
    _orderIdLabel.text = [NSString stringWithFormat:@"订单号：%@",order.orderId];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f元",order.price/100.0];
    _subjectLabel.text = order.subject;
    
    switch (order.status)
    {
        case MPSPayStatusSuccess:
            _statusLabel.text = @"支付成功";
            break;
            
        case MPSPayStatusCancel:
            _statusLabel.text = @"取消支付";
            break;
            
        default:
            _statusLabel.text = @"支付失败";
            break;
    }
    
    switch (order.channel) {
            
        case MPSChannelWeChat:
            _channelImageView.image = [UIImage imageNamed:@"wxpay"];
            _channelNameLabel.text = @"微信支付";
            break;
            
        case MPSChannelAliPay:
            _channelImageView.image = [UIImage imageNamed:@"alipay"];
            _channelNameLabel.text = @"支付宝";
            break;
            
        case MPSChannelUnionPay:
            _channelImageView.image = [UIImage imageNamed:@"wxpay"];
            _channelNameLabel.text = @"银联手机支付";
            break;
            
        case MPSChannelApplePay:
            _channelImageView.image = [UIImage imageNamed:@"wxpay"];
            _channelNameLabel.text = @"Apple Pay";
            break;
            
        default:
            break;
    }
    
    _timeLabel.text = [MOBFDate stringByDate:[NSDate dateWithTimeIntervalSince1970:order.timestamp] withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 4;
    frame.size.height -= 4;
    [super setFrame:frame];
}

@end
