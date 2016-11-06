//
//  LLBaseDataModel.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/10/24.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "LLBaseDataModel.h"

@implementation LLBaseDataModel
-(id)init
{
    self = [super init];
    if (self) {
        self.statusCodel = 0;
        self.errMsg = nil;
        self.ctmMsg = nil;
    }
    return self;
}

-(void)parseData:(id )str
{
    if ([str isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        self.data = str;
        self.httpBackData = str;
        
        self.statusCodel = [[self hasItemAndBack:str andWithkey:@"code"] integerValue];
        self.ctmMsg = [self hasItemAndBack:str andWithkey:@"message"];
        
        if (self.statusCodel == 0) {
            [self parseDataDic:str];
        }

    }
    else if([str isKindOfClass:NSClassFromString(@"NSString")])
    {
//        NSDictionary* tempData = [str JSONValue];
        NSDictionary *tempData;
        if (tempData !=nil) {
            
            self.data = tempData;
            self.httpBackData = str;
            
            self.statusCodel = [[self hasItemAndBack:tempData andWithkey:@"code"] integerValue];
            self.ctmMsg = [self hasItemAndBack:tempData andWithkey:@"message"];
            
            if (self.statusCodel == 200) {
                [self parseDataDic:tempData];
            }
        }
    }
}

-(void)parseDataDic:(NSDictionary*)str
{
    
}
-(id)hasItemAndBack:(NSDictionary*)dic andWithkey:(NSString *)key
{
    if ([dic objectForKey:key]!=nil) {
        if ([dic objectForKey:key] == NULL) {
            return nil;
        }
        if ([[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
            return nil;
        }
        return [dic objectForKey:key];
    }
    return nil;
}

@end
