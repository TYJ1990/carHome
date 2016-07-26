//
//  WonContentModel.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WonContentModel : NSObject
@property (nonatomic, strong) NSString *bbsid;
@property (nonatomic, strong) NSString *bbsname;
@property (nonatomic, strong) NSString *bbstype;
@property (nonatomic, strong) NSString *lastreplydate;
//@property (nonatomic, strong) NSString *postusername;
@property (nonatomic, strong) NSString *replycounts;
@property (nonatomic, strong) NSString *smallpic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *topicid;

+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)dic;

@end
