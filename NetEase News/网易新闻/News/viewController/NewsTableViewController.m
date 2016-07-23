//
//  NwesTableViewController.m
//  网易新闻
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NewsTableViewController ()

@property (strong , nonatomic)NSArray *dataArray;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUrlStr:(NSString *)urlStr

{
    
    _urlStr = urlStr;
    
    [NewsModel downloadWithUrlStr:urlStr successBlock:^(NSArray *array) {
        //赋值
        self.dataArray = array;
        
        //刷新数据
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

#pragma mark - 数据源代理方法

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建模型
    NewsModel *model = self.dataArray[indexPath.row];
    
    //判断是那种cell
    NSString *Identifier;
    
    if (model.imgType) {
        Identifier = @"bigCell";
    }else if (model.imgextra.count == 2){
        Identifier = @"imageCell";
    }else{
        Identifier = @"BaseCell";
    }
    //创建cell
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    //赋值
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = self.dataArray[indexPath.row];
    
    if (model.imgType) {
        return 180;
    }else if (model.imgextra.count == 2){
        return 150;
    }else{
        return 80;
    }
    
    
    
    
}


@end
