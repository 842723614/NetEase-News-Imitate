//
//  ChannelLabel.m
//  网易新闻
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel

//设置标签文字格式
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        //文字对齐方式居中
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}


@end
