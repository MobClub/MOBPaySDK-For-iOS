
一、注册应用获取appKey 和 appSecret
===
如何在我们的官网注册应用得到appkey，请[点击链接](http://bbs.mob.com/forum.php?mod=viewthread&tid=8212&extra=page%3D1)看里面的操作步骤。

二. 获取支付SDK:
===

**点击[链接](http://mob.com/downloadDetail/PaySDK/ios)下载最新版SDK，解压后得到以下文件结构：**

![Snip20171129_37.png](http://upload-images.jianshu.io/upload_images/4131265-ff33a5e2fe7a1cb2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- **SDK：支付SDK和依赖库。直接将这个文件夹拖入工程即可。**
- **目录介绍**：
- Channels:第三方平台的SDK，包含支付宝、微信
- MOBPaySDK:支付SDK主库
- Required:必要依赖库

三、集成支付SDK
===

#### 1、将SDK文件夹加入工程

注意红框里面勾选：

![Snip20171122_7.png](http://upload-images.jianshu.io/upload_images/4131265-28aed6404b4172a5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2、设置依赖

**SDK所需依赖库列表**

```
libz.tbd
libstdc++.tbd
//支付宝sdk依赖
CoreMotion.framework
//微信sdk依赖
libsqlite3.tbd
```

![Snip20171122_11.png](http://upload-images.jianshu.io/upload_images/4131265-2be56130bb725739.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 3、设置 Build Settings

需要在 Other Linker Flags 加入 -ObjC

![Snip20171122_10.png](http://upload-images.jianshu.io/upload_images/4131265-552d5fc15d1894f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 4、配置白名单和urlScheme

- 微信：

URL Scheme : 微信的appid

白名单：weixin

- 支付宝：

URL Scheme : ap + 支付宝的appid

**配置URLSchemes:**

![Snip20171122_13.png](http://upload-images.jianshu.io/upload_images/4131265-58d4b304c40715e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**配置白名单**

在Info.plist里添加 键为 LSApplicationQueriesSchemes 值为数组的键值对，并在数组中加入各平台所需的白名单


```
<key>LSApplicationQueriesSchemes</key>
<array>
<string>weixin</string>
</array>
```

![Snip20171122_16.png](http://upload-images.jianshu.io/upload_images/4131265-ae807099bb9b39db.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 5、配置appkey和appSecret

在项目中的info.plist文件中添加键值对，键分别为 MOBAppKey 和 MOBAppSecret ，值为步骤一申请的appkey和appSecret

![Snip20171122_12.png](http://upload-images.jianshu.io/upload_images/4131265-4572369c79bac1ac.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

四、使用SDK提供的API
===

#### 1. 导入头文件

```
#import <MOBPaySDK/MOBPay.h>
```

#### 2. 设置支付回调代理

```
/**
设置观察者，监听支付状态改变与回调

@param observer 回调代理
*/
+ (void)addObserver:(id<MOBPayObserverDelegate>)observer;
```

==**注意**==：开发者应注意app在跳出到第三方支付平台客户端支付时，自己的app在后台被强退的情况，此时app会重新启动，如需拿到支付结果，需要把代理设置在 didFinishLaunchingWithOptions 方法中

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

[MOBPay addObserver:[PayManager defaultManager]];

return YES;
}
```

#### 3. 调用支付接口进行支付

通过支付SDK支付有2种接入方式，具体介绍看：www.mob.com


- **第一种方式：直接通过支付数据进行支付**

1. 创建支付需要的数据模型：MPSCharge

2. 调用支付接口进行支付

```
/**
支付接口

@param charge 支付信息模型
*/
+ (void)payWithCharge:(MPSCharge *)charge;
```

```
//主要支付逻辑
- (void)payWithPrice:(NSInteger)price channel:(MPSChannel)channel
{
MPSCharge *charge = [[MPSCharge alloc] init];
charge.orderId = [NSString stringWithFormat:@"%zd",[[NSDate date] timeIntervalSince1970]];
charge.amount = price;
charge.channel = channel;
charge.subject = @"为账户充值：";

//可选参数
charge.appUserId = @"01234567890";
charge.appUserNickname = @"mob";
charge.body = @"订单商品的描述：这是一个测试商品";
charge.desc = @"这笔订单只是测试，不加入统计";
charge.metadata = @"@{@\"dec\":@\"metaData\"}";

[MOBPay payWithCharge:charge];
}
```

- **第二种方式：通过开发者自己的后台返回的ticketId进行支付**

```
/**
使用ticketId进行支付

@param ticketId 支付标示
*/
+ (void)payWithTicketId:(NSString *)ticketId;
```

#### 4. 支付结果处理

通过 MOBPayObserverDelegate 协议返回支付结果

**==注意==**：具体支付结果开发者应根据自己后台服务器的查询为准，不应该以sdk返回的结果直接作为支付结果处理相关业务。

```
/**
支付结果
*/
@protocol MOBPayObserverDelegate <NSObject>

/**
支付状态改变回调

@param transaction 本次支付模型
@param status 支付状态
*/
- (void)paymentTransaction:(MPSPaymentTransaction *)transaction statusDidChange:(MPSPayStatus)status;

@end
```

代码示例：

```
- (void)paymentTransaction:(MPSPaymentTransaction *)transaction statusDidChange:(MPSPayStatus)status
{
// 具体回调结果开发者应根据后台服务器查询结果为准

switch (status) {

case MPSPayStatusBegin: //说明已获取到ticketId开始吊起支付
NSLog(@"%@",transaction.ticketId);
break;

case MPSPayStatusSuccess://支付成功
[MPSPayStatusHUD showWithInfo:nil];
break;

case MPSPayStatusCancel://取消支付
[MPSPayStatusHUD showWithInfo:@"付款失败，请稍后重试"];
break;

default://支付失败
NSLog(@"%@",transaction.error);
[MPSPayStatusHUD showWithInfo:@"付款失败，请稍后重试"];
break;
}

if(status != MPSPayStatusBegin)
{
[self _persistenceOrderWithStatus:status];//缓存订单,demo演示用
}
}
```


