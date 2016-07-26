//
//  Download.h
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Downloading)(long long bytesWritten,NSInteger progress);// 下载中，返回瞬时速度 和进度
typedef void(^DidDowaload) (NSString *savePath ,NSString *url);// 下载完成，参数 保存路径下载地址

@protocol DownloadDelegate <NSObject>

- (void)removeDownloadTask:(NSString *)url;

@end



@interface Download : NSObject
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)NSInteger progress;
@property(nonatomic,assign)id<DownloadDelegate>delegate;

// 给一个地址  初始化
- (instancetype)initWith:(NSString *)url;

//开始下载
-(void)start;

- (void)stop;


//监听下载的方法
- (void)monitorDownload:(Downloading )downloading DidDownload:(DidDowaload )didDownload;










@end
