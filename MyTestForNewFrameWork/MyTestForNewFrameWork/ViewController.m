//
//  ViewController.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "ViewController.h"
#import "Souce/ViewController/ViewController1.h"
#import "Souce/ViewController/ViewController2.h"
#import "Souce/ViewController/ViewController3.h"
//#import "UINavigationController+LLCustom.h"
#import "DLBaseNavigationController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initView
{
    self.myTabViewController = [[UITabBarController alloc]init];
    LLBaseViewController *viewcontroller1 = [[ViewController1 alloc]init];
    DLBaseNavigationController *nav1 = [[DLBaseNavigationController alloc]initWithRootViewController:viewcontroller1];
    nav1.navigationBar.hidden = YES;
    
//    [nav1 addCustomNavBar:@"第一页" withLeftBtn:nil withRightBtn:nil withLeftLabel:nil withRightLabel:nil];
//    nav1.myLeftClickAction = ^(){
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    nav1.stateView.backgroundColor = [UIColor whiteColor];
//    nav1.custonNavView.backgroundColor = [UIColor whiteColor];

    
    LLBaseViewController *viewcontroller2 = [[ViewController2 alloc]init];
    DLBaseNavigationController *nav2 = [[DLBaseNavigationController alloc]initWithRootViewController:viewcontroller2];
//    [nav2 addCustomNavBar:@"第二页" withLeftBtn:nil withRightBtn:nil withLeftLabel:nil withRightLabel:nil];
//    nav2.stateView.backgroundColor = [UIColor whiteColor];
//    nav2.custonNavView.backgroundColor = [UIColor whiteColor];
    nav2.navigationBar.hidden = YES;
    
//    nav2.myLeftClickAction = ^(){
//        [self.navigationController popViewControllerAnimated:YES];
//    };
    LLBaseViewController *viewcontroller3 = [[ViewController3 alloc]init];
    DLBaseNavigationController *nav3 = [[DLBaseNavigationController alloc]initWithRootViewController:viewcontroller3];
    nav3.navigationBar.hidden = YES;
//    [nav3 addCustomNavBar:@"第三页" withLeftBtn:nil withRightBtn:nil withLeftLabel:nil withRightLabel:nil];
//    nav3.stateView.backgroundColor = [UIColor whiteColor];
//    nav3.custonNavView.backgroundColor = [UIColor whiteColor];
//    
//    nav3.myLeftClickAction = ^(){
//        [self.navigationController popViewControllerAnimated:YES];
//    };
   
    [self.myTabViewController addItemTitle:@"第一页" andWithSelectImage:nil andWithNomalImage:nil andWithColor:[UIColor blackColor] andWithSelectColor:[UIColor redColor] andWith:nav1];
    
    [self.myTabViewController addItemTitle:@"第er页" andWithSelectImage:nil andWithNomalImage:nil andWithColor:[UIColor blackColor] andWithSelectColor:[UIColor redColor] andWith:nav2];
    [self.myTabViewController addItemTitle:@"第san页" andWithSelectImage:nil andWithNomalImage:nil andWithColor:[UIColor blackColor] andWithSelectColor:[UIColor redColor] andWith:nav3];
    self.myTabViewController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nil];
    [self.view addSubview:self.myTabViewController.view];
    self.myTabViewController.selectedIndex = 0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
