//
//  Download.m
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "Download.h"

@interface Download ()<NSURLSessionDownloadDelegate>
@property(nonatomic,strong)NSURLSessionDownloadTask *task;
@property(nonatomic,copy)Downloading downloading;
@property(nonatomic,copy)DidDowaload didDownload;

@end

@implementation Download

- (instancetype)initWith:(NSString *)url{
    self = [super init];
    if (self) {
        // 设置下载配置
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 根据配置创建网络会话
        NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        _task = [session downloadTaskWithURL:[NSURL URLWithString:url]];
        _url = url;
    }
    return self;
}


- (void)dealloc{
    _delegate = nil;
//    NSLog(@"代理消失 ---- %s",__FUNCTION__);
}

- (void)start{
    [_task resume];
}

- (void)stop{
    [_task suspend];
}


#pragma mark  ----下载代理
//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSString *cashPath = [NSSearchPathForDirectoriesInDomains(13, 1, 1) lastObject];
    // 拼接下载文件路径
    NSString *filePath = [cashPath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
//    NSLog(@"fifePath ====== %@",filePath);
    NSFileManager *manager = [NSFileManager defaultManager];
//    NSLog(@"locationPath ======= %@",location.path);
    [manager moveItemAtPath:location.path toPath:filePath error:nil];
    if (_didDownload) {
        _didDownload(filePath,_url);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(removeDownloadTask:)]){
        [_delegate removeDownloadTask:_url];
    }
    [session invalidateAndCancel];// 关闭会话
}


// 下载中
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float progress = (float)totalBytesWritten/totalBytesExpectedToWrite;
    _progress = progress *100;
    if (_downloading) {
        _downloading(bytesWritten ,_progress);
    }
}

// 监听下载
- (void)monitorDownload:(Downloading)downloading DidDownload:(DidDowaload)didDownload{
    _downloading = downloading;
    _didDownload = didDownload;
    
}




@end
