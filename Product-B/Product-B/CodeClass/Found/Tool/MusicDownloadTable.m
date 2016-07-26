//
//  MusicDownloadTable.m
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MusicDownloadTable.h"

@implementation MusicDownloadTable


- (instancetype)init{
    self = [super init];
    if (self) {
        _dataBase = [FMDBManager shareManager].dataBase;
        
    }
    return self;
}

- (void)createTable{
    // 判断是否有表存在
    NSString *query = [NSString stringWithFormat:@"select count(*) from sqlite_master where type = 'table' and name = ‘%@'",kDownloadTable];
    FMResultSet *set = [_dataBase executeQuery:query];
    [set next];
    int count = [set intForColumnIndex:0];
    BOOL exist = count;
    if (exist) {
//        NSLog(@"%@表存在",kDownloadTable);
    }else{
        // 建表
        NSString *updata = [NSString stringWithFormat:@"create table %@(musicID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,title text, musicUrl text, musicImg text, musicPath text, lyric text)",kDownloadTable];
        BOOL result = [_dataBase executeUpdate:updata];
        if (result) {
//            NSLog(@"%@创建成功",kDownloadTable);
        } else{
//            NSLog(@"%@创建不成功",kDownloadTable);
        }
    }
}

- (void)insertIntoTable:(NSArray *)Info{
    NSString *update = [NSString stringWithFormat:@"INSERT INTO %@ (title, musicUrl, musicImg, musicPath, lyric) values(?,?,?,?,?)",kDownloadTable];
    BOOL result = [_dataBase executeUpdate:update withArgumentsInArray:Info];
    if (result) {
//        NSLog(@"插入成功");
    }else{
//        NSLog(@"插、入失败");
    }
}

// 查询所有数据
- (NSArray *)selectAll{
    NSString *query = [NSString stringWithFormat:@"select *from %@",kDownloadTable];
    FMResultSet *set = [_dataBase executeQuery:query];
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:[set columnCount]];
    while ([set next]) {
        NSString *title = [set stringForColumn:@"title"];
        NSString *musicUrl = [set stringForColumn:@"musicUrl"];
        NSString *musicImg = [set stringForColumn:@"musicImg"];
        NSString *musicPath = [set stringForColumn:@"musicPath"];
        NSString *lyric = [set stringForColumn:@"lyric"];
        [mArray addObject:@[title,musicUrl,musicImg,musicPath,lyric]];
    }
    return mArray;
}

// 删除
- (void)deleteDataWithTableNameforMyID:(NSString *)title{
    NSString *string = [NSString stringWithFormat:@"delete from %@ where title = ?",kDownloadTable];
    BOOL flag = [_dataBase executeUpdate:string,title];
    NSLog(@"flag ==== %d",flag);
}



@end
