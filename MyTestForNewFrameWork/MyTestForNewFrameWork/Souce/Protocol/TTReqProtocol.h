//
//  TTReqProtocol.h
//  TickTock
//
//  Created by liliang on 16-10-24.
//  Copyright (c) 2016年 liliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTReqProtocol : NSObject

#pragma mark  -  用户接口(user)

//获取公共参数
+(void)GetPublicData:(NSMutableDictionary *)dic;

//获取普通用户
+(NSDictionary*)C_GetUser_GetSetUid:(NSString *)uid;
//登录

@end
