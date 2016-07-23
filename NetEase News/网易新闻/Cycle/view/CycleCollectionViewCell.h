//
//  CycleCollectionViewCell.h
//  网易新闻
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleModel.h"
@interface CycleCollectionViewCell : UICollectionViewCell

//获取从传递过来的模型
@property (strong , nonatomic) CycleModel *model;

@end
