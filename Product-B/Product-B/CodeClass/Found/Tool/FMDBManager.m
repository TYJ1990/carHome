//
//  FMDBManager.m
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FMDBManager.h"

@interface FMDBManager()
{
    NSString *_path;
}

@end


static FMDBManager *manager;

@implementation FMDBManager

+ (FMDBManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

// 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
       // 初始化数据库 -- >  FMDB
        [self initDataBaseWith:kMySqliteName];
    }
    return self;
}


- (void)initDataBaseWith:(NSString *)name{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(9, 1, 1) lastObject];
    NSString *filePath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    _path = filePath;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exist = [fm fileExistsAtPath:filePath];
    [self connect];
    if (exist) {
//        NSLog(@"%@",name);
    }else{
//        NSLog(@"数据库%@不存在",name);
    }
    
    
}
// 链接数据库
- (void)connect{
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:_path];
    }
    if (![_dataBase open]) {
//        NSLog(@"数据库打开失败");
    }else{
//        NSLog(@"数据库打开成功");
    }
}

- (void)close{
    [_dataBase close];
    manager = nil;
}

- (void)dealloc{
    [self close];
}









@end
