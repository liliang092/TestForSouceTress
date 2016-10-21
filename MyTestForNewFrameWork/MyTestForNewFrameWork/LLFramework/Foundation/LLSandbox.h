//
//  LLSandbox.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLObejctDefine.h"
@interface LLSandbox : NSObject
AS_SINGLETON(LLSandbox);

AS_MODEL_READONLY(NSString, appPath);
AS_MODEL_READONLY(NSString, docPath);
AS_MODEL_READONLY(NSString, libPrefPath);
AS_MODEL_READONLY(NSString, libCachePath);
AS_MODEL_READONLY(NSString, tmpPath);

+ (NSString *)appPath;		// 程序目录，不能存任何东西
+ (NSString *)docPath;		// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;	// 配置目录，配置文件存这里
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;		// 缓存目录，APP退出后，系统可能会删除这里的内容


@end
