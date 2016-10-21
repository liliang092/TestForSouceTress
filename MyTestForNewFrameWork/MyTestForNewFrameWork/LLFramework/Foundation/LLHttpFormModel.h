//
//  LLHttpFormModel.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLObejctDefine.h"
@interface LLHttpFormModel : NSObject
AS_FACTORY(LLHttpFormModel)
AS_MODEL_STRONG(NSString, filePath);
AS_MODEL_STRONG(NSString, fileKey);
AS_MODEL_STRONG(NSURL, fileUrl);
@end
