//
//  UIViewController+LLCustom.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLObejctDefine.h"
#import "LLCustomNavBarView.h"
@interface UIViewController (LLCustom)<LLCustomNavBarDelegate>
@property(nonatomic,strong)UIView *stateView;
@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)LLCustomNavBarView *custonNavView;

//-(void)addCustomNavBar:(NSString*)title
//           withLeftBtn:(NSString*)leftImage
//          withRightBtn:(NSString*)rightImage
//         withLeftLabel:(NSString*)leftLabel
//        withRightLabel:(NSString*)rightLabel;

-(void)addTapToBaseView;
-(void)baseSingleTap;

-(void)addKeywordNotify;
-(void)removeAllNotify;

-(void)notifyshowKeyword:(CGRect)keyRect;
-(void)notifyhideKeyword;
@end
