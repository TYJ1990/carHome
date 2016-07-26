
//
//  AlbumPlayerView.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AlbumPlayerView.h"
#import "MyPlayerManager.h"
#import "AlbumDetailModel.h"
#import "AlbumListViewController.h"
#import "Download.h"
#import "DownloadManager.h"

@implementation AlbumPlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)timing:(id)sender {
}
- (IBAction)share:(id)sender {
}
- (IBAction)progress:(id)sender {
    UISlider *slider = sender;
    [[MyPlayerManager defaultManager] seekToSecondsWith:slider.value];
    [[MyPlayerManager defaultManager] play];
    [self.playAndPause setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateNormal)];
}
- (IBAction)LIKE:(id)sender {
    
}


- (IBAction)list:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.vc.ListView.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
    
}

- (IBAction)playandPause:(id)sender {
    if ([MyPlayerManager defaultManager].isPlay) {
        [[MyPlayerManager defaultManager] play];
        [self.playAndPause setImage:[UIImage imageNamed:@"暂停2"] forState:(UIControlStateNormal)];
        [self.vc.bottomView.play setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateNormal)];
    }else{
        [[MyPlayerManager defaultManager] pause];
        [self.playAndPause setImage:[UIImage imageNamed:@"开始2"] forState:(UIControlStateNormal)];
        [self.vc.bottomView.play setImage:[UIImage imageNamed:@"开始3"] forState:(UIControlStateNormal)];
    }
    [MyPlayerManager defaultManager].isPlay = ![MyPlayerManager defaultManager].isPlay;
    
}

- (IBAction)comment:(id)sender {
    
}

- (IBAction)back:(id)sender {
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}


- (void)loadDataWithAlbumIndex:(NSInteger )index{
    AlbumDetailModel *model = [MyPlayerManager defaultManager].musicLists[index];
    self.icon.image = self.vc.picurl;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 110;
    
    self.title.text = [NSString stringWithFormat:@"%@ %@ %@",self.vc.album,model.program_live_time,model.program_title];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:model.program_fileurl]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:model.program_fileurl] isEqualToString:@"100%"]) {
            self.downloadL.text = @"完成";
        }else{
            self.downloadL.text = [[NSUserDefaults standardUserDefaults] objectForKey:model.program_fileurl];
            DownloadManager *dManager = [DownloadManager defaultManager];
            Download *task = [dManager createDownload:model.program_fileurl];
            [task monitorDownload:^(long long bytesWritten, NSInteger progress) {
                NSLog(@"+++");
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld%%",progress] forKey:model.program_fileurl];
                self.downloadL.text = [NSString stringWithFormat:@"%ld%%",progress];
                
            } DidDownload:^(NSString *savePath, NSString *url) {
                
            }];
            
        }
        self.downLoadBtn.userInteractionEnabled = NO;
    }else{
        self.downloadL.text = @"下载";
        self.downLoadBtn.userInteractionEnabled = YES;
    }
    
    
    if (model.anchor.count > 0) {
        NSMutableString *string = [[NSMutableString alloc] init];
        for (NSDictionary *dic in model.anchor) {
            [string appendString:dic[@"username"]];
            [string appendString:@" "];
        }
        
        if (model.honoredguest.length > 1) {
            self.ancho.text = [NSString stringWithFormat:@"主播: %@ 嘉宾: %@",string,model.honoredguest];
        }else{
            self.ancho.text = [NSString stringWithFormat:@"主播 %@",string];
        }
    }
    self.likeL.text = [NSString stringWithFormat:@"%u",arc4random()%100];
}














@end
