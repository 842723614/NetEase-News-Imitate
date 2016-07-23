//
//  NwesTableViewController.h
//  网易新闻
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

//接受HomeCollectionviewCell传递过来的数据
@property (copy , nonatomic)NSString *urlStr;

- (void)setUrlStr:(NSString *)urlStr;
@end
