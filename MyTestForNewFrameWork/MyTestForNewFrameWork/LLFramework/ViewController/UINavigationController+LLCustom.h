//
//  UINavigationController+LLCustom.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLObejctDefine.h"
#import "Defaultype.h"
#import "LLCustomNavBarView.h"
#import <objc/runtime.h>
#import "UIViewController+LLCustom.h"

typedef void(^NavLeftClickAction)();
typedef void(^NavRightClickAction)();
@interface UINavigationController (LLCustom)<LLCustomNavBarDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>

AS_MODEL_STRONG(LLCustomNavBarView, myNavBarview);

AS_BLOCK(NavLeftClickAction, myLeftClickAction);

AS_BLOCK(NavRightClickAction, myRightClickAction);

//AS_MODEL_STRONG(UIViewController, currentShowVc);

+(instancetype)sharedInstanceRoot:(UIViewController*)controller;

-(instancetype)initWithRootViewController:(UIViewController *)rootViewControllers;

-(void)addCustomNavBar:(NSString*)title
                              withLeftBtn:(NSString*)leftImage
                             withRightBtn:(NSString*)rightImage
                            withLeftLabel:(NSString*)leftLabel
                           withRightLabel:(NSString*)rightLabel;
-(void)showTableBar:(BOOL)showTabbar;
@end
