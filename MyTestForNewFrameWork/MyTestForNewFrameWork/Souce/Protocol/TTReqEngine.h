//
//  TTReqEngine.h
//  TickTock
//
//  Created by liliang on 16-10-24.
//  Copyright (c) 2016年 liliang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TTBaseModelBlock)(BOOL success,id dataModel);

@interface TTReqEngine : NSObject

#pragma mark  -  用户接口
/**
    获取应用广告页面
 */
+(void)C_GetConfig_AD:(NSString *)type  withBlock:(TTBaseModelBlock)block;

@end
