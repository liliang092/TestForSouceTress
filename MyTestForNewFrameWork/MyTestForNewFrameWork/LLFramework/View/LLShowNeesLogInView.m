//
//  LLShowNeesLogInView.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/10/27.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "LLShowNeesLogInView.h"
@interface LLShowNeesLogInView()
AS_MODEL_STRONG(UIView, mybgView);
AS_MODEL_STRONG(UIView, myCenterView);
AS_MODEL_STRONG(LL_IconView, myQQLoginView);
AS_MODEL_STRONG(LL_IconView, myWCharView);
AS_MODEL_STRONG(LL_IconView, myWBCharView);
AS_MODEL_STRONG(UIView, myLineView);
AS_MODEL_STRONG(UIButton, myPhoneBtn);
AS_MODEL_STRONG(UIButton, myDismissBtn);
@end

@implementation LLShowNeesLogInView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initbgView];
        [self initQQLoginView];
        [self initWCharView];
        [self initWBView];
        [self initLineView];
        [self initPhoneBtnView];
        [self initDismissBtn];
    }
    return self;
}
-(void)initbgView
{
    self.mybgView= [[UIView alloc] init];
    self.mybgView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.mybgView];
}
-(void)initQQLoginView
{
    self.myQQLoginView = [[LL_IconView alloc]initWithFrame:CGRectZero];
   
    self.myQQLoginView.tag =1000;
    __weak LLShowNeesLogInView *weakSelf = self;
    self.myQQLoginView.block = ^(NSInteger tag){
        if (weakSelf.myBlock != nil) {
              [weakSelf hiddenView];
            weakSelf.myBlock(tag-1000);
        }
    };
    [self.mybgView addSubview:self.myQQLoginView];
}
-(void)initWCharView
{
    self.myWCharView = [[LL_IconView alloc]initWithFrame:CGRectZero];
    
    __weak LLShowNeesLogInView *weakSelf= self;
    self.myWCharView.tag = 1001;
    self.myWCharView.block = ^(NSInteger tag)
    {
        if (weakSelf.myBlock != nil) {
              [weakSelf hiddenView];
            weakSelf.myBlock(tag -1000);
        }
    };
    [self.mybgView addSubview:self.myWCharView];
}
-(void)initWBView
{
    self.myWBCharView = [[LL_IconView alloc]initWithFrame:CGRectZero];
    
    __weak LLShowNeesLogInView *weakSelf= self;
    self.myWBCharView.tag = 1002;
    self.myWBCharView.block = ^(NSInteger tag)
    {
        if (weakSelf.myBlock != nil) {
              [weakSelf hiddenView];
            weakSelf.myBlock(tag -1000);
        }
    };
    [self.mybgView addSubview:self.myWBCharView];
}
-(void)initLineView
{
    self.myLineView = [[UIView alloc]initWithFrame:CGRectZero];
    self.myLineView.backgroundColor = [UIColor whiteColor];
    [self.mybgView addSubview:self.myLineView];
}
-(void)initPhoneBtnView
{
    self.myPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myPhoneBtn setTitle:@"手机号登录" forState:UIControlStateNormal];
    [self.mybgView addSubview:self.myPhoneBtn];
    [self.myPhoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myPhoneBtn addTarget:self action:@selector(phoneLogin:) forControlEvents:UIControlEventTouchDown];
    self.myPhoneBtn.tag = 1003;
    
}
-(void)initDismissBtn
{
    self.myDismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myDismissBtn setImage:[UIImage imageNamed:@"updateAlertDelete"] forState:UIControlStateNormal];
    [self.myDismissBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.myDismissBtn];
    self.myDismissBtn.hidden = YES;
}
-(void)phoneLogin:(UIButton *)btn
{
    if (self.myBlock != nil) {
        [self hiddenView];
        self.myBlock(btn.tag-1000);
    }
}
-(void)showInView
{
    self.mybgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.mybgView.bounds = CGRectMake(0, 0, self.frame.size.width-40, self.frame.size.width-40);
    
    //获取最后的windows ,在windos上面添加这个View
    UIWindow *lastWindows = [[UIApplication sharedApplication].windows lastObject];
    [lastWindows addSubview:self];
   
    CGRect frame = self.mybgView.frame;
    
    //设置动画效果
    CGAffineTransform transform;
    transform = CGAffineTransformScale(transform, 11, 11);
    [UIView beginAnimations:@"showView" context:nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:@selector(showDismissView)];
    self.mybgView.transform =CGAffineTransformScale(self.mybgView.transform, 0.9, 0.9);
    [UIView commitAnimations];
}
#pragma mark showDismissView 
-(void)showDismissView
{
    //当动画执行结束执行的方法
    self.myDismissBtn.hidden = NO;
}
-(void)hiddenView
{
    [self removeFromSuperview];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mybgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.mybgView.bounds = CGRectMake(0, 0, self.frame.size.width-40, self.frame.size.width-40);
    
    CGFloat bgViewWidth =CGRectGetWidth(self.mybgView.frame);
    CGFloat edgeWidth =(bgViewWidth/3-75)/2;
    CGRect frame = self.myQQLoginView.frame;
    frame.origin.x =edgeWidth;
    frame.origin.y = 30;
    frame.size.width =75;
    frame.size.height = 75;
    self.myQQLoginView.frame = frame;
    
    frame = self.myWCharView.frame;
    frame.origin.x =bgViewWidth/3+edgeWidth;
    frame.origin.y = 30;
    frame.size.width =75;
    frame.size.height = 75;
    self.myWCharView.frame = frame;
    

    frame = self.myWBCharView.frame;
    frame.origin.x =bgViewWidth/3 *2+edgeWidth;
    frame.origin.y = 30;
    frame.size.width =75;
    frame.size.height = 75;
    self.myWBCharView.frame = frame;
    
    frame = self.myLineView.frame ;
   
    frame.origin.x = 20;
    frame.origin.y = bgViewWidth/2+20;
    frame.size.height =2;
     frame.size.width = CGRectGetWidth(self.mybgView.frame)-40;
    self.myLineView.frame = frame;
    
    frame = self.myPhoneBtn.frame;
    frame.origin.y = CGRectGetMaxY(self.myLineView.frame)+20;
    frame.origin.x = CGRectGetMinX(self.myLineView.frame)+20;
    frame.size.width = CGRectGetWidth(self.myLineView.frame)-40;
    frame.size.height =30;
    self.myPhoneBtn.frame = frame;
    
    self.myDismissBtn.center = CGPointMake(CGRectGetMaxX(self.mybgView.frame), CGRectGetMinY(self.mybgView.frame));
    self.myDismissBtn.bounds = CGRectMake(0, 0, 30, 30);
    
     [self.myQQLoginView updateModel:@"iv_qq_normal" withText:@"QQ"];
    [self.myWBCharView updateModel:@"iv_weibo_normal" withText:@"微博"];
    [self.myWCharView updateModel:@"iv_wx_normal" withText:@"微信"];
}
@end

