//
//  HomeCollectionViewCell.m
//  网易新闻
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"

@interface HomeCollectionViewCell ()


@property(strong , nonatomic)NewsTableViewController *newsVc;

@end

@implementation HomeCollectionViewCell

-(void)awakeFromNib{
    
    //加载storyboard
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    //设置为初始化控制器
    self.newsVc = [Storyboard instantiateInitialViewController];
    
    //设置位置
    self.newsVc.tableView.frame = self.contentView.bounds;
    
    //设置tableview的背景颜色
    self.newsVc.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) /255.0 green:arc4random_uniform(256) /255.0 blue:arc4random_uniform(256) /255.0 alpha:1];
    
    //添加到父框架
    [self.contentView addSubview:self.newsVc.tableView];
    
}
 
-(void)setUrlstr:(NSString *)urlstr
{
    _urlstr = urlstr;
    self.newsVc.urlStr = urlstr;
}


@end
