//
//  LLSandbox.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "LLSandbox.h"
@interface LLSandbox()
{
    NSString *	_appPath;
    NSString *	_docPath;
    NSString *	_libPrefPath;
    NSString *	_libCachePath;
    NSString *	_tmpPath;
}
@end
@implementation LLSandbox
DEF_SINGLETON(DLSandbox);

DEF_MODEL(appPath);
DEF_MODEL(docPath);
DEF_MODEL(libCachePath);
DEF_MODEL(libPrefPath);
DEF_MODEL(tmpPath);
// 程序目录，不能存任何东西
+ (NSString *)appPath
{
    return [LLSandbox sharedInstance].appPath;
}

- (NSString *)appPath
{
    if ( nil == _appPath )
    {
        NSString * exeName = [[NSBundle mainBundle] infoDictionary][@"CFBundleExecutable"];
        NSString * tempappPath = [[NSHomeDirectory() stringByAppendingPathComponent:exeName] stringByAppendingPathExtension:@"app"];
        
        _appPath = tempappPath;
    }
    
    return _appPath;
}
// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)docPath
{
    return [[LLSandbox sharedInstance] docPath];
}

- (NSString *)docPath
{
    if ( nil == _docPath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _docPath = [paths objectAtIndex:0];
    }
    
    return _docPath;
}
// 配置目录，配置文件存这里
+ (NSString *)libPrefPath
{
    return [[LLSandbox sharedInstance] libPrefPath];
}

- (NSString *)libPrefPath
{
    if ( nil == _libPrefPath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
        
        [self createNewDir:path];
        
        _libPrefPath = path;
    }
    
    return _libPrefPath;
}
// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)libCachePath
{
    return [[LLSandbox sharedInstance] libCachePath];
}

- (NSString *)libCachePath
{
    if ( nil == _libCachePath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
        
        [self createNewDir:path];
        
        _libCachePath = path;
    }
    
    return _libCachePath;
}
// 缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)tmpPath
{
    return [[LLSandbox sharedInstance] tmpPath];
}

- (NSString *)tmpPath
{
    if ( nil == _tmpPath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
        
        [self createNewDir:path];
        
        _tmpPath = path;
    }
    
    return _tmpPath;
}
-(BOOL)isDirExists:(NSString*)dirPath
{
    BOOL isdir = YES;
    return [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isdir];
}
-(void)createNewDir:(NSString*)path
{
    [NSFileManager defaultManager];
    
    if (![self isDirExists:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
}


@end
