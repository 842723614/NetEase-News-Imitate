//
//  CycleModel.m
//  网易新闻
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CycleModel.h"
#import "NetworlTool.h"

@implementation CycleModel

+(instancetype)initCycleModelWithDict:(NSDictionary *)dict{

    CycleModel *model = [[CycleModel alloc]init];
    
    //kvc
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

//解决没有key的问题
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}


//下载方法
+(void)loadCycleDataWithUrl:(NSString *)urlStr successBlock:(void (^)(NSArray *))successBlock failBlock:(void (^)(NSError *))failBlock{
    //获取数据
    [[NetworlTool sharedNetworlTool]GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary *responseObject) {
        
        //取出key
        NSString *key = responseObject.keyEnumerator.nextObject;
    
        //创建数组存放数据
        NSArray *array = [responseObject objectForKey:key];
    
        //创建可变数组
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        //循环
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CycleModel *model = [CycleModel initCycleModelWithDict:obj];
            
            [arrayM addObject:model];
        }];
        //如果实现
        if (successBlock) {
            //返回
            successBlock(arrayM.copy);
        }
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
    
}

@end
