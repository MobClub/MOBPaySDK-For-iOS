//
//  MOBPaySDKDemoTests.m
//  MOBPaySDKDemoTests
//
//  Created by 崔林豪 on 2018/7/16.
//  Copyright © 2018年 youzu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MOBPaySDK/MOBPay.h>
#import <MOBPaySDK/MPSCharge.h>


@interface MOBPaySDKDemoTests : XCTestCase <MOBPayObserverDelegate>

@property (nonatomic, strong) NSMutableDictionary *dic;
//@property (nonatomic, strong) XCTestExpectation *exp;

@end

@implementation MOBPaySDKDemoTests


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

#pragma mark - 支付宝支付 payWithCharge
XCTestExpectation *_exp = nil;

- (void)testAliPay
{
    [MOBPay addObserver:self];
    
   _exp = [self expectationWithDescription:@"testAliPay"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"4744211643015272682";
    charge.amount = 1;
    charge.channel = 50;
    charge.subject = @"为账户充值：";

    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";

    [MOBPay payWithCharge:charge];

    
    //[MOBPay payWithTicketId:@"27BB4B8CFD4B4C86AE53137B81B06EB6"];
   
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
       
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
    }];
}


- (void)paymentTransaction:(MPSPaymentTransaction *)transaction statusDidChange:(MPSPayStatus)status
{
    /*
     MPSPayStatusBegin = 0,
     MPSPayStatusSuccess,
     MPSPayStatusFail,
     MPSPayStatusCancel,
     MPSPayStatusUnknown,
     */
    if (status != MPSPayStatusBegin)
    {
        NSLog(@"------ss->>>>>>>---%lu", (unsigned long)status);
        [self.dic setObject:@(status).stringValue forKey:@"status"];
        [_exp fulfill];
    }
}

- (void)testAliPayWithWithNilChannel
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testAliPay"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"4744211643015272682";
    charge.amount = 1;
    charge.channel = 0;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

- (void)testAliPayWithWithWrongOrderId
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testAliPay"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"12332";
    charge.amount = 1;
    charge.channel = 0;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

- (void)testAliPayWithNilParam
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testAliPayWithNilParam"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = nil;
    charge.amount = 0;
    charge.channel = 0;
    charge.subject = nil;
    
    //可选参数
    charge.appUserId = nil;
    charge.appUserNickname = nil;
    charge.body = nil;
    charge.desc = nil;
    charge.metadata = nil;
    
    [MOBPay payWithCharge:charge];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

#pragma mark - payWithTicketId
- (void)testPayWithTicketIdWithAlipyPay
{
    [MOBPay addObserver:self];
    _exp = [self expectationWithDescription:@"testPayWithTicketIdWithAlipyPay"];
    self.dic = @{}.mutableCopy;
    
    [MOBPay payWithTicketId:@"491050301DC9EC803DC9EE052BF45E44"];

    [self waitForExpectationsWithTimeout:50 handler:^(NSError * _Nullable error) {
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
    }];
}

- (void)testPayWithTicketIdWithWeChat
{
    [MOBPay addObserver:self];
    self.dic = @{}.mutableCopy;
    
    [MOBPay payWithTicketId:@"6D5C43E6349749623E9EA983D1191D32"];
    
}

- (void)testPayWithTicketIdWithUnicon
{
    [MOBPay addObserver:self];
    _exp = [self expectationWithDescription:@"testPayWithTicketIdWithUnicon"];
    self.dic = @{}.mutableCopy;
    
    [MOBPay payWithTicketId:@"2C2D798E21777BAC0A3D16DCF943FE67"];
    
    [self waitForExpectationsWithTimeout:80 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
    }];
}

- (void)testPayWithTicketIdWithNilParam
{
    [MOBPay addObserver:self];
    _exp = [self expectationWithDescription:@"testPayWithTicketIdWithNilParam"];
    self.dic = @{}.mutableCopy;
    
    [MOBPay payWithTicketId:nil];
    
    [self waitForExpectationsWithTimeout:50 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
    }];
}

