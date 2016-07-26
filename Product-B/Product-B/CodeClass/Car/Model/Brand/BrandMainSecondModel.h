//
//  BrandMainSecondModel.h
//  Product-B
//
//  Created by super on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandMainSecondModel : NSObject
@property (nonatomic, strong)NSArray *tabinfos;
@property (nonatomic, strong)NSString *tabtitle;
@property (nonatomic, strong)NSString *tabsubtitle;
@property (nonatomic, strong)NSString *tabtype;
@property (nonatomic, strong)NSString *tabicon;

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *fctprice;
@property (nonatomic, strong)NSString *logo;
@property (nonatomic, strong)NSDictionary *teambuyinginfo;
@property (nonatomic, strong)NSDictionary *manyvictors;
@property (nonatomic, strong)NSArray *spectype;
@property (nonatomic, strong)NSString *fctpricename;
@property (nonatomic, strong)NSArray *enginelist;

+ (BrandMainSecondModel *)modelJson:(NSDictionary *)jsonDic;
@end
