//
//  MusicModel.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property(nonatomic,strong)NSString *album_imgurl;
@property(nonatomic,strong)NSString *album_descrition;
@property(nonatomic,strong)NSString *album_id;
@property(nonatomic,strong)NSString *album_name;
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,assign)BOOL is_new;
@property(nonatomic,strong)NSNumber *radiozancount;

+(NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)jsonDic;



@end
