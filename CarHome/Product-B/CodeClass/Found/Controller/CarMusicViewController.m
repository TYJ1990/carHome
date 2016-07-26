//
//  CarMusicViewController.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "CarMusicViewController.h"
#import "MusicModel.h"
#import "AlbumButton.h"
#import "MusicModel.h"
#import "LiveModel.h"
#import "LIveTimeManager.h"
#import "MyPlayerManager.h"
#import "MoreAlbumViewController.h"
#import "BottomView.h"
#import "DownloadViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicDetailViewController.h"
#import "ListViewController.h"

@interface CarMusicViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *AlbumView;
@property(nonatomic,strong)UIImageView *blurView;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)NSMutableArray *liveModelArray;
@property(nonatomic,strong)UIVisualEffectView *visuallEffetView;
@property(nonatomic,strong)UIButton *playAndPause;
@property(nonatomic,assign)BOOL isPlay;
@property(nonatomic,strong)ListViewController *listVC;
@property(nonatomic,strong)UIView *ListView;

@end

@implementation CarMusicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self.view addSubview:self.scrollView];
    self.isPlay = YES;
    [self loadData];
    [self creatTopView];
}


#pragma mark ---------------------- 属性 -----------------
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight/3.0 + 200 + kScreenWidth/3.0 * 5);
        _scrollView.delegate = self;
    }
    return _scrollView;
}






#pragma mark - -------------------网络请求------------------
- (void)loadData{
    [RequestManager requestWithUrlString:kAlbum requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [MusicModel modelConfigureJsonDic:dic];
        [self creatAlbumView];
        [self creatBlruView];
        [self loadLiveData];
    } error:^(NSError *error) {
        
    }];
}

- (void)loadLiveData{
    [RequestManager requestWithUrlString:kLive requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.liveModelArray = [LiveModel modelConfigureJsonDic:dic];
        [LIveTimeManager shareInstance].livetimeArray = self.liveModelArray;
//        [MyPlayerManager defaultManager].musicLists = self.liveModelArray;
        self.participantsnum = dic[@"result"][@"participantsnum"];
        self.radioinfourl = dic[@"result"][@"radioinfourl"];
        [self creatBottomView];
        [self getLiveNameAndAuthor];
        [self creatListView];
    } error:^(NSError *error) {
        
    }];
}







#pragma mark ---------------------- 创建中部视图---------------------------------
- (void)creatAlbumView{
  
    self.AlbumView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/3.0 + 15, kScreenWidth, 440 + kScreenWidth/3.0 * 5)];
    self.AlbumView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.AlbumView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 100, 40)];
    title.text = @"点播";
    title.font = [UIFont systemFontOfSize:16.0];
    [self.AlbumView addSubview:title];
    
    UIButton *moreBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
    [moreBtn setTintColor:[UIColor lightGrayColor]];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    moreBtn.frame = CGRectMake(kScreenWidth - 70, title.top- 2, 50, 36);
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.AlbumView addSubview:moreBtn];
    
    UIView *horizonView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, kScreenWidth - 40, 0.5)];
    horizonView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self.AlbumView addSubview:horizonView];
    
    for (int i = 0; i < self.modelArray.count; i++) {
        MusicModel *model = self.modelArray[i];
        AlbumButton *albumBtn = [[AlbumButton alloc] initWithFrame:CGRectMake((i % 3) * kScreenWidth/3.0, ( i / 3) * (kScreenWidth/3.0 + 20) + 100, kScreenWidth/3.0, kScreenWidth/3.0)];
        [albumBtn.imageV sd_setImageWithURL:[NSURL URLWithString:model.album_imgurl] placeholderImage:[UIImage imageNamed:@""]];
        albumBtn.tag = i + 100;
        albumBtn.title.text = model.album_name;
        albumBtn.timeL.text = model.update_time;
        [albumBtn addTarget:self action:@selector(albumBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.AlbumView addSubview:albumBtn];
    }
}




