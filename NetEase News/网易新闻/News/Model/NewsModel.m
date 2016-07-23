
//
//  NewsModel.m
//  网易新闻
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NewsModel.h"
#import "NetworlTool.h"

@implementation NewsModel
//什么都不做
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//字典转模型
+(instancetype)newsModelWithDic:(NSDictionary *)dict{
    
    NewsModel *model = [[NewsModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
}

//网路
+(void)downloadWithUrlStr:(NSString *)urlStr successBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock{
    
    [[NetworlTool sharedNetworlTool]GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSLog(@"%@",responseObject);
        
        NSDictionary *dic = responseObject;
        NSString *key = dic.keyEnumerator.nextObject;
        
        //接受数据
        NSArray *array = [dic objectForKey:key];
        
        //可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:array.count];
        
        //遍历arr
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModel *model = [self newsModelWithDic:obj];
            [arrM addObject:model];
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}



@end
