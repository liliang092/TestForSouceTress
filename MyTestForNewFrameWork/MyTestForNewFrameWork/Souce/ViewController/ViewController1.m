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
#import "LLShareView.h"
#import "Defaultype.h"
#import "TestClass.h"
#import "LLShowNeesLogInView.h"

@interface ViewController1 ()
@property(nonatomic,strong)UIButton *itemButton;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
//    [self strongVSAutorelease2];
//    tempView.center = CGPointMake(self, CGFloat y)
    self.view.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view.
}
//当块代码：zhizhen
-(void)test
{
    //测试用的代码块
    {
        //默认为抢引用的变量
        TestClass *obj1 = [TestClass new];
        obj1.name = @"obj";
    }
    NSLog(@"在出上面大括号时，指针变量被释放，堆分配的内存也会被立即释放");
}
//结果是先打印对象释放，再打印下面那句话
//从运行结果来看，出代码块后我们定义的指针变量会随着我们的代码块的结束而释放，堆分配的内存也会被立即释放

-(void)test2
{
    {
        TestClass *obj1 = [TestClass new];
        obj1.name = @"obj";
        
        obj1 = [TestClass new];
        NSLog(@"经过上一步会释放第一次分配的堆内存");
        
        obj1.name = @"bji_new";
    }
    NSLog(@"大括号会释放第二次分配的内存");
}
//打印的结果
//obj,对象被释放啦
//经过上一步会释放第一次分配的堆内存
//bji_new,对象被释放啦
//大括号会释放第二次分配的内存
//分析结果原因：我们先给strong类型的对象指针分类内存空间，然后再次分配内存空间，在第二次分配空间的时候，就没有对象指向原来的内存空间，所以在第二次分配的时候就会把原有的内存空间给释放掉，在出代码块的时候，对象指针也会随着栈内存的释放而释放掉，也没有对象指向第二次分配的内存，所以也会被释放掉

-(void)test3
{
    
    {
        TestClass *class =[TestClass new];
        class.name = @"obj2";
        
        class = nil;
        
        NSLog(@"把指针置为空，指针指向的内存空间也会被释放掉");
    }
}
//打印结果
//obj对象被释放
//把指针置为nil,就相当于没有指针指向该内存空间，所以strong下也会被立即释放

-(void)test4
{
    {
        TestClass *obj = [TestClass new];
        obj.name = @"obj";
        
        TestClass *obj2 = obj;
        
        obj2 = nil;
        NSLog(@"obj1指向的内存不会释放，因为还有obj2指向");
        
    }
}
//打印结果
//obj1指向的内存不会释放，因为还有obj2指向
//obj,对象被释放；
//当两个指针同时指向一块内存空间时；把原有的指针置为空，这块内存不会释放因为还有其他指针指向该内存空间




//week:归零弱引用:在弱引用指针指向的内存指针被释放后，弱引用的指针则会置为nil
-(void)test5
{
    __weak TestClass *obj1;
    {
        TestClass *obj2 = [TestClass new];
        obj2.name = @"obj2";
        obj1 = obj2;
        NSLog(@"强制引用堆分配得内存空间北释放前obj的地址为：%p",obj1);
    }
    NSLog(@"强制引用堆分配得内存空间被释放后obj1的地址为:%p",obj1);
}
//打印结果
//强制引用堆分配得内存空间北释放前obj的地址为：0x608000200b60
//obj2,对象被释放啦
//强制引用堆分配得内存空间被释放后obj1的地址为:0x0
//代码说明:当出大括号时抢引用会被释放掉，之前开辟的堆内存空间只有一个弱引用指向它，所以在arc中会被自动释放掉，弱引用的指针会被置为零



//三:__autoreleasing 自动释放，一般结合着@autoreleasepool 使用
//1.自动释放类型和自动释放池配合，提前释放对象，会产生野指针
-(void) autoReleaseTest1
{
    //定义自动释放对象指针
    __autoreleasing TestClass *obj;
    //定义释放池
    @autoreleasepool {
        obj = [TestClass new];
        obj.name =@"obj";
    }
//    此时obj为野指针
    NSLog(@"obj_p = %p",obj);
}
//运行结果:
//obj,对象被释放啦
//obj_p = 0x608000016490
//代码说明:自动释放结束后，自动对象指针指向的内存空间就会被释放，但上面的用法会产生野指针

