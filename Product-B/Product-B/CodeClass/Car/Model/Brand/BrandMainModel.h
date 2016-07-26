//
//  BrandMainModel.h
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandMainModel : NSObject
@property (nonatomic, strong)NSString *myid;
@property (nonatomic, strong)NSString *seriesname;
@property (nonatomic, strong)NSString *seriesid;
@property (nonatomic, strong)NSString *img;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;
@end
