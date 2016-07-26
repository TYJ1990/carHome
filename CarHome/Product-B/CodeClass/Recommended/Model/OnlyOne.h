//
//  OnlyOne.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlyOne : NSObject


@property(nonatomic,strong)NSMutableDictionary *titleArray;
@property(nonatomic,assign)NSInteger index;


+ (OnlyOne *)shareInstance;

@end
