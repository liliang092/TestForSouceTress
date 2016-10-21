//
//  LLCustomNavBarView.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "LLCustomNavBarView.h"
#import "Defaultype.h"
@implementation LLCustomNavBarView
DEF_MODEL(leftBtn);
DEF_MODEL(rightBtn);
DEF_MODEL(delegate);
DEF_MODEL(titleLabel);
DEF_MODEL(backImageView);

- (id)initWithFrame:(CGRect)frame
        withBgImage:(NSString*)bgImage
          withTitle:(NSString*)title
        withLeftBtn:(NSString*)leftImage
       withRightBtn:(NSString*)rightImage
      withLeftLabel:(NSString*)leftLabel
     withRightLabel:(NSString*)rightLabel
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self updateBackImage:bgImage];
        
        [self updateTitle:title];
        
        [self updateLeftBtn:leftLabel withImage:leftImage];
        
        [self updateRightBtn:rightLabel withImage:rightImage];
    }
    return self;
}

-(void)updateBackImage:(NSString*)bgImage
{
    if (self.backImageView == nil) {
        self.backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.backImageView setBackgroundColor: [UIColor whiteColor]];
        self.backImageView.userInteractionEnabled = YES;
        
        [self addSubview:self.backImageView];
    }
    
    if (bgImage!=nil && bgImage.length > 0 && self.backImageView != nil) {
        UIImage* tempImage = [UIImage imageNamed:bgImage];
        self.backImageView.image = [tempImage stretchableImageWithLeftCapWidth:tempImage.size.width/2 topCapHeight:tempImage.size.height/2];
    }
    
    self .barLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    [self addSubview:self .barLine];
}

-(void)updateTitle:(NSString*)label
{
    if (self.titleLabel==nil) {
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-180)/2, (self.frame.size.height-40)/2, 180, 40)];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        self.titleLabel.textColor=[UIColor blackColor];
        self.titleLabel.font=[UIFont boldSystemFontOfSize:24];
        
        if (DeviceVersion >= 6.0f) {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        [self addSubview:self.titleLabel];
    }
    
    if (![label isEqualToString:@""] && self.titleLabel != nil) {
        self.titleLabel.text = label;
    }
}

-(void)updateLeftBtn:(NSString*)leftLabel withImage:(NSString*)leftImage
{
    if (self.leftBtn!=nil) {
        [self.leftBtn removeFromSuperview];
    }
    
    UIButton *templeftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [templeftBtn setBackgroundColor:[UIColor clearColor]];
    
    [templeftBtn setFrame:CGRectMake(0, (self.frame.size.height-44)/2, 100, 44)];
    [templeftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    if (leftImage!=nil && leftImage.length > 0) {
        NSInteger length=[leftImage length];
        NSMutableString *leftImage_h=[NSMutableString stringWithString:leftImage];
        if (length>=4) {
            [leftImage_h insertString:@"_h" atIndex:(length-4)];
        }
        
        [templeftBtn setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
        UIImage* L_H =[UIImage imageNamed:leftImage_h];
        if (L_H!=nil ) {
            [templeftBtn setImage:L_H forState:UIControlStateHighlighted];
        }
        [templeftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 5)];
    }
    if (leftLabel!=nil && leftLabel.length > 0) {
        [templeftBtn setTitle:leftLabel forState:UIControlStateNormal];
        [templeftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [templeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        templeftBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        if (leftImage!=nil && leftImage.length > 0) {
            [templeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        }else{
            [templeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
        }
    }
    
    [templeftBtn addTarget:self action:@selector(leftBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = templeftBtn;
    templeftBtn.tag = 1001;
    [self addSubview:templeftBtn];
}

-(void)updateRightBtn:(NSString*)rightLabel withImage:(NSString*)rightImage
{
    if (self.rightBtn!=nil) {
        [self.rightBtn removeFromSuperview];
    }
    UIButton *temprightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [temprightBtn setFrame:CGRectMake(self.frame.size.width-80, (self.frame.size.height-44)/2, 70, 44)];
    [temprightBtn setBackgroundColor:[UIColor clearColor]];
    
    [temprightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (rightImage!=nil && rightImage.length > 0) {
        NSInteger length=[rightImage length];
        NSMutableString *rightImage_h=[NSMutableString stringWithString:rightImage];
        if (length>=4) {
            [rightImage_h insertString:@"_h" atIndex:(length-4)];
        }
        [temprightBtn setImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
        UIImage* R_H = [UIImage imageNamed:rightImage_h];
        if (R_H!=nil) {
            [temprightBtn setImage:R_H forState:UIControlStateHighlighted];
        }
    }
    
    if (rightLabel!=nil && rightLabel.length > 0) {
        
        [temprightBtn.layer setBackgroundColor:[UIColor whiteColor].CGColor];
        [temprightBtn.layer setMasksToBounds:YES];
        [temprightBtn.layer setCornerRadius:5];
        [temprightBtn.layer setBorderWidth:1];
        [temprightBtn.layer setBorderColor:[UIColor redColor].CGColor];
        
        [temprightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        CGRect tempFrame = temprightBtn.frame;
        tempFrame.origin.y = (self.frame.size.height - 35)/2;
        tempFrame.size.height = 30;
        temprightBtn.frame = tempFrame;
        
        [temprightBtn setTitle:rightLabel forState:UIControlStateNormal];
        [temprightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [temprightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        temprightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    [temprightBtn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = temprightBtn;
    temprightBtn.tag = 1002;
    [self addSubview:temprightBtn];
}

-(void)leftBtnPressed:(id)sender
{
    NSLog(@"%@，%d",self.delegate,[self.delegate respondsToSelector:@selector(leftBtnPressed:)]);
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(leftBtnPressed:)]) {
        [self.delegate leftBtnPressed:sender];
    }
}
-(void)rightBtnPressed:(id)sender
{
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(rightBtnPressed:)]) {
        [self.delegate rightBtnPressed:sender];
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
