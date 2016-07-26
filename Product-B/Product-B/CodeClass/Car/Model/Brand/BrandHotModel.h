//
//  BrandHotModel.h
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandHotModel : NSObject
@property (nonatomic, strong)NSString *firstletter;
@property (nonatomic, strong)NSString *myid;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *ordercount;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;
@end
