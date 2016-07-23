//
//  CycleModel.h
//  网易新闻
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CycleModel : NSObject

//轮播图片标题
@property (copy , nonatomic)NSString *title;

//轮播图片
@property (copy , nonatomic)NSString *imgsrc;

//字典转模型方法
+(instancetype)initCycleModelWithDict:(NSDictionary *)dict;

//下载方法
+(void)loadCycleDataWithUrl:(NSString *)urlStr successBlock:(void(^)(NSArray *listArray))successBlock failBlock:(void(^)(NSError *error))failBlock;


@end
