//
//  FMDBManager.h
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kMySqliteName @"CarHome.sqlite"

@interface FMDBManager : NSObject

@property(nonatomic,strong)FMDatabase *dataBase;

+(FMDBManager *)shareManager;
// 关闭数据库
- (void)close;



@end
