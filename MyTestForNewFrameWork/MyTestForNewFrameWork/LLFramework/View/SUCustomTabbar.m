//
//  SUCustomTabbar.m
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import "SUCustomTabbar.h"
#import "NSString+DLExtension.h"

@implementation SUCustomTabbar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.selectIndex = 0;
    }
    return self;
}
-(void)upMyDatas:(NSMutableArray *)myItemsModels
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UIButton")]) {
            [obj removeFromSuperview];
        }
    }];
    if (myItemsModels!= nil) {
        [myItemsModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"LLCustonTabbarModel")]) {
                LLCustonTabbarModel *itemModel = (LLCustonTabbarModel *)obj;
                CGFloat widthView =self.frame.size.width/myItemsModels.count;
                UIButton *button = [self getStatusBtn:CGRectMake(idx*widthView, 0, widthView, self.frame.size.height) withView:self withTitle:itemModel.title withIcon:itemModel.nomalImage];
                [button setImage:[UIImage imageNamed:itemModel.selectedImage] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(myClickAction:) forControlEvents:UIControlEventTouchDown];
                button.tag = 1000+idx;
                [button setTitleColor:itemModel.nomalColor forState:UIControlStateNormal];
                [button setTitleColor:itemModel.selectColor forState:UIControlStateSelected];
                if (idx ==self.selectIndex) {
                    button.selected = YES;
                }
            }
        }];
    }
    
}

-(void)myClickAction:(UIButton *)button
{
    if (self.selectIndex == button.tag -1000) {
        button.selected = YES;
    }
    else
    {
        UIButton *seletBtn = [self viewWithTag:self.selectIndex+1000];
        seletBtn.selected = NO;
        button.selected = !button.selected;
        self.selectIndex = button.tag - 1000;
        if (self.myDeleaget != nil && [self.myDeleaget respondsToSelector:@selector(clickAtIndex:)]) {
            [self.myDeleaget clickAtIndex:button.tag-1000];
        }
    }
    
}
-(UIButton*)getStatusBtn:(CGRect)frame withView:(UIView*)view withTitle:(NSString*)text withIcon:(NSString*)icon
{
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage* tempIcon = [UIImage imageNamed:icon];
    
    [tempBtn setImage:tempIcon forState:UIControlStateNormal];
    
    [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    tempBtn.frame = frame;
    
    [tempBtn setImageEdgeInsets:UIEdgeInsetsMake(3, (frame.size.width-tempIcon.size.width)/2, 20, 0)];
    
    [tempBtn setTitle:text forState:UIControlStateNormal];
    
    CGSize tempTextW = [text sizeWithFont:[UIFont systemFontOfSize:12] byWidth:frame.size.width];
    
    [tempBtn setTitleEdgeInsets:UIEdgeInsetsMake(frame.size.height-20, (0-tempIcon.size.width)+(frame.size.width-tempTextW.width)/2, 0, 0)];
    
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [view addSubview:tempBtn];
    
    return tempBtn;
}

@end
