//
//  DownloadManager.h
//  Product- A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Download.h"

@interface DownloadManager : NSObject

+ (DownloadManager *)defaultManager;
// 创建一个下载任务
- (Download *)createDownload:(NSString *)url;





@end
