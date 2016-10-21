//
//  LLBaseViewController.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/22.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "LLBaseViewController.h"
#import "UIViewController+LLCustom.h"
#import "Defaultype.h"
#import "LLObejctDefine.h"
@implementation LLBaseViewController
-(void)viewDidLoad
{
    [super loadView];
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.baseView];
    [self.view sendSubviewToBack:self.baseView];
    
    if (DeviceVersion >= 7.0f) {
        
        UIView* tempstartview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        //[tempstartview setBackgroundColor:[Unity getNavBarBackColor]];
        [tempstartview setBackgroundColor:[UIColor blackColor]];
        self.stateView = tempstartview;
        [self.view addSubview:tempstartview];
        
        self.baseView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    }else{
        self.baseView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
-(void)addTapToBaseView
{
    self.baseView .userInteractionEnabled = YES;
    UITapGestureRecognizer *tempsingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baseViewSingleTap:)];
    tempsingleTap.numberOfTapsRequired = 1;
    [self.baseView addGestureRecognizer:tempsingleTap];
}
-(void)baseViewSingleTap:(UITapGestureRecognizer*)gesture
{
    [self baseSingleTap];
}
-(void)baseSingleTap
{
    [APPDELEGATE.window endEditing:YES];
}
-(void)addCustomNavBar:(NSString *)title withLeftBtn:(NSString *)leftImage withRightBtn:(NSString *)rightImage withLeftLabel:(NSString *)leftLabel withRightLabel:(NSString *)rightLabel
{
    if (self.custonNavView == nil) {
        self.custonNavView = [[LLCustomNavBarView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, NavigationBarHeight) withBgImage:nil withTitle:title withLeftBtn:leftImage withRightBtn:rightImage withLeftLabel:leftLabel withRightLabel:rightLabel];
        self.custonNavView.delegate = self;
        self.stateView.backgroundColor = [UIColor whiteColor];
        [self.baseView addSubview:self.custonNavView];
        self.custonNavView.titleLabel.font = [UIFont systemFontOfSize:16];
    }
}
#pragma mark LLCustomNavbarDeleagete
-(void)leftBtnPressed:(id)sender
{
    
}
-(void)rightBtnPressed:(id)sender
{
}
#pragma keyword
-(void)addKeywordNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)removeAllNotify
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)notifyshowKeyword:(CGRect)keyRect
{
}
-(void)notifyhideKeyword
{
}
#pragma mark responding to keyboard events
-(void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    //坐标变换，动画效果
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    keyboardBounds = [self.baseView convertRect:keyboardBounds toView:nil];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:[curve integerValue]];
    [UIView setAnimationDuration:[duration integerValue]];
    
    [self notifyshowKeyword:keyboardBounds];
    [UIView commitAnimations];
    
}
-(void)keyboardWillhide:(NSNotification *)notify
{
    NSNumber *duration = [notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notify.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    //animating seting
    [UIView beginAnimations:nil context:nil];
    [UIView  setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration integerValue]];
    [UIView setAnimationCurve:[curve integerValue]];
    
    int top = 0;
    if (DeviceVersion >= 7.0) {
        top = 20;
    }
    self.baseView.frame = CGRectMake(0, top, self.baseView.frame.size.width, self.baseView.frame.size.height);
    [self notifyhideKeyword];
    [UIView commitAnimations];
    
}

-(void)dealloc
{
    [self removeAllNotify];
}
-(void)setNavBarForBlackColocr
{
    self.customNavBar.backImageView.backgroundColor = UIColorFromRGB(0x222328);
    self.customNavBar.barLine.backgroundColor = UIColorFromRGB(0x222328);
//    self.stateView.backgroundColor = UIColorFromRGB(0x222328);
    self.customNavBar.titleLabel.textColor = UIColorFromRGB(0xffffff);
}
-(void)setNavBarForBlueColor
{
    self.customNavBar.backImageView.backgroundColor = UIColorFromRGB(0x0786e7);
    self.customNavBar.barLine.backgroundColor = UIColorFromRGB(0x0786e7);
    self.stateView.backgroundColor = UIColorFromRGB(0x0786e7);
    self.customNavBar.titleLabel.textColor = UIColorFromRGB(0xffffff);
    
}
-(void)setNavBarForWhithColor
{
    self.customNavBar.backImageView.backgroundColor = UIColorFromRGB(0xffffff);
    self.customNavBar.barLine.backgroundColor = UIColorFromRGB(0xffffff);
    self.stateView.backgroundColor = UIColorFromRGB(0xffffff);
    self.customNavBar.titleLabel.textColor = UIColorFromRGB(0x222328);
}

@end
