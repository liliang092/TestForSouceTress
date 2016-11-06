//
//  LLShareView.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/10/22.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLObejctDefine.h"
#import "LLShareView.h"
typedef void (^TShareViewBlock)(NSInteger tag);
@interface LLShareView : UIView
AS_BLOCK(TShareViewBlock, block);
AS_MODEL_STRONG(NSMutableArray, myIconArray);

-(void)addIconItem:(NSString*)name withIcon:(NSString*)icon;

-(void)updateData;

-(void)showInView;
@end

typedef void (^TIconViewBlock)(NSInteger tag);

@interface M_IconView : UIView


AS_FACTORY_FRAME(M_IconView);

AS_BLOCK(TIconViewBlock, block);

AS_BOOL(showNum);

-(void)updateModel:(NSString*)icon withText:(NSString*)text;

-(void)updateNum:(NSString*)num;
@end
