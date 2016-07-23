//
//  HomeCollectionViewCell.h
//  网易新闻
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell


//接收HomeViewController传递过的数据
@property (nonatomic, copy) NSString *urlstr;

@end