#pragma mark ---------------------- 创建毛玻璃视图-------------------
- (void)creatBlruView{
    self.blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -180, kScreenWidth, 180 + kScreenHeight/3.0 + 50)];
    self.blurView.image = [UIImage imageNamed:@"background2.jpeg"];
    self.blurView.backgroundColor = [UIColor blackColor];
    self.blurView.userInteractionEnabled = YES;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100 + 180, 200, 15)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.blurView addSubview:self.titleLabel];
    
    self.topic = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.bottom + 5, kScreenWidth, 15)];
    self.topic.backgroundColor = [UIColor clearColor];
    self.topic.textColor = [UIColor whiteColor];
    self.topic.font = [UIFont systemFontOfSize:14.0];
    [self.blurView addSubview:self.topic];
    
    self.anchor = [[UILabel alloc] initWithFrame:CGRectMake(10, self.topic.bottom + 8, kScreenWidth - 20, 15)];
    self.anchor.textColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.anchor.font = [UIFont systemFontOfSize:12.0];
    self.anchor.backgroundColor = [UIColor clearColor];
    [self.blurView addSubview:self.anchor];
    
    
    self.playAndPause = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.playAndPause.frame = CGRectMake(0, self.blurView.frame.size.height - 40, kScreenWidth/3.0, 40);
    [self.playAndPause setTitle:@"暂停" forState:(UIControlStateNormal)];
//    [playAndPause setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    self.playAndPause.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.playAndPause setTintColor:[UIColor whiteColor]];
    [self.playAndPause addTarget:self action:@selector(playAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.blurView addSubview:self.playAndPause];
    
    UIButton *comment = [UIButton buttonWithType:(UIButtonTypeSystem)];
    comment.tag = 300;
    comment.frame = CGRectMake(kScreenWidth/3.0, self.blurView.frame.size.height - 40, kScreenWidth/3.0, 40);
    [comment setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    comment.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [comment setTintColor:[UIColor whiteColor]];
    [self.blurView addSubview:comment];
    
    UIButton *share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    share.frame = CGRectMake(kScreenWidth*2/3.0, self.blurView.frame.size.height - 40, kScreenWidth/3.0, 40);
    [share setTitle:@"分享节目" forState:(UIControlStateNormal)];
    [share setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    share.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [share setTintColor:[UIColor whiteColor]];
    [self.blurView addSubview:share];

    [self.scrollView addSubview:self.blurView];
}


- (void)reloadDataWithIndex:(NSInteger )index{
    LiveModel *model = [LIveTimeManager shareInstance].livetimeArray[index];
    self.titleLabel.text = model.album;
    UIButton *comment = [self.blurView viewWithTag:300];
    [comment setTitle:[NSString stringWithFormat:@"%@人参与",self.participantsnum] forState:(UIControlStateNormal)];

    if (model.anchor.length > 1) {
        if (model.honoredguest.length > 1) {
            self.anchor.text = [NSString stringWithFormat:@"主播:  %@    嘉宾:  %@",model.anchor,model.honoredguest];
        }else{
            self.anchor.text = [NSString stringWithFormat:@"主播:  %@",model.anchor];
        }
    }
    
    if (model.title.length > 0) {
        self.topic.text = [NSString stringWithFormat:@"话题:  %@",model.title];
    }
    if ([LIveTimeManager shareInstance].isPlay) {
        self.bottomView.resultBlock(@"汽车之家音频",model.album,model.radiopicurl);
        [self.bottomView.next setImage:[UIImage imageNamed:@"列表"] forState:(UIControlStateNormal)];
    }
}




#pragma mark --------------------- 创建顶部视图-----------------------
- (void)creatTopView{
    self.topView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    self.topView.backgroundColor = [UIColor blackColor];
    self.topView.alpha = 0.1;
    [self.view addSubview:self.topView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kScreenWidth, 35)];
    title.text = @"汽车之家音频";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:title];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(5, 25, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"返回2"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    UIButton *download = [UIButton buttonWithType:(UIButtonTypeSystem)];
    download.frame = CGRectMake(kScreenWidth - 30, 25, 25, 25);
    [download setImage:[UIImage imageNamed:@"下载"] forState:(UIControlStateNormal)];
    [download setTintColor:[UIColor whiteColor]];
    [download addTarget:self action:@selector(downloadAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:download];
    
}



#pragma mark ---------------------- 创建底部视图-----------------------
- (void)creatBottomView{
    self.bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 55, kScreenWidth, 55)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    self.bottomView.vc = self;
    [self.bottomView.next addTarget:self action:@selector(listShow) forControlEvents:(UIControlEventTouchUpInside)];
    __weak CarMusicViewController *weakSelf = self;
    self.bottomView.resultBlock = ^(NSString *title,NSString *album,NSString *icon){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.bottomView.icon sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@""]];
            weakSelf.bottomView.titleL.text = title;
            weakSelf.bottomView.album.text = album;
            [weakSelf.bottomView.play setImage:[UIImage imageNamed:@"暂停2.png"] forState:(UIControlStateNormal)];
        });
    };
    [self.view addSubview:self.bottomView];
}

