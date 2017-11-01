//
//  MPSChannelTableViewCell.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/7.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "MPSChannelTableViewCell.h"

@interface MPSChannelTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *seletImgView;

@property (weak, nonatomic) IBOutlet UIImageView *channelImageView;

@property (weak, nonatomic) IBOutlet UILabel *channelName;

@property (weak, nonatomic) IBOutlet UILabel *channelSummary;

@end

@implementation MPSChannelTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    _seletImgView.hidden = !selected;
}

- (void)setChannelInfo:(NSDictionary *)channelInfo
{
    _channelInfo = channelInfo;
    
    _channelImageView.image = [UIImage imageNamed:channelInfo[@"image"]];
    _channelName.text = channelInfo[@"name"];
    _channelSummary.text = channelInfo[@"desc"];
}

@end
