//
//  SUCustomTabbar.h
//  MyTestForNewFrameWork
//
//  Created by Liliang on 16/9/20.
//  Copyright © 2016年 leiyukeyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLCustonTabbarModel.h"

@protocol SUCustomTabbarDelegate <NSObject>
-(void)clickAtIndex:(NSInteger)index;
@end

@interface SUCustomTabbar : UIView
@property(nonatomic,strong)NSMutableArray *myItemsModel;
@property(nonatomic,strong)id<SUCustomTabbarDelegate> myDeleaget;
@property(nonatomic,assign)NSInteger selectIndex;
-(void)upMyDatas:(NSMutableArray *)myItemsModel;
@end
