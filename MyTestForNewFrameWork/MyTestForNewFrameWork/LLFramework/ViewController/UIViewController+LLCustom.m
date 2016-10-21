//
//  UIViewController+LLCustom.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "UIViewController+LLCustom.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#import "Defaultype.h"

@implementation UIViewController (LLCustom)
-(void)setStateView:(UIView *)stateView
{
    objc_setAssociatedObject(self,@selector(stateView),stateView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)stateView
{
    return objc_getAssociatedObject(self, @selector(stateView));
}
-(void)setBaseView:(UIView *)baseView
{
    objc_setAssociatedObject(self, @selector(baseView), baseView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)baseView
{
    return objc_getAssociatedObject(self,@selector(baseView));
}

-(void)setCustonNavView:(LLCustomNavBarView *)custonNavView
{
    objc_setAssociatedObject(self, @selector(custonNavView), custonNavView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(LLCustomNavBarView *)custonNavView
{
    return objc_getAssociatedObject(self, @selector(custonNavView));
}

//-(void)addCustomNavBar:(NSString *)title withLeftBtn:(NSString *)leftImage withRightBtn:(NSString *)rightImage withLeftLabel:(NSString *)leftLabel withRightLabel:(NSString *)rightLabel
//{
//    if (self.custonNavView == nil) {
//        self.custonNavView = [[LLCustomNavBarView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, NavigationBarHeight) withBgImage:nil withTitle:title withLeftBtn:leftImage withRightBtn:rightImage withLeftLabel:leftLabel withRightLabel:rightLabel];
//        [self.baseView addSubview:self.custonNavView];
//        self.custonNavView.delegate = self;
//    }
//    else
//    {
//        [self.custonNavView updateTitle:title];
//        [self.custonNavView updateLeftBtn:leftLabel withImage:leftImage];
//        [self.custonNavView updateLeftBtn:rightLabel withImage:rightImage];
//    }
//}
-(void)addTapToBaseView
{
    if (self.baseView!= nil) {
        self.baseView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baseViewSingleTap:)];
        [self.baseView addGestureRecognizer:tapGesture];
        tapGesture.numberOfTapsRequired = 1;
    }
}
-(void)baseViewSingleTap:(id)sender
{
    [self baseSingleTap];
}
-(void)baseSingleTap
{
     [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window endEditing:YES] ;
}
-(void)addKeywordNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}
-(void)removeAllNotify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)notifyshowKeyword:(CGRect)keyRect
{
    
}
-(void)notifyhideKeyword
{
    
}

#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.baseView convertRect:keyboardBounds toView:nil];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    [self notifyshowKeyword:keyboardBounds];
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // animations settings
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    int top = 0;
    if (DeviceVersion>=7.0) {
        top = 20;
    }
    self.baseView.frame = CGRectMake(0, top, self.baseView.frame.size.width, self.baseView.frame.size.height);
    
    [self notifyhideKeyword];
    
    //    self.myTouchBtn.top = self.animationHeight;
    [UIView commitAnimations];
}


@end
