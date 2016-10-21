//
//  UITabBarController+Custom.m
//  TeacherWhereGo
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 liliang. All rights reserved.
//

#import "UITabBarController+Custom.h"
#import <objc/runtime.h>
#import "Defaultype.h"
@implementation UITabBarController (Custom)

-(void)setMyItemsArr:(NSMutableArray *)myItemsArr
{
    objc_setAssociatedObject(self, @selector(myItemsArr),myItemsArr,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSMutableArray *)myItemsArr
{
    return objc_getAssociatedObject(self, @selector(myItemsArr));
}
-(void)setCustomTabbar:(SUCustomTabbar *)customTabbar
{
    objc_setAssociatedObject(self,@selector(customTabbar),customTabbar,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)customTabbar
{
    return objc_getAssociatedObject(self, @selector(customTabbar));
}
-(instancetype)init
{
    if (self = [super init]) {
        [self initCustomTabbar];
        self.myItemsArr = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)initCustomTabbar
{
    self.tabBar.hidden = YES;
    self.customTabbar = [[SUCustomTabbar alloc]initWithFrame:self.tabBar.frame];
    self.customTabbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customTabbar];
    self.customTabbar.myDeleaget = self;
}
-(void)addItemTitle:(NSString *)title andWithSelectImage:(NSString *)selectImage andWithNomalImage:(NSString *)normalImage andWithColor:(UIColor *)nomalColor andWithSelectColor:(UIColor *)selectColor andWith:(UIViewController *)viewController
{
    LLCustonTabbarModel *itemModel = [[LLCustonTabbarModel  alloc]init];
    itemModel.title = title;
    itemModel.nomalImage = normalImage;
    itemModel.selectedImage = selectImage;
    itemModel.selectColor = selectColor;
    itemModel.nomalColor = nomalColor;
    [self.myItemsArr addObject:itemModel];
    [self.customTabbar upMyDatas:self.myItemsArr];
    
}
//是否显示下边控制菜单
-(void)showOrHideCustomTabaBar:(BOOL)sender
{
    if (self.customTabbar.hidden == !sender) {
        return;
    }
    
    [UIView beginAnimations:@"TabbarHide" context:nil];
    CGRect tempRect = self.customTabbar.frame;
    if ( sender )
    {
        tempRect.origin.y = self.view.bounds.size.height - TabBarHeight;
    }
    else
    {
        tempRect.origin.y = self.view.bounds.size.height;
    }
    
    self.customTabbar.frame = tempRect;
    
    self.customTabbar.hidden = !sender;
    
    [UIView commitAnimations];
}

- (void)makeTabBarHidden:(BOOL)hide
{
    if ( [self.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView;
    
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.view.subviews objectAtIndex:0];
    }
    [UIView beginAnimations:@"TabbarHide" context:nil];
    if ( hide )
    {
        contentView.frame = self.view.bounds;
    }
    else
    {
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height - self.customTabbar.frame.size.height);
    }
    
    self.customTabbar.hidden = hide;
    
    [UIView commitAnimations];
}


#pragma mark SUCustomTabbarDelegate
-(void)clickAtIndex:(NSInteger)index
{
    [self setSelectedIndex:index];
    NSLog(@"%ld",index);    
    NSLog(@"%@",self.selectedViewController.view.backgroundColor);
}
@end
