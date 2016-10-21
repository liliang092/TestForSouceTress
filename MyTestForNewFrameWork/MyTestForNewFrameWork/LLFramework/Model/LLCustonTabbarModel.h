//
//  LLCustonTabbarModel.h
//  TeacherWhereGo
//
//  Created by Liliang on 16/9/19.
//  Copyright © 2016年 liliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LLCustonTabbarModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSString *selectedImage;
@property(nonatomic,strong)NSString *nomalImage;
@property(nonatomic,strong)UIColor *nomalColor;
@property(nonatomic,strong)UIColor *selectColor;
@end
