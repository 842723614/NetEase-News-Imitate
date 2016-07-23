//
//  NewsTableViewCell.m
//  网易新闻
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface NewsTableViewCell()

//图片
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;

//标题
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

//新闻来源
@property (weak, nonatomic) IBOutlet UILabel *sourcelLabel;

//评论数
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

//多图
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imagesView;



@end

@implementation NewsTableViewCell

-(void)setModel:(NewsModel *)model{
    //赋值
    _model = model;
    
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];

    self.TitleLabel.text = model.title;
    
    self.sourcelLabel.text = model.source;
    
    self.replyLabel.text = [NSString stringWithFormat:@"%@",model.replyCount];
    
    for (int i = 0; i < model.imgextra.count; i++) {
        //取出控件
        UIImageView *image = self.imagesView[i];
        
        NSDictionary *dict = model.imgextra[i];
        
        NSString *img = [dict objectForKey:@"imgsrc"];
        
        //给控件赋值
        [image sd_setImageWithURL:[NSURL URLWithString:img]];
    }
    
}



@end
