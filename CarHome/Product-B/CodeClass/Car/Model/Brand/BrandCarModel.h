//
//  BrandCarModel.h
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandCarModel : NSObject
@property (nonatomic, strong)NSString *letter;
@property (nonatomic, strong)NSMutableArray *list;
@property (nonatomic, strong)NSMutableArray *sectionArray;
+(NSMutableArray *)modelJson:(NSDictionary *)jsonDic;
@end
