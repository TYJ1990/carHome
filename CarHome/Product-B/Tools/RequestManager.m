//
//  RequestManager.m
//  02 UILesson - GETRequest
//
//  Created by lanou on 16/5/23.
//  Copyright © 2016年 liuping. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+ (void)requestWithUrlString:(NSString *)urlString requestType :(requestType)requestType parDic:(NSDictionary *)patDic finish:(Finish )finish error:(Error )error {
    
    // 这里视为了让每次的指定的对象都不一样，因为是不同对象去调用
    RequestManager *request = [[RequestManager alloc] init];
    //对象调用对象方法（下面的减号方法）
    [request requestWithUrlString:urlString requestType:requestType parDic:patDic finish:finish error:error];
}



- (void)requestWithUrlString:(NSString *)urlString requestType :(requestType)requestType parDic:(NSDictionary *)patDic finish:(Finish )finish error:(Error )error {
    
    self.finish = finish;
    self.error = error;

    NSURL *url  = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest  requestWithURL:url];
    request.timeoutInterval = 10;
    // 判断是什么请求方式
    if (requestType == requestPOST) {
        // 如果枚举是requestPOST， 那么设置请求方式为POST
        [request setHTTPMethod:@"POST"];
        //保护，判断传进的字典是否为空
        if (patDic.count > 0) {
            // 封装 将字典转换成数组，在将数组拼接成data
            [request setHTTPBody:[self parDicToPOSTData:patDic]];
        }
    }
    
    
    //单例类
    NSURLSession *session = [NSURLSession sharedSession];
    //    NSURLSessionDataTask 数据请求
    //    NSURLSessionDownloadTask 下载数据
    //    NSURLSessionUploadTask 上传数据
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            self.error(error);
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.finish(data);
            });
            
        }
    }];
    // 调用此方式  才是异步链接
    [task resume];
}


// 将字典转换成数组，在将数组拼接成data

- (NSData *)parDicToPOSTData:(NSDictionary *)parDic {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key  in parDic) {
        NSString *string = [NSString stringWithFormat:@"%@=%@", key, parDic[key]];
        [array addObject:string];
    }
    NSString *postString = [array componentsJoinedByString:@"&"];//通过&连接所有数组元素，并以字符串格式输出
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];//POST请求的参数列表转化成Data
    return postData;
    
}







@end
