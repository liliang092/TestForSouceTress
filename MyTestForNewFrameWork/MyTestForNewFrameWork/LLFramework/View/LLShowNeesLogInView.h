//
//  LLShowNeesLogInView.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/10/27.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLObejctDefine.h"

//tag 0 QQ 1 微信  2 微博 3 手机号
typedef void (^TTShowNeedLogin)(NSInteger tag);
@interface LLShowNeesLogInView : UIView
AS_BLOCK(TTShowNeedLogin, myBlock);
-(void)showInView;
-(void)hiddenView;
@end

typedef void (^TIconViewBlocks)(NSInteger tag);

@interface LL_IconView : UIView

AS_FACTORY_FRAME(M_IconView);

AS_BLOCK(TIconViewBlocks, block);

AS_BOOL(showNum);

-(void)updateModel:(NSString*)icon withText:(NSString*)text;

-(void)updateNum:(NSString*)num;
@end

