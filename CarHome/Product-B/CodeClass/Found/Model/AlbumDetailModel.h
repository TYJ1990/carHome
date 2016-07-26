//
//  AlbumDetailModel.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, DownloadType){
    UnDownload,
    Downloadimg,
    DownloadPause,
    DiDdwonload
};

@interface AlbumDetailModel : NSObject


@property(nonatomic,strong)NSArray *anchor;
@property(nonatomic,strong)NSString *honoredguest;
@property(nonatomic,strong)NSNumber *program_comment_num;
@property(nonatomic,strong)NSString *program_file_size;
@property(nonatomic,strong)NSString *program_fileurl;
@property(nonatomic,strong)NSString *shareurl;
@property(nonatomic,strong)NSNumber *program_join_num;
@property(nonatomic,strong)NSString *program_live_time;
@property(nonatomic,strong)NSString *program_time_length;
@property(nonatomic,strong)NSString *program_title;
@property(nonatomic,assign)DownloadType downloadType;
@property(nonatomic,assign)BOOL isPlay;


+(NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)jsonDic;



@end
