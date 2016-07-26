//
//  CarsModel.h
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CarsModel : NSObject
@property (nonatomic, strong) NSString *brandimg;
@property (nonatomic, strong) NSString *brandname;
@property (nonatomic, strong) NSString *letter;
@property (nonatomic, strong) NSArray *seriesclub;
+ (NSMutableDictionary *)modelConfigureJsonDic:(NSDictionary *)dic;
@end
