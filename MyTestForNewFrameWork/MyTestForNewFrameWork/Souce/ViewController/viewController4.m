
//
//  viewController4.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/21.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "viewController4.h"
#import "AppDelegate.h"
#import "UIViewController+LLCustom.h"
#import "LLBaseViewController.h"
@implementation viewController4
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    NSLog(@"%@",self.baseView);
    self.baseView.backgroundColor = [UIColor greenColor];
}
-(void)initView
{
    [self addCustomNavBar:@"这是第四页" withLeftBtn:nil withRightBtn:nil withLeftLabel:@"返回" withRightLabel:nil];
}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    AppDelegate *appdelegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.viewContoller.myTabViewController showOrHideCustomTabaBar:YES];
}
@end
