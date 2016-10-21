//
//  DLHttpHelper.m
//  TickTock
//
//  Created by 卢迎志 on 14-12-5.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLHttpHelper.h"
#import "NSString+DLExtension.h"
#import "LLHttpFormModel.h"
#import <netdb.h>
#import "SVProgressHUD.h"
#import "LLLog.h"
#import "AFHTTPRequestOperationManager.h"

@implementation DLHttpHelper

DEF_SINGLETON(DLHttpHelper);

-(id)init
{
    self = [super init];
    
    if (self) {
        self.timeOut = 60;
    }
    
    return self;
}

+(BOOL)isNetworkReachable
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    BOOL result = (isReachable && !needsConnection) ? YES : NO;
    
    if (!result) {
        [SVProgressHUD dismiss];
        
        UIAlertView *tempView = [[UIAlertView alloc]initWithTitle:nil message:@"启动蜂窝移动数据或Wi-Fi来访问数据" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [tempView show];
    }
    return result;
}

+(void)GetData:(NSString*)url
withParameters:(NSDictionary*)params
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSString *error))failure
{
    if (![DLHttpHelper isNetworkReachable]) {
        if (failure!=nil) {
            failure(nil);
        }
        return;
    }
    NSString* tempUrl = @"";
    
    NSRange tempPos = [url rangeOfString:@"?"];
    
    if ([params.allKeys count]>0) {
        for (int i=0; i<[params.allKeys count]; i++) {
            NSString* key = [params.allKeys objectAtIndex:i];
            NSString* value = [params.allValues objectAtIndex:i];
            if ([key notEmpty]) {
                NSString* tempItem = [NSString stringWithFormat:@"%@=%@",key,[value URLEncoding]];
                if (tempItem.length>0) {
                    if (tempUrl.length == 0) {
                        if (tempPos.length>0) {
                            tempUrl = [NSString stringWithFormat:@"&%@",tempItem];
                        }else{
                            tempUrl = [NSString stringWithFormat:@"?%@",tempItem];
                        }
                    }else{
                        tempUrl = [NSString stringWithFormat:@"%@&%@",tempUrl,tempItem];
                    }
                }
            }
        }
    }
    
    tempUrl = [NSString stringWithFormat:@"%@%@",url,tempUrl];
    
    INFO(@"GET URL:%@",tempUrl);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:[DLHttpHelper sharedInstance].timeOut];
    [manager GET:tempUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        INFO(@"data: %@",responseStr);
        if (success!=nil) {
            success(responseStr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* error2 = [NSString stringWithFormat:@"%ld:%@",(long)operation.response.statusCode,[NSHTTPURLResponse localizedStringForStatusCode:operation.response.statusCode]];
        ERROR(@"Error: %@", error2);
        if (failure!=nil) {
            failure(error2);
        }
    }];
}

+(void)PostData:(NSString*)url
 withParameters:(NSDictionary*)params
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSString *error))failure
{
    if (![DLHttpHelper isNetworkReachable]) {
        if (failure!=nil) {
            failure(nil);
        }
        return;
    }
    
    INFO(@"POST URL:%@",url);
    INFO(@"Params:%@",params);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setTimeoutInterval:[DLHttpHelper sharedInstance].timeOut];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        INFO(@"data: %@",responseStr);
        if (success!=nil) {
            success(responseStr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* error2 = [NSString stringWithFormat:@"%ld:%@",(long)operation.response.statusCode,[NSHTTPURLResponse localizedStringForStatusCode:operation.response.statusCode]];
        ERROR(@"Error: %@", error2);
        if (failure!=nil) {
            failure(error2);
        }
    }];
}

+(void)PostFormData:(NSString*)url
     withParameters:(NSDictionary*)params
       withFormData:(NSMutableArray*)formdata
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSString *error))failure
{
    if (![DLHttpHelper isNetworkReachable]) {
        if (failure!=nil) {
            failure(nil);
        }
        return;
    }
    INFO(@"POST FORM URL:%@",url);
    INFO(@"Params:%@",params);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:[DLHttpHelper sharedInstance].timeOut];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i=0; i<[formdata count]; i++) {
            LLHttpFormModel * tempItem = [formdata objectAtIndex:i];
            if (tempItem!=nil && [tempItem.fileKey notEmpty] && tempItem.fileUrl!=nil ) {
                [formData appendPartWithFileURL:tempItem.fileUrl name:tempItem.fileKey error:nil];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        INFO(@"data: %@",responseStr);
        if (success!=nil) {
            success(responseStr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* error2 = [NSString stringWithFormat:@"%ld:%@",(long)operation.response.statusCode,[NSHTTPURLResponse localizedStringForStatusCode:operation.response.statusCode]];
        ERROR(@"Error: %@", error2);
        if (failure!=nil) {
            failure(error2);
        }
    }];
}

+(void)PostJsonData:(NSString*)url
 withParameters:(NSDictionary*)params
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSString *error))failure
{
    if (![DLHttpHelper isNetworkReachable]) {
        if (failure!=nil) {
            failure(nil);
        }
        return;
    }
    
    INFO(@"POST URL:%@",url);
    INFO(@"Params:%@",params);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:[DLHttpHelper sharedInstance].timeOut];

    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* responseStr = operation.responseString;
        INFO(@"data: %@",responseStr);
        NSDictionary* responseJsonDic = responseObject;
        if (success!=nil) {
            success(responseJsonDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* error2 = [NSString stringWithFormat:@"%ld:%@",(long)operation.response.statusCode,[NSHTTPURLResponse localizedStringForStatusCode:operation.response.statusCode]];
        ERROR(@"Error: %@", error2);
        if (failure!=nil) {
            failure(error2);
        }
    }];
}

@end
