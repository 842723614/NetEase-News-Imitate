//
//  NewsTableViewCell.h
//  网易新闻
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableViewCell : UITableViewCell

//传递模型
@property (strong , nonatomic)NewsModel *model;

@end
