//
//  CommentModel.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property(nonatomic,strong)NSString *carname;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSNumber *floor;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *nameid;
@property(nonatomic,strong)NSString *namepic;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *sourcecontent;
@property(nonatomic,strong)NSString *sourcename;
@property(nonatomic,strong)NSNumber *upcount;


+ (NSMutableArray *)ModelConfigureJsonDic:(NSDictionary *)jsonDic;


@end
