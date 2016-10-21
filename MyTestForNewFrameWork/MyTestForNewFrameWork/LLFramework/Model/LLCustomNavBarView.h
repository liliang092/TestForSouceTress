//
//  LLCustomNavBarView.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLObejctDefine.h"
@protocol LLCustomNavBarDelegate <NSObject>
@optional
-(void)leftBtnPressed:(id)sender;
-(void)rightBtnPressed:(id)sender;

@end
@interface LLCustomNavBarView : UIView
AS_DELEGATE(id<LLCustomNavBarDelegate>, delegate);

AS_MODEL_STRONG(UIButton, leftBtn);
AS_MODEL_STRONG(UIButton, rightBtn);
AS_MODEL_STRONG(UILabel, titleLabel);
AS_MODEL_STRONG(UIImageView, backImageView);
AS_MODEL_STRONG(UIView, barLine);
- (id)initWithFrame:(CGRect)frame
        withBgImage:(NSString*)bgImage
          withTitle:(NSString*)title
        withLeftBtn:(NSString*)leftImage
       withRightBtn:(NSString*)rightImage
      withLeftLabel:(NSString*)leftLabel
     withRightLabel:(NSString*)rightLabel;

-(void)updateBackImage:(NSString*)bgImage;

-(void)updateTitle:(NSString*)label;

-(void)updateLeftBtn:(NSString*)leftLabel withImage:(NSString*)leftImage;

-(void)updateRightBtn:(NSString*)rightLabel withImage:(NSString*)rightImage;

@end
