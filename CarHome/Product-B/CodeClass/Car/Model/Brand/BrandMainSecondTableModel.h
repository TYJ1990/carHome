//
//  BrandMainSecondTableModel.h
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandMainSecondTableModel : NSObject
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray *speclist;
+ (NSMutableArray *)arrayjson:(NSDictionary *)jsonDic;

@end
