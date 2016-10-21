//
//  ViewController1.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "ViewController1.h"
//#import "UIViewController+LLCustom.h"
#import "viewController4.h"
#import "Defaultype.h"

@interface ViewController1 ()
@property(nonatomic,strong)UIButton *itemButton;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
//    tempView.center = CGPointMake(self, CGFloat y)
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}
-(void)initView
{
    [self addCustomNavBar:@"第一页" withLeftBtn:nil withRightBtn:nil withLeftLabel:nil withRightLabel:nil];
    self.itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.itemButton setTitle:@"这厮" forState:UIControlStateNormal];
    self.itemButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.itemButton setBackgroundColor:[UIColor whiteColor]];
    self.itemButton.bounds = CGRectMake(0, 0, 30, 50);
    [self.view addSubview:self.itemButton];
    [self.itemButton addTarget:self action:@selector(myClickAction) forControlEvents:UIControlEventTouchDown];
    NSLog(@"%f",self.view.frame.size.width);
}
-(void)myClickAction
{
    viewController4 *view = [[viewController4 alloc]init];
//    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    [APPDELEGATE.viewContoller.myTabViewController showOrHideCustomTabaBar:NO];

    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark LLCustomNavBarDelegate
-(void)leftBtnPressed:(id)sender
{

}
-(void)rightBtnPressed:(id)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
