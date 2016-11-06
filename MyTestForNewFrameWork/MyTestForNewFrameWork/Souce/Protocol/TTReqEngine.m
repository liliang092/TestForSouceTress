//
//  TTReqEngine.m
//  TickTock
//
//  Created by liliang on 16-10-24.
//  Copyright (c) 2016年 liliang. All rights reserved.
//

#import "TTReqEngine.h"
#import "TTReqProtocol.h"
#import "TTReqUrl.h"
#import "SVProgressHUD.h"
#import "DLHttpHelper.h"
#import "LLBaseDataModel.h"

#define KERROR_CLEW @"联网失败，请重试"
#define KWAIT_STATUS @"请稍候..."

@implementation TTReqEngine

#pragma mark  -  用户接口

//获取普通用户

+(void)C_GetUser_GetSetUid:(NSString *)uid withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
//    [DLHttpHelper GetData:[TTReqUrl C_ReqUser_GetUrl]
//           withParameters:[TTReqProtocol C_GetUser_GetSetUid:uid]
//                  success:^(id responseObject)
//     {
//         [SVProgressHUD dismiss];
//         
//         LLBaseDataModel* tempModel = [[LLBaseDataModel alloc]init];
//         
//         [tempModel parseData:responseObject];
    
//         if (tempModel.s == 0) {
//             
//             NSString* tempPath = [NSString stringWithFormat:@"%@%@",[DLCache libCachesToTemp],@"info"];
//             
//             [DLCache writeString:tempModel.httpBackData toDocumentPath:tempPath];
//             
//             if ([tempModel.user_id notEmpty]) {
//                 [DLAppData sharedInstance].myUserKey = tempModel.user_id;
//                 [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
//                 [JPUSHService setAlias:tempModel.user_id callbackSelector:nil object:nil];
//             }
//             
//             if (block!=nil) {
//                 block(YES,tempModel);
//             }
//         }else{
//             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
//             if (block!=nil) {
//                 block(NO,nil);
//             }
//         }
         
//     } failure:^(NSString *error) {
//         
//         [SVProgressHUD dismissWithError:KERROR_CLEW];
//         if (block!=nil) {
//             block(NO,nil);
//         }
//     }];

}
@end
