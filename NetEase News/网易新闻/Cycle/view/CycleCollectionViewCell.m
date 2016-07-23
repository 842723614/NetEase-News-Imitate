//
//  CycleCollectionViewCell.m
//  网易新闻
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>


@interface CycleCollectionViewCell()

//轮播图片
@property (weak, nonatomic) IBOutlet UIImageView *CycleImage;

//轮播标题
@property (weak, nonatomic) IBOutlet UILabel *CycleLab;


@end

@implementation CycleCollectionViewCell

//赋值
-(void)setModel:(CycleModel *)model{
    
    _model = model;
    
    //轮播图片
    [self.CycleImage sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    //轮播文字
    self.CycleLab.text = model.title;
    
}






@end
