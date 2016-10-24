//
//  LLShareView.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/10/22.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "LLShareView.h"
@interface LLShareView ()
@property(nonatomic,strong)UIWindow *shareWindow;
@property(nonatomic,strong)UIView *shareView;
@property(nonatomic,strong)UIButton *cancalBtn;

@end
@implementation LLShareView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.myIconArray = [NSMutableArray allocInstance];
        [self setDefault];
        [self initShareView];
    }
    return self;
}
-(void)setDefault
{
    self.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenAndDismiss)];
    [self addGestureRecognizer:tap];
    
}
//-(void)initShareWindow{
//    self.shareWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    self.shareWindow.windowLevel = UIWindowLevelAlert;
//    [self.shareWindow setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
//    [self.shareWindow setBackgroundColor:[UIColor grayColor]];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenAndDismiss)];
//    UIViewController *viewController = [[UIViewController alloc]init];
//    [viewController.view setBackgroundColor:[UIColor yellowColor]];
//    self.shareWindow.rootViewController = viewController;
//    [self.shareWindow.superview addGestureRecognizer:tap];
//    
//}
-(void)initShareView{
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    [self.shareWindow addSubview:self.shareView];
    [self.shareView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.shareView];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.shareView.frame.size.width, 20)];
    [titleLable setBackgroundColor:[UIColor whiteColor]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [titleLable setTextColor:[UIColor blackColor]];
    titleLable.font = [UIFont systemFontOfSize:12];
    [self.shareView addSubview:titleLable];
    
    self.cancalBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(self.shareView.frame)-2, CGRectGetWidth(self.shareView.frame)-20, 16)];
    [self.cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancalBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cancalBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.cancalBtn addTarget:self action:@selector(clickCancle:) forControlEvents:UIControlEventTouchDown];
    [self.shareView addSubview:self.cancalBtn];
}
-(void)addIconItem:(NSString*)name withIcon:(NSString*)icon
{
    NSMutableDictionary* tempDic = [NSMutableDictionary allocInstance];
    
    [tempDic setObject:name forKey:@"name"];
    [tempDic setObject:icon forKey:@"icon"];
    
    [self.myIconArray addObject:tempDic];
}
-(void)updateData
{
    
    NSInteger count = [self.myIconArray count];
    CGFloat w = self.shareView.frame.size.width/4;
    CGFloat h = 60;
    CGFloat x =0;
    CGFloat y=20;
    CGRect frame = self.shareView.frame;
    if (count !=0) {
        if (count%4 != 0) {
            frame.size.height = 50+60*(count/4+1);
        }
        else
        {
            frame.size.height = 50+60*(count/4);
        }
        frame.origin.y = ScreenHeight-frame.size.height;
        
    }
    self.shareView.frame = frame;
    
    for (int i=0; i<count; i++) {
        NSDictionary* tempDic = [self.myIconArray objectAtIndex:i];
        if (tempDic!=nil) {
            NSString* tempName = [tempDic hasItemAndBack:@"name"];
            NSString* tempIocn = [tempDic hasItemAndBack:@"icon"];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:tempName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:tempIocn] forState:UIControlStateNormal];
            
            button.tag = 1000+i;
            [button addTarget:self action:@selector(myClickAction:) forControlEvents:UIControlEventTouchDown];
            button.frame = CGRectMake(x, y, w, h);
            [self.shareView addSubview:button];
            if ((i+1)%4==0) {
                x=0;
            }
            else
            {
                x+=w;
                y= 20+(i/4)*60.0;
            }
        }
    }
    
    frame= self.cancalBtn.frame;
    frame.origin.y = self.shareView.frame.size.height+2-20;
    self.cancalBtn.frame = frame;
}
-(void)hiddenAndDismiss
{
    [self removeFromSuperview];
}
-(void)showInView
{
//    APPDELEGATE.window.windowLevel =1.2;
//    self.shareWindow.windowLevel =0.0;
//    self.shareWindow.hidden = NO;
//    [self.shareWindow makeKeyAndVisible];
//    [self.shareWindow makeKeyAndVisible];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
}
-(void)myClickAction:(id)sender
{
    [self hiddenAndDismiss];
    UIButton *but = (UIButton *)sender;
    if (self.block!= nil) {
        self.block(but.tag-1000);
    }
}
-(void)clickCancle:(id)sender
{
    [self hiddenAndDismiss];
    if (self.block != nil) {
        self.block(0);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
