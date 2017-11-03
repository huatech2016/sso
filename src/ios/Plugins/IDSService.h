//
//  IDSService.h
//  IDS6
//
//  Created by dyf on 15/11/9.
//  Copyright © 2015年 wisorg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDSServiceObj.h"

@interface IDSService : NSObject

+ (IDSService *)defaultService;
//sdk启动
- (void)startWithIDSService:(NSString *)idsService appId:(NSString *)aId;
//开始登录
- (void)authorize:(IDSResponseBlock)complete;
//获取用户信息
- (void)getProfile:(IDSResponseBlock)complete;
//登出
- (void)logout:(IDSResponseBlock)complete;
@end
