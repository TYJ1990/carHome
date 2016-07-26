//
//  NewsflashModel.h
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsflashModel : NSObject

@property(nonatomic,strong)NSString *authorname;
@property(nonatomic,strong)NSString *blogurl;
@property(nonatomic,strong)NSString *publishtime;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *headimg;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSNumber *replycount;
@property(nonatomic,strong)NSNumber *upcount;
@property(nonatomic,strong)NSArray *attachments;
@property(nonatomic,strong)NSString *headimg1;
@property(nonatomic,strong)NSString *headimg2;
@property(nonatomic,strong)NSString *headimg3;
@property(nonatomic,strong)NSString *content1;
@property(nonatomic,strong)NSString *content2;
@property(nonatomic,strong)NSString *content3;
@property(nonatomic,strong)NSString *username1;
@property(nonatomic,strong)NSString *username2;
@property(nonatomic,strong)NSString *username3;



+ (NSMutableArray *)ModelConfigureJsonDic:(NSDictionary *)jsonDic;







@end