@interface LL_IconView ()

AS_MODEL_STRONG(UIImageView, myIconView);
AS_MODEL_STRONG(UILabel, myTextLabel);
AS_MODEL_STRONG(UIButton, myTouchBtn);
AS_MODEL_STRONG(UIButton, myNumBtn);

@end

@implementation LL_IconView

DEF_FACTORY_FRAME(LL_IconView);

DEF_MODEL(myIconView);
DEF_MODEL(myNumBtn);
DEF_MODEL(myTextLabel);
DEF_MODEL(myTouchBtn);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.myIconView.frame = CGRectMake(15, 10, frame.size.width-30, frame.size.width-30);
        self.myIconView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.myIconView];
        
        self.myNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myNumBtn.layer setMasksToBounds:YES];
        [self.myNumBtn.layer setCornerRadius:5];
        [self.myNumBtn setBackgroundColor:[UIColor redColor]];
        [self.myNumBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self.myNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.myNumBtn.frame = CGRectZero;
        self.myNumBtn.userInteractionEnabled = NO;
        [self addSubview:self.myNumBtn];
        
        self.myTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
        [self.myTextLabel setBackgroundColor:[UIColor clearColor]];
        [self.myTextLabel setFont:[UIFont systemFontOfSize:12]];
        [self.myTextLabel setTextAlignment:UITextAlignmentCenter];
        [self.myTextLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.myTextLabel];
        
        self.myTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myTouchBtn addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myTouchBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.myTouchBtn];
    }
    return self;
}

-(void)touchBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(self.tag);
    }
}

-(void)updateModel:(NSString*)icon withText:(NSString*)text
{
    UIImage* tempImage = [UIImage imageNamed:icon];
    
    self.myIconView.image = tempImage;
    
    CGRect tempFrame = self.myIconView.frame;
    tempFrame.size = tempImage.size;
    tempFrame.origin.x = (self.frame.size.width - tempFrame.size.width)/2;
    tempFrame.origin.y = (self.frame.size.height-15 - tempFrame.size.height)/2;
    self.myIconView.frame = tempFrame;
    
    tempFrame = self.myTextLabel.frame;
    tempFrame.size.width = self.frame.size.width;
    tempFrame.origin.y = self.frame.size.height-15;
    self.myTextLabel.frame = tempFrame;
    
    self.myTextLabel.text = text;
    self.myTouchBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)updateNum:(NSString*)num
{
    self.myNumBtn.hidden = !self.showNum;
    if ([num isEqualToString:@"0"]) {
        self.myNumBtn.hidden = YES;
    }
    [self.myNumBtn setTitle:num forState:UIControlStateNormal];
    
    CGRect tempFrame = self.myNumBtn.frame;
    tempFrame.origin.x = self.myIconView.frame.origin.x+self.myIconView.frame.size.width;
    tempFrame.origin.y = self.myIconView.frame.origin.y;
    tempFrame.size = CGSizeMake(10, 10);
    self.myNumBtn.frame = tempFrame;
}
@end
