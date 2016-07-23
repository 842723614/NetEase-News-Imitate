//
//  ChannelModel.m
//  网易新闻
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

+(instancetype)channelModelWithDict:(NSDictionary *)dict{
    
    ChannelModel *model = [[ChannelModel alloc]init];
    //kvc字典转模型
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@",_tid,_tname];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //解决没有key的问题
    
}

+(NSArray *)channel{
    //获取json文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    
    //把json转换成二进制
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    //反序列化（解析前需要吧json转换成二进制）
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    //取出tList想对应数组
    NSArray *array = [dict objectForKey:@"tList"];
    
    //创建可变数组
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count]
    ;
    
    //遍历数组
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ChannelModel *model = [self channelModelWithDict:obj];
        
        //把模型存到可变数组
        [arrayM addObject:model];
        
    }];
    
    //排序
    [arrayM sortUsingComparator:^NSComparisonResult(ChannelModel *obj1, ChannelModel *obj2) {
        //比较
        return [obj1.tid compare:obj2.tid];
    }];
    
    return arrayM.copy;
}


@end
