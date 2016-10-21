//
//  UITabBarController+Custom.h
//  TeacherWhereGo
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 liliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLCustonTabbarModel.h"
#import "SUCustomTabbar.h"
#import "LLObejctDefine.h"
@interface UITabBarController (Custom)<SUCustomTabbarDelegate>
AS_MODEL_STRONG(SUCustomTabbar, customTabbar);
AS_MODEL_STRONG(NSMutableArray, myItemsArr);

-(void)addItemTitle:(NSString *)title andWithSelectImage:(NSString *)selectImage andWithNomalImage:(NSString *)normalImage andWithColor:(UIColor *)nomalColor andWithSelectColor:(UIColor *)selectColor andWith:(UIViewController *)viewController;
-(void)showOrHideCustomTabaBar:(BOOL)sender;
@end


