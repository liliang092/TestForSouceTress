//
//  TTReqProtocol.m
//  TickTock
//
//  Created by liliang on 16-10-24.
//  Copyright (c) 2016年 liliang. All rights reserved.
//

#import "TTReqProtocol.h"

@implementation TTReqProtocol



+(void)GetPublicData:(NSMutableDictionary *)dic
{
    
}

+(void)haneleToken:(NSMutableDictionary*)dic
{
    
}

//获取普通用户
+(NSDictionary*)C_GetUser_GetSetUid:(NSString *)uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [self GetPublicData:tempDic];
    
    if ([uid notEmpty])
    {
        [tempDic setObject:uid  forKey:@"uid"];
    }
   
    [self haneleToken:tempDic];
    
    return tempDic;
}

@end