- (void)creatListView{
    self.ListView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.ListView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.ListView];
    self.listVC = [[ListViewController alloc] init];
    if ([LIveTimeManager shareInstance].isPlay) {
        UIButton *btn = [self.listVC.view viewWithTag:1024];
        [btn addTarget:self action:@selector(carClose) forControlEvents:(UIControlEventTouchUpInside)];
    }
    [self.ListView addSubview:self.listVC.view];
    
}






#pragma mark --------------- 根据当前时间判断播放的是哪一首歌------------------
- (void)getLiveNameAndAuthor{
    
    NSDate *date = [[NSDate alloc] init];
    for (int i = 0; i < self.liveModelArray.count; i++) {
        LiveModel *model = self.liveModelArray[i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *startDate = [dateFormatter dateFromString:model.starttime];
        NSDate *endDate = [dateFormatter dateFromString:model.endtime];
        if ([self date:date isBetweenDate:startDate andDate:endDate]) {
            [LIveTimeManager shareInstance].index = i;
            [self play];
            [self reloadDataWithIndex:i];
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            [timer fire];
        }
    }
}


- (void)play{
    if (![MyPlayerManager defaultManager].isPlay && ![LIveTimeManager shareInstance].isPlay) {
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://live.fm.autohome.com.cn/auto.m3u8"]];
        [[LIveTimeManager shareInstance].player replaceCurrentItemWithPlayerItem:item];
        [[LIveTimeManager shareInstance].player play];
        [LIveTimeManager shareInstance].isPlay = YES;
    }
}



- (void)timerAction{
    
    NSDate *date = [[NSDate alloc] init];
    NSInteger index = [LIveTimeManager shareInstance].index;
    LiveModel *model = [LIveTimeManager shareInstance].livetimeArray[index];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *endDate = [dateFormatter dateFromString:model.endtime];
    if ([date compare:endDate] == NSOrderedDescending) {
        if (index == 16) {
            [self reloadDataWithIndex:0];
            [LIveTimeManager shareInstance].index = 0;
        }else{
            [self reloadDataWithIndex:index + 1];
            [LIveTimeManager shareInstance].index = index + 1;
        }
    }
    date = nil;
    dateFormatter = nil;
}
- (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    if ([date compare:beginDate] == NSOrderedAscending)  return NO;
    if ([date compare:endDate] == NSOrderedDescending)  return NO;
    return YES;
}




#pragma mark ----------button 跳转方法 ---------
- (void)moreBtnAction:(UIButton *)btn{
    MoreAlbumViewController *moreVC = [[MoreAlbumViewController alloc] init];
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)downloadAction{
    DownloadViewController *downloadVC = [[DownloadViewController alloc] init];
    [self.navigationController pushViewController:downloadVC animated:YES];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)albumBtnAction:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    MusicModel *model = self.modelArray[index];
    MusicDetailViewController *detailVC = [[MusicDetailViewController alloc] init];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)playAction{
    if (!self.isPlay) {
        [[MyPlayerManager defaultManager] pause];
        [MyPlayerManager defaultManager].isPlay = NO;
        [self getLiveNameAndAuthor];
        [self.playAndPause setTitle:@"暂停" forState:(UIControlStateNormal)];
        [self.bottomView.play setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateNormal)];
    }else{
        [LIveTimeManager shareInstance].isPlay = NO;
        [[LIveTimeManager shareInstance].player pause];
        [self.playAndPause setTitle:@"收听" forState:(UIControlStateNormal)];
        [self.bottomView.play setImage:[UIImage imageNamed:@"开始3"] forState:(UIControlStateNormal)];
    }
    self.isPlay = !self.isPlay;
    
}

- (void)listShow{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
- (void)carClose{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    }];
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
    if (self.scrollView.contentOffset.y > -10) {
        CGFloat rat = (scrollView.contentOffset.y + 11) / 65.0;
        self.topView.alpha = rat;
    }
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self.listVC.view]; //返回触摸点在视图中的当前坐标
    if (point.y < kScreenHeight/5.0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.ListView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        }];
    }
}









- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    if (![LIveTimeManager shareInstance].isPlay && [MyPlayerManager defaultManager].isPlay) {
        [MyPlayerManager defaultManager].bottiomView = self.bottomView;
        [self.playAndPause setTitle:@"收听" forState:(UIControlStateNormal)];
        self.isPlay = NO;
    }else{
        [self.playAndPause setTitle:@"暂停" forState:(UIControlStateNormal)];
        self.isPlay = YES;
    }
}



@end
