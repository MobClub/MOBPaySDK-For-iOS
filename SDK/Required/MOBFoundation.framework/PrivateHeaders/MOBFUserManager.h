//
//  MOBFUserManager.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 2017/9/6.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MOBFUser;

/**
 用户管理器
 */
@interface MOBFUserManager : NSObject

/**
 获取默认的用户管理器

 @return 用户管理器对象
 */
+ (instancetype _Nonnull)defaultManager;

/**
 设置当前用户

 @param user 用户信息
 */
- (void)setCurrentUser:(MOBFUser * _Nullable)user;

/**
 获取当前用户

 @param handler 用户回调
 */
- (void)getCurrentUser:(void (^ _Nullable)(MOBFUser * _Nullable user, NSError * _Nullable error))handler;

@end
