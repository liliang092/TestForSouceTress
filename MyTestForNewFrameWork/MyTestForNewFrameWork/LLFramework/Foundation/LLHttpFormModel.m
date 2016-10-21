//
//  LLHttpFormModel.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "LLHttpFormModel.h"

@implementation LLHttpFormModel
DEF_FACTORY(LLHttpFormModel);
DEF_MODEL(fileKey);
DEF_MODEL(fileUrl);
DEF_MODEL(filePath);
-(void)setFilePath:(NSString *)Path
{
    filePath = Path;
    self.fileUrl = [NSURL URLWithString:Path];
}
@end