-(void)test6
{
    @autoreleasepool {
        __autoreleasing TestClass *obj;
        {
            obj = [TestClass new];
            obj.name = @"obj";
            obj = nil;
            
            NSLog(@"把自动释放对象在自动释放池里置为空，其所指向内存空间是不会被释放的");
        }
        NSLog(@"出上面的大括号，只要不出自动释放池是不释放所指的内存空间的");
    }
}
//打印结果
//1:把自动释放对象在自动释放池里置为空，其所指向内存空间是不会被释放的
//2：出上面的大括号，只要不出自动释放池是不释放所指的内存空间的
//3：obj,对象被释放啦
//分析结果
//由运行结果可以看出即使把指向内存空间的自动释放类型的指针置为空，其对应的内存空间不像抢引用那样直接释放掉，而是等到自动释放池结束后再释放，这就是延迟释放

//被自动释放类型的指针用的内存空间，在自动释放池结束的时候一样会被释放
-(void)testRelease3
{
    @autoreleasepool {
        __autoreleasing TestClass *obj;
        {
            obj = [TestClass new];
            obj.name = @"firstObj";
            
            NSLog(@"上面的内存空间会由于下面的操作造成暂时的内存泄漏");
            
            obj = [TestClass new];
            obj.name  = @"secondObj";
            
        }
    }
    NSLog(@"同时释放了两个，上面分配的内存空间被自动释放类型的变量用过，出自动释放池时会被释放");
}
//打印结果
//上面的内存空间会由于下面的操作造成暂时的内存泄漏
//secondObj,对象被释放啦
//firstObj,对象被释放啦
//同时释放了两个，上面分配的内存空间被自动释放类型的变量用过，出自动释放池时会被释放
//结果分析:上面的代码可能会引起内存的泄漏，因为第一次分配内存空间的时候如果我们往对象里加入的是一个视屏，那么第二次自动释放类型的指针分配内存的时候，前面的内存空间不会被释放掉，知道自动释放池结束后两个内存空间才会被释放掉


//strong，autorelease,weak混合在一起使用情况
//在weak中的例子，我们能过得到weak和strong同指向一块内存空间中，当strong的指针不指向该内存空间时，这块内存空间就可以被释放，而weak指针被置为nil
-(void)strongAutorelease
{
    {
    //    定义抢引用对象指针
        TestClass *obj;
        @autoreleasepool {
    //        定义自动释放类型对象
            __autoreleasing TestClass *obj1 =[TestClass new];
            obj1.name = @"obj1";
            obj = obj1;
        }
        NSLog(@"自动释放类型的对象不会被释放，因为strong类型的指针指向他");
        
    }
    NSLog(@"出了大括号强类型的指针被释放，其指向的内存地址也会被释放");
    
}
//打印结果
//自动释放类型的对象不会被释放，因为strong类型的指针指向他
//obj1,对象被释放啦
//出了大括号强类型的指针被释放，其指向的内存地址也会被释放
//运行结果分析:上面想让自动释放类型的指针指向该内存空间，然后再使强类型的指针指向该内存空间，在出自动释放池的时候不会释放该内存空间，才释放内存空间
-(void)strongVSAutorelease2
{
    @autoreleasepool {
        __autoreleasing TestClass *obj = [TestClass new];
        obj.name = @"obj";
        {
            //定义抢引用类型的对象
            __strong TestClass *obj1 = obj;
            //自动释放类型的对象指针指向强引用类型类型内存空间
            obj1 = nil;
        }
        NSLog(@"当obj1值空是其指向的内存空间不会被释放");
    }
    NSLog(@"当出了自动释放池的时候，该内存空间会被释放");
}
//打印结果：
//当obj1值空是其指向的内存空间不会被释放
//obj,对象被释放啦
//当出了自动释放池的时候，该内存空间会被释放


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
    LLShareView *share = [[LLShareView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [share addIconItem:@"QQ分享" withIcon:@"iv_qq_normal"];
    [share addIconItem:@"微信分享" withIcon:@"iv_wx_friend_normal"];
    [share addIconItem:@"微博分享" withIcon:@"iv_weibo_normal"];
    [share updateData];
    share.block = ^(NSInteger tag)
    {
        switch (tag) {
            case 0:
            {
                NSLog(@"取消分享");
            }
                break;
            case 1:
            {
                NSLog(@"微信分享");
            }
            case 2:
            {
                NSLog(@"微博分享");
            }
            default:
                break;
        }
    };
//    [share showInView];
    LLShowNeesLogInView *viewa = [[LLShowNeesLogInView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, self.baseView.frame.size.height)];
    [viewa showInView];
    viewController4 *view = [[viewController4 alloc]init];
//    [self.tabBarController setHidesBottomBarWhenPushed:YES];
//    [APPDELEGATE.viewContoller.myTabViewController showOrHideCustomTabaBar:NO];
//
//    [self.navigationController pushViewController:view animated:YES];
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
