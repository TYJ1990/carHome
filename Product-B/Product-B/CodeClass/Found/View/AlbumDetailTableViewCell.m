//
//  AlbumDetailTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AlbumDetailTableViewCell.h"
#import "MyPlayerManager.h"
#import "DownloadManager.h"
#import "Download.h"

@implementation AlbumDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)cellWithDetailModel:(AlbumDetailModel *)model{
    
    
    if (model.isPlay) {
        self.title.textColor = self.tintColor;
        self.countL.textColor = self.tintColor;
        self.time.textColor = self.tintColor;
        self.byte.textColor = self.tintColor;
    }else{
        self.title.textColor = [UIColor blackColor];
        self.countL.textColor = [UIColor lightGrayColor];
        self.time.textColor = [UIColor lightGrayColor];
        self.byte.textColor = [UIColor lightGrayColor];
    }
    
    self.title.text = [NSString stringWithFormat:@"%@ %@",model.program_live_time,model.program_title];
    self.countL.text = [NSString stringWithFormat:@"%@",model.program_join_num];
    self.time.text = model.program_time_length;
    self.byte.text = model.program_file_size;
    
    NSString *progres = [[NSUserDefaults standardUserDefaults] objectForKey:model.program_fileurl];
    if (progres) {
        if ([progres isEqualToString:@"100%"]) {
            self.downloadL.text = @"完成";
        }else{
            self.downloadL.text = progres;
//            DownloadManager *dManager = [DownloadManager defaultManager];
//            Download *task = [dManager createDownload:model.program_fileurl];
//            [task monitorDownload:^(long long bytesWritten, NSInteger progress) {
//                NSLog(@"-----%ld",progress);
//                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld%%",progress] forKey:model.program_fileurl];
//                self.downloadL.text = [NSString stringWithFormat:@"%ld%%",progress];
//            } DidDownload:^(NSString *savePath, NSString *url) {
//                self.downloadL.text = @"完成";
//            }];
        }
    }else{
        self.downloadL.text = @"下载";
    }
    
    
    
    
    
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}



@end
