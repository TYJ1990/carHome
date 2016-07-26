//
//  WonderfulModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WonderfulModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL isSelect;

+ (NSMutableArray *)modelconfigureJsonDic:(NSDictionary *)dic;

@end
