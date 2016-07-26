//
//  BrandChooseModel.h
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandChooseModel : NSObject
@property (nonatomic, strong)NSString *key;
@property (nonatomic, strong)NSString *description1;
@property (nonatomic, strong)NSArray *list;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;
@end
