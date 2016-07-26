//
//  RTModel.h
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTModel : NSObject

@property (nonatomic, strong) NSString *bbsid;
@property (nonatomic, strong) NSString *bbsname;
@property (nonatomic, strong) NSString *bbstype;
@property (nonatomic, strong) NSString *firstletter;
@property (nonatomic, strong) NSString *sort;
+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)dic;
+ (NSMutableDictionary *)modelConfigureDic:(NSDictionary *)dic;

@end
