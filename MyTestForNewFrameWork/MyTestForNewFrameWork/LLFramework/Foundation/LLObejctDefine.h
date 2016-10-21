//
//  LLObejctDefine.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#pragma mark -

#if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON

#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ \
__singleton__ = [[self alloc] init]; \
} ); \
return __singleton__; \
}

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ \
__singleton__ = [[self alloc] init]; \
} ); \
return __singleton__; \
}

#else	// #if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ \
__singleton__ = [[[self class] alloc] init]; \
} ); \
return __singleton__; \
}

#endif	// #if __has_feature(objc_instancetype)

#pragma mark -
#undef	AS_MODEL_STRONG
#define	AS_MODEL_STRONG( __class, __tag ) \
@property (nonatomic, strong) __class *	__tag;

#undef	AS_MODEL_COPY
#define	AS_MODEL_COPY( __class, __tag ) \
@property (nonatomic, copy) __class *	__tag;

#undef	AS_MODEL_ASSIGN
#define	AS_MODEL_ASSIGN( __class, __tag ) \
@property (nonatomic, assign) __class 	__tag;

#undef	AS_MODEL_WEEK
#define	AS_MODEL_WEEK( __class, __tag ) \
@property (nonatomic, week) __class *	__tag;

#undef AS_MODEL_READONLY
#define AS_MODEL_READONLY( __class,  __tag) \
@property (nonatomic,strong,readonly) __class *	__tag;

#undef	AS_BLOCK
#define	AS_BLOCK( __class, __tag) \
@property (nonatomic,copy) __class __tag;

#undef	AS_DELEGATE
#define	AS_DELEGATE( __class, __tag) \
@property (nonatomic,assign) __class __tag;

#undef	AS_MODEL
#define	AS_MODEL( __class, __tag ) \
@property (nonatomic) __class __tag;

#undef	DEF_MODEL
#define	DEF_MODEL( __tag ) \
@synthesize __tag;

#undef	DEF_DYNAMIC
#define	DEF_DYNAMIC( __tag ) \
@dynamic __tag;

#undef  AS_INT_ASSIGN
#define AS_INT_ASSIGN(__tag) \
@property (nonatomic,assign) NSInteger __tag;

#undef  AS_BOOL_ASSIGN
#define AS_BOOL_ASSIGN(__tag) \
@property (nonatomic,assign) BOOL __tag;

#undef  AS_FLOAT_ASSIGN
#define AS_FLOAT_ASSIGN(__tag) \
@property (nonatomic,assign) CGFloat __tag;

#undef  AS_POINT_ASSIGN
#define AS_POINT_ASSIGN(__tag) \
@property (nonatomic,assign) CGPoint __tag;

#undef  AS_SIZE_ASSIGN
#define AS_SIZE_ASSIGN(__tag) \
@property (nonatomic,assign) CGSize __tag;

#undef  AS_RECT_ASSIGN
#define AS_RECT_ASSIGN(__tag) \
@property (nonatomic,assign) CGRect __tag;

#undef  AS_INT
#define AS_INT(__tag) \
AS_MODEL(NSInteger, __tag)

#undef  AS_BOOL
#define AS_BOOL(__tag) \
AS_MODEL(BOOL, __tag)

#undef  AS_FLOAT
#define AS_FLOAT(__tag) \
AS_MODEL(CGFloat, __tag)

#undef  AS_POINT
#define AS_POINT(__tag) \
AS_MODEL(CGPoint, __tag)

#undef  AS_SIZE
#define AS_SIZE(__tag) \
AS_MODEL(CGSize, __tag)

#undef  AS_RECT
#define AS_RECT(__tag) \
AS_MODEL(CGRect, __tag)



#pragma mark -

#undef	AS_FACTORY
#define AS_FACTORY( __class ) \
- (instancetype)allocInstance; \
+ (instancetype)allocInstance;

#undef	DEF_FACTORY
#define DEF_FACTORY( __class ) \
- (instancetype)allocInstance \
{ \
return [__class allocInstance]; \
} \
+ (instancetype)allocInstance \
{ \
return [[[self class] alloc] init]; \
}
#undef	AS_FACTORY_FRAME
#define AS_FACTORY_FRAME( __class) \
- (instancetype)allocInstanceFrame:(CGRect)__frame; \
+ (instancetype)allocInstanceFrame:(CGRect)__frame;

#undef	DEF_FACTORY_FRAME
#define DEF_FACTORY_FRAME( __class) \
- (instancetype)allocInstanceFrame:(CGRect)__frame \
{ \
return [__class allocInstanceFrame:__frame]; \
} \
+ (instancetype)allocInstanceFrame:(CGRect)__frame \
{ \
return [[[self class] alloc] initWithFrame:__frame]; \
}

#pragma mark -
@interface LLObejctDefine : NSObject

@end
