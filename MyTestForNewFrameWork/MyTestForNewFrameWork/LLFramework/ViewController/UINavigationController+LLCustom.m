//
//  UINavigationController+LLCustom.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "UINavigationController+LLCustom.h"
#import "LLObejctDefine.h"
@implementation UINavigationController (LLCustom)
-(void)setMyNavBarview:(LLCustomNavBarView *)myNavBarview
{
    objc_setAssociatedObject(self, @selector(myNavBarview), myNavBarview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(LLCustomNavBarView *)myNavBarview
{
    return objc_getAssociatedObject(self, @selector(myNavBarview));
}
-(void)setMyLeftClickAction:(NavLeftClickAction)myLeftClickAction
{
    objc_setAssociatedObject(self, @selector(myLeftClickAction), myLeftClickAction, OBJC_ASSOCIATION_ASSIGN);
}
-(NavLeftClickAction)myLeftClickAction
{
    return objc_getAssociatedObject(self, @selector(myLeftClickAction));
}
-(void)setMyRightClickAction:(NavRightClickAction)myRightClickAction
{
    objc_setAssociatedObject(self, @selector(myRightClickAction), myRightClickAction, OBJC_ASSOCIATION_ASSIGN);
}
-(NavRightClickAction)myRightClickAction
{
    return objc_getAssociatedObject(self, @selector(myRightClickAction));
}
-(UIViewController *)currentShowVc
{
    return objc_getAssociatedObject(self, @selector(currentShowVc) );
}
-(void)setCurrentShowVc:(UIViewController *)currentShowVc
{
    objc_setAssociatedObject(self, @selector(currentShowVc), currentShowVc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+(instancetype)sharedInstanceRoot:(UIViewController *)controller
{
    return [[UINavigationController alloc]initWithRootViewController:controller];
}

-(void)addCustomNavBar:(NSString *)title withLeftBtn:(NSString *)leftImage withRightBtn:(NSString *)rightImage withLeftLabel:(NSString *)leftLabel withRightLabel:(NSString *)rightLabel
{
    if (self.myNavBarview == nil) {
        self.myNavBarview = [[LLCustomNavBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, NavigationBarHeight) withBgImage:nil withTitle:title withLeftBtn:leftImage withRightBtn:rightImage withLeftLabel:leftLabel withRightLabel:rightLabel];
        self.navigationBar.hidden = YES;
        self.myNavBarview.delegate  = self;
        if (self.baseView == nil) {
            self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:self.baseView];
            
            if (DeviceVersion >= 7.0f) {
                
                UIView* tempstartview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
                self.stateView = tempstartview;
                [self.view addSubview:tempstartview];
                
                self.baseView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20);
            }else{
                self.baseView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            }
        }
        CGRect frame = self.myNavBarview.frame;
        frame.origin.y = CGRectGetMaxY(self.stateView.frame);
        self.myNavBarview.frame = frame;
        
        [self.view addSubview:self.myNavBarview];
        NSLog(@"baseView = %@,view = %@",self.baseView,self.view);
        [self.baseView bringSubviewToFront:self.myNavBarview];
    }
    else
    {
        [self.myNavBarview updateTitle:title];
        [self.myNavBarview updateRightBtn:rightLabel withImage:rightImage];
        [self.myNavBarview updateLeftBtn:leftLabel withImage:leftImage];
    }
    
    self.myNavBarview.delegate = self;
    [self.view sendSubviewToBack:self.baseView];

}
-(void)showTableBar:(BOOL)showTabbar
{
    [APPDELEGATE.viewContoller.myTabViewController showOrHideCustomTabaBar:showTabbar];
}
#pragma Mark LLCustomNavBarDelegate 
-(void)leftBtnPressed:(id)sender
{
}
-(void)rightBtnPressed:(id)sender
{
}
@end
