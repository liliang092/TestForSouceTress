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
        
        self.myIconArray = [[NSMutableArray alloc]init];
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

-(void)initShareView{
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth-50, ScreenWidth, 50)];
    [self.shareWindow addSubview:self.shareView];
    [self.shareView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.shareView];
    
    self.cancalBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.shareView.frame)-2, CGRectGetWidth(self.shareView.frame), 30)];
    self.cancalBtn.layer.borderWidth =1;
//    self.cancalBtn.layer.borderColor =[Tools colorWithHexString:@"CDCDCD" andAlpha:1].CGColor;
    [self.cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancalBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cancalBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.cancalBtn.tag =1000;
    [self.cancalBtn addTarget:self action:@selector(clickCancle:) forControlEvents:UIControlEventTouchDown];
    [self.shareView addSubview:self.cancalBtn];
}
-(void)addIconItem:(NSString*)name withIcon:(NSString*)icon
{
    NSMutableDictionary* tempDic = [[NSMutableDictionary alloc] init];
    
    [tempDic setObject:name forKey:@"name"];
    [tempDic setObject:icon forKey:@"icon"];
    
    [self.myIconArray addObject:tempDic];
    [self updateData];
}
-(void)updateData
{
    [self.shareView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:NSClassFromString(@"UIButton")]) {
            
            [obj removeFromSuperview];

        }
    }];
    NSInteger count = [self.myIconArray count];
    CGFloat w = self.shareView.frame.size.width/3;
    CGFloat h = 75;
    CGFloat x =0;
    CGFloat y=10;
    CGRect frame = self.shareView.frame;
    if (count !=0) {
        if (count%3 != 0) {
            frame.size.height = 50+75*(count/3+1);
        }
        else
        {
            frame.size.height = 50+75*(count/3);
        }
        frame.origin.y = ScreenWidth-frame.size.height;
        
    }
    self.shareView.frame = frame;
    
    for (int i=0; i<count; i++) {
        NSDictionary* tempDic = [self.myIconArray objectAtIndex:i];
        NSString* tempName = [tempDic valueForKey:@"name"];
        NSString* tempIocn = [tempDic valueForKey:@"icon"];
        
        M_IconView* tempBtn = [[M_IconView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        tempBtn.tag = 1000+i;
        tempBtn.showNum = NO;
        
        [tempBtn updateModel:tempIocn withText:tempName];
        __weak LLShareView *weakSelf= self;
        tempBtn.block = ^(NSInteger tag){
            if (weakSelf.block!=nil) {
                weakSelf.block(tag-1000);
            }
        };
        
//        [self addObject:tempBtn];
        [self.shareView addSubview:tempBtn];
        
        if ((i+1)%3==0) {
            x=0;
        }
        else
        {
            x+=w;
        }
        y= 10+((i+1)/3)*75;
    }
    frame= self.cancalBtn.frame;
    frame.origin.y = self.shareView.frame.size.height-30;
    self.cancalBtn.frame = frame;
}
-(void)hiddenAndDismiss
{
    CGRect tempFrame = self.shareView.frame;
    [UIView beginAnimations:@"hiddenView" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeView)];
    tempFrame.origin.y =[UIScreen mainScreen].bounds.size.height;
    self.shareView.frame = tempFrame;
    [UIView commitAnimations];

}
-(void)removeView
{
    [self removeFromSuperview];
}
-(void)showInView
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    CGRect tempFrame = self.shareView.frame;
    tempFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
    self.shareView.frame = tempFrame;
    [UIView beginAnimations:@"showView" context:nil];
    tempFrame.origin.y =[UIScreen mainScreen].bounds.size.height-self.shareView.frame.size.height;
    self.shareView.frame = tempFrame;
    [UIView commitAnimations];
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
}

@end
@interface M_IconView ()

@property(nonatomic,strong)UIImageView * myIconView;
@property(nonatomic,strong)UILabel * myTextLabel;
@property(nonatomic,strong)UIButton * myTouchBtn;
@property(nonatomic,strong)UIButton  *myNumBtn;

@end

@implementation M_IconView
DEF_FACTORY_FRAME(M_IconView);

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
        [self.myTextLabel setTextAlignment:NSTextAlignmentCenter];
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
    __weak M_IconView *weakSelf = self;
    if (weakSelf.block!=nil) {
        weakSelf.block(self.tag);
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
    tempFrame.origin.y = CGRectGetMaxY(self.myIconView.frame);
    tempFrame.size.height = self.frame.size.height-CGRectGetHeight(self.myIconView.frame);
    self.myTextLabel.frame = tempFrame;
    self.myTextLabel.text = text;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


