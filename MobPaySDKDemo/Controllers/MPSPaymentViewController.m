//
//  MPSPaymentViewController.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/7.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "MPSPaymentViewController.h"
#import "MPSChannelTableViewCell.h"
#import <MOBFoundation/MOBFoundation.h>
#import "MPSOrdersViewController.h"
#import "MPSPayManager.h"

@interface MPSPaymentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _price;
    NSInteger _selectedChannelIndex;
    UIButton *_selectedPrice;
}

@property (weak, nonatomic) IBOutlet UIButton *priceT;//10
@property (weak, nonatomic) IBOutlet UIButton *priceH;//100
@property (weak, nonatomic) IBOutlet UIButton *priceM;//200
@property (weak, nonatomic) IBOutlet UITableView *channelsTableView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property (nonatomic, strong) NSArray<NSDictionary *> *channels;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

static NSString *const kMPSChannelTableViewCellIdentifier = @"MPSChannelTableViewCellReuseIdentifier";

@implementation MPSPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"请选择充值";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"我的订单" forState:UIControlStateNormal];
    [button setTitleColor:[MOBFColor colorWithRGB:0x6E6F78] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(_myorders) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UINib *cellNib = [UINib nibWithNibName:@"MPSChannelTableViewCell" bundle:nil];
    [_channelsTableView registerNib:cellNib forCellReuseIdentifier:kMPSChannelTableViewCellIdentifier];
    _channelsTableView.delegate = self;
    _channelsTableView.dataSource = self;
    _channelsTableView.rowHeight = 62;
    
    [_channelsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    for (UIButton *obj in @[_priceT,_priceH,_priceM])
    {
        obj.layer.cornerRadius = 2;
        obj.layer.masksToBounds = YES;
        [obj setBackgroundImage:nil forState:UIControlStateNormal];
        
        UIColor *from = [MOBFColor colorWithRGB:0xFF9C67];
        UIColor *to = [MOBFColor colorWithRGB:0xFF7242];
        [obj setBackgroundImage:[self imageFromGradientColors:@[from,to] gradientType:GradientTypeLeftToRight size:obj.frame.size] forState:UIControlStateSelected];
    }
    
    _payButton.layer.cornerRadius = 3;
    
    [self didSelectT:_priceT];
}

- (IBAction)_priceDidChange:(UITextField *)sender
{
    NSString *text = sender.text;
    NSUInteger index = [text rangeOfString:@"."].location;
    if (index != NSNotFound) {
        double amount = [[text stringByReplacingOccurrencesOfString:@"." withString:@""] doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, 99999999)/100];
    } else {
        double amount = [text doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, 99999999)/100];
    }
    sender.text = text;
    _totalLabel.text = text;
    _price = [text floatValue]*100;

}

- (IBAction)didSelectT:(UIButton *)sender
{
    if (_selectedPrice != sender)
    {
        _selectedPrice.selected = NO;
        sender.selected = YES;
        _selectedPrice = sender;
        _price = 10;
        _priceTextField.text = @"0.01";
        _totalLabel.text = @"0.01";
        [self _priceDidChange:_priceTextField];
    }
    
    [self.view endEditing:YES];
}

- (IBAction)didSelectH:(UIButton *)sender
{
    if (_selectedPrice != sender)
    {
        _selectedPrice.selected = NO;
        sender.selected = YES;
        _selectedPrice = sender;
        _price = 100;
        _priceTextField.text = @"0.05";
        _totalLabel.text = @"0.05";
        [self _priceDidChange:_priceTextField];
    }
    
    [self.view endEditing:YES];
}

- (IBAction)didSelectM:(UIButton *)sender
{
    if (_selectedPrice != sender)
    {
        _selectedPrice.selected = NO;
        sender.selected = YES;
        _selectedPrice = sender;
        _price = 200;
        _priceTextField.text = @"0.10";
        _totalLabel.text = @"0.10";
        [self _priceDidChange:_priceTextField];
    }
    
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.channels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPSChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMPSChannelTableViewCellIdentifier];
    cell.channelInfo = _channels[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedChannelIndex != indexPath.row)
    {
        [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedChannelIndex inSection:0] animated:YES];
        _selectedChannelIndex = indexPath.row;
    }
    
    [self.view endEditing:YES];
}

#pragma mark - getter
- (NSArray<NSDictionary *> *)channels
{
    if (!_channels)
    {
        _channels = @[
                      @{@"image":@"alipay",
                        @"name":@"支付宝",
                        @"desc":@"推荐安装支付宝6.0以上版本的用户使用"},
                      
                      @{@"image":@"wxpay",
                        @"name":@"微信",
                        @"desc":@"推荐安装微信6.0以上版本的用户使用"}
                      ];
    }
    
    return _channels;
}

typedef NS_ENUM(NSInteger, GradientType) {
    GradientTypeTopToBottom = 1, //从上到下
    GradientTypeLeftToRight, //从左到右
    GradientTypeUpLeftToLowRight, //左上到右下
    GradientTypeUpRightToLowLeft  //右上到左下
};

- (UIImage *)imageFromGradientColors:(NSArray *)colors gradientType:(GradientType)gradientType size:(CGSize)size
{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors)
    {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
        {
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
        }
            break;
        case GradientTypeLeftToRight:
        {
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
        }
            break;
        case GradientTypeUpLeftToLowRight:
        {
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
        }
            break;
        case GradientTypeUpRightToLowLeft:
        {
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
        }
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - MOBPay

- (IBAction)pay:(UIButton *)sender
{
    MPSChannel channel = _selectedChannelIndex==0 ? MPSChannelAliPay:MPSChannelWeChat;
    [[MPSPayManager defaultManager] payWithPrice:_price channel:channel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)_myorders
{
    MPSOrdersViewController *vc = [[MPSOrdersViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
