//
//  MusicDownloadTable.h
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"

#define kDownloadTable @"CarHome"

@interface MusicDownloadTable : NSObject

@property(nonatomic,strong)FMDatabase *dataBase;
// 建表
- (void)createTable;

// 插入
- (void)insertIntoTable:(NSArray *)Info;

// 取出
- (NSArray *)selectAll;

// 删除
- (void)deleteDataWithTableNameforMyID:(NSString *)musicUrl;



@end
