//
//  HomeViewController.m
//  网易新闻
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"
#import "ChannelLabel.h"
#import "HomeCollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


//flowLayout
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

//频道滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;

//新闻滚动视图
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;

//频道标签模型
@property (strong , nonatomic)NSArray *dataArr;

@property (strong , nonatomic)ChannelLabel *label;

//保存标签数组
@property (strong , nonatomic)NSMutableArray *labelM;

@end

@implementation HomeViewController
//懒加载
-(NSMutableArray *)labelM
{
    if (_labelM == nil) {
        _labelM = [NSMutableArray array];
    }
    return _labelM;
}

-(NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [ChannelModel channel];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ScrollView和nav同时使用的话，ScrollView会往下移动64像素，也可以在storyboard中设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createChannelLabel];
}

//让新闻视图宽度等于屏幕宽度
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.flowLayout.itemSize = self.newsCollectionView.bounds.size;
    
}

//显示频道标签
-(void)createChannelLabel{
    //赋值
    self.dataArr = [ChannelModel channel];
    
    //标签宽度
    CGFloat labelW = 80;
    //高度
    CGFloat labelH = self.channelScrollView.bounds.size.height;
    
    //循环赋值
    for (int i = 0; i < self.dataArr.count; i++) {
        //创建lable
        ChannelLabel *Label = [[ChannelLabel alloc]init];
        
        //位置
        CGFloat labelX = labelW *i;
        //设置每个标签的位置
        Label.frame = CGRectMake(labelX ,0, labelW, labelH);
        
        //赋值
        ChannelModel *model = self.dataArr[i];
        Label.text = model.tname;
        
        //滚动范围
        self.channelScrollView.contentSize = CGSizeMake(labelW * _dataArr.count, 0);
        
        //给label设置tag
        Label.tag = i;
        
        //把子标签添加到标签视图
        [self.channelScrollView addSubview:Label];
        
        //给标签label添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        
        //把手势添加到label上
        [Label addGestureRecognizer:tap];
        
        if (i == 0) {
            Label.textColor = [UIColor redColor];
            Label.font = [UIFont systemFontOfSize:20];
            self.label = Label;
        }
    

        
        //设置用户交互
        Label.userInteractionEnabled = YES;
        
        [self.labelM addObject:Label];
    }
}

//点击频道方法
-(void)tapClick:(UIGestureRecognizer *)tap{
    if (self.label) {
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont systemFontOfSize:14];
    
    }
    
    //获取选中的label
    ChannelLabel *label = (ChannelLabel *)tap.view;
    
    //设置channelLabel的颜色
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:20];
    self.label = label;
    
    //设置滚动居中需要的偏移量
    CGFloat labelOffsetX = label.center.x - self.view.bounds.size.width / 2;
    
    //设置最小偏移量
    CGFloat minOffsetX = 0;
    //最大偏移量
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (labelOffsetX < minOffsetX) {
        labelOffsetX = minOffsetX;
    }else if (labelOffsetX > maxOffsetX)
        labelOffsetX = maxOffsetX;
    
    //设置频道滚动中心位置
    [self.channelScrollView setContentOffset:CGPointMake(labelOffsetX, 0) animated:NO];
    
#pragma mark - 点击频道标签是，collection跟着滚动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:label.tag inSection:0];
    //把新闻视图滚动到响应的标签
    [self.newsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
}

#pragma mark - 监听底部conllectionView的滚动，滚动结束的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.label) {
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont systemFontOfSize:14];
        
    }
    
    //计算滚动到第几个索引
    NSInteger index = scrollView.contentOffset.x  / scrollView.bounds.size.width;
    
    //根据标签去找标签着label
    ChannelLabel *lab = self.labelM[index];
    
    
    //设置channelLabel的颜色
    lab.textColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:20];
    self.label = lab;
    
    
    //label的偏移量
    CGFloat labelOffsetX = lab.center.x - self.view.bounds.size.width / 2;
    //限制约束
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (labelOffsetX < minOffsetX) {
        labelOffsetX = minOffsetX;
    }else if (labelOffsetX > maxOffsetX)
        labelOffsetX = maxOffsetX;
    
    //滚动
    [self.channelScrollView setContentOffset:CGPointMake(labelOffsetX, 0) animated:YES];
    
}

#pragma  mark - collectionView的数据源方法
//返回行数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

//cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ChannelModel *model = self.dataArr[indexPath.item];
    
    NSLog(@"model.tid %@",model.tid);
    
    NSString *urlstr = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    
    cell.urlstr = urlstr;
    
    return cell;
}


@end
