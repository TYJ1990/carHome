//
//  PostsModel.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostsModel : NSObject
@property (nonatomic, strong) NSString *bbsid;
@property (nonatomic, strong) NSString *bbsname;
@property (nonatomic, strong) NSString *ispictopic;
@property (nonatomic, strong) NSString *postdate;
@property (nonatomic, strong) NSString *replycounts;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *topicid;

+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)dic;

@end
