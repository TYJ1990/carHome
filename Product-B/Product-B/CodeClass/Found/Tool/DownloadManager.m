//
//  DownloadManager.m
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DownloadManager.h"

@interface DownloadManager()<DownloadDelegate>
@property(nonatomic,strong)NSMutableDictionary *dic;// 存放下载任务

@end

@implementation DownloadManager

+ (DownloadManager *)defaultManager{
    static DownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DownloadManager alloc] init];
    });
    return manager;
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}


- (Download *)createDownload:(NSString *)url{
    Download *task = self.dic[url];
    if (!task) {
        task = [[Download alloc] initWith:url];
        [self.dic setValue:task forKey:url];
    }
    task.delegate = self;
    return task;
}


- (void)removeDownloadTask:(NSString *)url{
    [_dic removeObjectForKey:url];
}



@end
