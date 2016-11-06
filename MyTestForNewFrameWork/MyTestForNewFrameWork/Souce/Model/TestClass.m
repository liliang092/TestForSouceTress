//
//  TestClass.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 2016/10/30.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass
-(void)dealloc
{
    NSLog(@"%@,对象被释放啦",_name);
}
@end
