//
//  TTReqUrl.m
//  TickTock
//
//  Created by liliang on 16-10-24.
//  Copyright (c) 2016年 liliang. All rights reserved.
//

#import "TTReqUrl.h"

@implementation TTReqUrl

+(NSString*) HandleHostAndPro
{
    return [NSString stringWithFormat:@"%@%@",KHost,KProtocolVistion];
}

+(NSString*)HaneleGetUrlString:(NSString*)url
{
    NSString* result = [NSString stringWithFormat:@"%@%@",[TTReqUrl HandleHostAndPro],url];
    
    NSLog(@"req url:%@",result);
    
    return result;
}

#pragma mark  -  用户接口(user)

@end
