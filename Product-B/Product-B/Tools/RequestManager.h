//
//  RequestManager.h
//  02 UILesson - GETRequest
//
//  Created by lanou on 16/5/23.
//  Copyright © 2016年 liuping. All rights reserved.
//

#import <Foundation/Foundation.h>


//block
// 请求数据成功之后进行回调
typedef void(^Finish)(NSData *data);

// 请求数据失败之后进行回调 返回NSError
typedef void(^Error)(NSError *error);


// 请求方式的枚举(C语言中的枚举)
typedef NS_ENUM(NSInteger, requestType) {
    requestGET,
    requestPOST
    
};


@interface RequestManager : NSObject


@property (nonatomic, copy)Finish finish;

@property (nonatomic, copy)Error error;
+ (void)requestWithUrlString:(NSString *)urlString requestType :(requestType)requestType parDic:(NSDictionary *)patDic finish:(Finish )finish error:(Error )error;




@end