- (void)testPayWithTicketIdWithWrongTicketId
{
    [MOBPay addObserver:self];
    _exp = [self expectationWithDescription:@"testPayWithTicketIdWithWrongTicketId"];
    self.dic = @{}.mutableCopy;
    
    [MOBPay payWithTicketId:@"422"];
    
    [self waitForExpectationsWithTimeout:50 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
    }];
}


#pragma mark - 微信支付
- (void)testMPSChannelWeChat
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelWeChat"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"4744211643015272682";
    charge.amount = 1;
    charge.channel = 22;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    [_exp fulfill];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {

        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
             NSLog(@"-----statues---%@", @"测试不通过");
        }

    }];
}

- (void)testMPSChannelWeChatWithNilParam
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelWeChatWithNilParam"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = nil;
    charge.amount = 0;
    charge.channel = 0;
    charge.subject = nil;
    
    //可选参数
    charge.appUserId = nil;
    charge.appUserNickname = nil;
    charge.body = nil;
    charge.desc = nil;
    charge.metadata = nil;
    
    [MOBPay payWithCharge:charge];
    [_exp fulfill];
    
    [self waitForExpectationsWithTimeout:0 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

- (void)testMPSChannelWeChatWithWrongChannel
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelWeChat"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"4744211643015272682";
    charge.amount = 1;
    charge.channel = 0;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    [_exp fulfill];
    
    [self waitForExpectationsWithTimeout:0 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

- (void)testMPSChannelWeChatWithWrongOrderId
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelWeChat"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"1234";
    charge.amount = 1;
    charge.channel = 22;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    [_exp fulfill];
    
    [self waitForExpectationsWithTimeout:0 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

#pragma mark - 银联支付
- (void)testMPSChannelUnionPay
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelUnionPay"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"4744211643015272682";
    charge.amount = 1;
    charge.channel = 53;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    
    [self waitForExpectationsWithTimeout:100 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

- (void)testMPSChannelUnionPayWithNilParam
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelUnionPay"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = nil;
    charge.amount = 0;
    charge.channel = 0;
    charge.subject = nil;
    
    //可选参数
    charge.appUserId = nil;
    charge.appUserNickname = nil;
    charge.body = nil;
    charge.desc = nil;
    charge.metadata = nil;
    
    [MOBPay payWithCharge:charge];
    
    [self waitForExpectationsWithTimeout:100 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
    }];
}

- (void)testMPSChannelUnionPayWithWrongChannel
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelUnionPay"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"4744211643015272682";
    charge.amount = 1;
    charge.channel = 0;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    
    [self waitForExpectationsWithTimeout:100 handler:^(NSError * _Nullable error) {
        
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}

- (void)testMPSChannelUnionPayWithWrongOrderId
{
    [MOBPay addObserver:self];
    
    _exp = [self expectationWithDescription:@"testMPSChannelUnionPay"];
    self.dic = @{}.mutableCopy;
    
    MPSCharge *charge = [[MPSCharge alloc] init];
    charge.orderId = @"3323";
    charge.amount = 1;
    charge.channel = 53;
    charge.subject = @"为账户充值：";
    
    //可选参数
    charge.appUserId = @"01234567890";
    charge.appUserNickname = @"mob";
    charge.body = @"this is a product";
    charge.desc = @"这笔订单只是测试，不加入统计";
    charge.metadata = @"@{@\"dec\":@\"metaData\"}";
    
    [MOBPay payWithCharge:charge];
    
    [self waitForExpectationsWithTimeout:100 handler:^(NSError * _Nullable error) {
        
        if ([[self.dic objectForKey:@"status"] isEqualToString:@"3"] )
        {
            NSLog(@"-----statues---%@", @"测试通过");
        }
        else
        {
            NSLog(@"-----statues---%@", @"测试不通过");
        }
        
    }];
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
