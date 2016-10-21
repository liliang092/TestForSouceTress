//
//  LLLog.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLPrecompile.h"
#import "LLObejctDefine.h"
#import "DLSystemInfo.h"

#if __DL_LOG__

#undef	CC
#define CC( ... )		[[LLLog sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:@"None" format:__VA_ARGS__];

#undef	INFO
#define INFO( ... )		[[LLLog sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:@"Info" format:__VA_ARGS__];

#undef	PERF
#define PERF( ... )		[[LLLog sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:@"Perf" format:__VA_ARGS__];

#undef	WARN
#define WARN( ... )		[[LLLog sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:@"Warn" format:__VA_ARGS__];

#undef	ERROR
#define ERROR( ... )	[[LLLog sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:@"Error" format:__VA_ARGS__];

#undef	PRINT
#define PRINT( ... )	[[LLLog sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) level:@"Print" format:__VA_ARGS__];


#undef	VAR_DUMP
#define VAR_DUMP( __obj )	PRINT( [__obj description] );

#undef	OBJ_DUMP
#define OBJ_DUMP( __obj )	PRINT( [__obj objectToDictionary] );

#else	// #if __DL_LOG__

#undef	CC
#define CC( ... )

#undef	INFO
#define INFO( ... )

#undef	PERF
#define PERF( ... )

#undef	WARN
#define WARN( ... )

#undef	ERROR
#define ERROR( ... )

#undef	PRINT
#define PRINT( ... )

#undef	VAR_DUMP
#define VAR_DUMP( __obj )

#undef	OBJ_DUMP
#define OBJ_DUMP( __obj )


#endif	// #if __DL_LOG__

#undef	TODO
#define TODO( desc, ... )

//#ifdef DEBUG
//    #define DLog(...)  PRINT
//#else
//    #define DLog(format...)
//#endif

@interface LLLog : NSObject
AS_SINGLETON(LLLog);

#if __DL_DEVELOPMENT__
- (void)file:(NSString *)file line:(NSUInteger)line function:(NSString *)function level:(NSString*)level format:(NSString *)format, ...;
- (void)file:(NSString *)file line:(NSUInteger)line function:(NSString *)function level:(NSString*)level format:(NSString *)format args:(va_list)args;
#else	// #if __DL_DEVELOPMENT__
- (void)level:(NSString*)level format:(NSString *)format, ...;
- (void)level:(NSString*)level format:(NSString *)format args:(va_list)args;
#endif	// #if __DL_DEVELOPMENT__

@end
