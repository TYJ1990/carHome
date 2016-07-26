//
//  BrandCarSecondModel.h
//  Product-B
//
//  Created by super on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandCarSecondModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray *serieslist;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;
@end
