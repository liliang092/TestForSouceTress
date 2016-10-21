//
//  LLBaseViewController.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/22.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLObejctDefine.h"
#import "LLCustomNavBarView.h"
@interface LLBaseViewController : UIViewController<LLCustomNavBarDelegate,UITextFieldDelegate>

AS_MODEL_STRONG(UIView,baseView);
AS_MODEL_STRONG(UIView,stateView);

AS_MODEL_STRONG(LLCustomNavBarView,customNavBar);

AS_BOOL(needHideTabBar);

-(void)addCustomNavBar:(NSString*)title
           withLeftBtn:(NSString*)leftImage
          withRightBtn:(NSString*)rightImage
         withLeftLabel:(NSString*)leftLabel
        withRightLabel:(NSString*)rightLabel;

-(void)addTapToBaseView;
-(void)baseSingleTap;

-(void)addKeywordNotify;
-(void)removeAllNotify;

-(void)notifyshowKeyword:(CGRect)keyRect;
-(void)notifyhideKeyword;

//-(UITextField*)getTextFiled:(CGRect)frame;

-(void)setNavBarForBlackColocr;
-(void)setNavBarForBlueColor;
-(void)setNavBarForWhithColor;
@end
