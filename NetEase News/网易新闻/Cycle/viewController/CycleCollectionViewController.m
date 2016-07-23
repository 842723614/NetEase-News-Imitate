//
//  CycleCollectionViewController.m
//  网易新闻
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CycleCollectionViewController.h"
#import "CycleModel.h"
#import "CycleCollectionViewCell.h"

@interface CycleCollectionViewController ()
//数据接受
@property (strong , nonatomic) NSArray *array;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;

//pagecontrol
@property (strong , nonatomic)UIPageControl *pageControl;

@end

@implementation CycleCollectionViewController

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    //设置cell的大小
    self.FlowLayout.itemSize = self.collectionView.bounds.size;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadCycleWithDict];
    
    [self createPageControl];
}

-(void)createPageControl{

    //创建pagecontrol
    self.pageControl = [[UIPageControl alloc]init];
    
    //选中的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    //为选中的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    
    //吧pageControl添加到视图
    [self.view addSubview:self.pageControl];
}

//下载数据
-(void)loadCycleWithDict{

    NSString *url = [NSString stringWithFormat:@"ad/headline/0-4.html" ];
    [CycleModel loadCycleDataWithUrl:url successBlock:^(NSArray *listArray) {
        
        self.array = listArray;
        
        //刷新ui
        [self.collectionView reloadData];
        
        //设置pagecontrol的个数
        self.pageControl.numberOfPages = self.array.count;
        
        //设置大小
        CGSize pageControlSize =[self.pageControl sizeForNumberOfPages:self.array.count];
        
        //设置X
        CGFloat pageControlX = self.view.bounds.size.width - pageControlSize.width -10;
        //设置Y
        CGFloat pageControlY = self.view.bounds.size.height - pageControlSize.height;
        //设置位置
        self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        
        
        //刷新完collectionView之后,默默的把item滚动到第4个 (cycleList.count)
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.array.count inSection:0];
        //滚动到
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
    } failBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

//滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //计算当前在第几个item
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;

    //设置pageControl跟着滚动
    self.pageControl.currentPage = index % self.array.count;
    
    //索引
    NSIndexPath *indexPath;
    
    //重新获取item的个数
    NSInteger items = [self.collectionView numberOfItemsInSection:0];

    if (index == 0) {
        indexPath = [NSIndexPath indexPathForItem:self.array.count inSection:0];
        
    }else if (index == items - 1){
        indexPath = [NSIndexPath indexPathForItem:self.array.count - 1 inSection:0];
    }
    //滚动collectionview
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}



#pragma mark - 数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //乘2，为了循环滚动
    return self.array.count * 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    //获取模型
    CycleModel *model = self.array[indexPath.item%self.array.count];
    //赋值
    cell.model =model;

    return cell;
}

@end
