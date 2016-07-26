//
//  MusicPlayViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "RadioPlayerView.h"
#import "AlbumPlayerView.h"
#import "LIveTimeManager.h"
#import "LiveModel.h"
#import "MyPlayerManager.h"
#import "AlbumDetailModel.h"
#import "AlbumListViewController.h"
#import "Download.h"
#import "DownloadManager.h"
#import "MusicDownloadTable.h"

@interface MusicPlayViewController ()
@property(nonatomic,strong)RadioPlayerView *radioV;
@property(nonatomic,strong)AlbumPlayerView *albumV;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)ListViewController *listVC;
@property(nonatomic,strong)AlbumListViewController *albumVC;

@end

@implementation MusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:29/255.0 green:30/255.0 blue:31/255.0 alpha:1];
    self.bottomView = [[BottomView alloc ]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 50)];
    
    [self creatBaseView];
    [self creatListView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:@"change" object:nil];
}





#pragma mark ---- 铺界面 ---------
- (void)creatBaseView{
    if (![LIveTimeManager shareInstance].isPlay) {
        self.albumV = [[[NSBundle mainBundle] loadNibNamed:@"AlbumPlayerView" owner:nil options:nil] firstObject];
        self.albumV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.albumV.vc = self;
        [self AlbumAddAction];
        NSInteger index = [MyPlayerManager defaultManager].index;
        [self.albumV loadDataWithAlbumIndex:index];
        [self.view addSubview:self.albumV];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    else{
        self.radioV = [[[NSBundle mainBundle] loadNibNamed:@"RadioPlayerView" owner:nil options:nil] firstObject];
        self.radioV.vc = self;
        self.radioV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        NSInteger index = [LIveTimeManager shareInstance].index;
        [self loadDataWithIndex:index];
        [self.view addSubview:self.radioV];
    }
}

- (void)AlbumAddAction{
    [self.albumV.above addTarget:self action:@selector(aboveAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.albumV.next addTarget:self action:@selector(nextAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.albumV.downLoadBtn addTarget:self action:@selector(downLoadBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}


- (void)creatListView{
    self.ListView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.ListView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.ListView];
    if ([LIveTimeManager shareInstance].isPlay) {
        self.listVC = [[ListViewController alloc] init];
        UIButton *btn = [self.listVC.view viewWithTag:1024];
        [btn addTarget:self action:@selector(ListcloseAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.ListView addSubview:self.listVC.view];
    }
    if ([MyPlayerManager defaultManager].isPlay) {
        self.albumVC = [[AlbumListViewController alloc] init];
        UIButton *btn = [self.albumVC.view viewWithTag:512];
        [btn addTarget:self action:@selector(ListcloseAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.ListView addSubview:self.albumVC.view];
    }
//    [self addChildViewController:self.listVC];
    
}





#pragma  mark  ----- 刷新界面----------
- (void)loadDataWithIndex:(NSInteger )index{
    LiveModel *model = [LIveTimeManager shareInstance].livetimeArray[index];
    [self.radioV.radiopic sd_setImageWithURL:[NSURL URLWithString:model.radiopicurl] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    self.radioV.radiopic.layer.masksToBounds = YES;
    self.radioV.radiopic.layer.cornerRadius = kScreenWidth/2.0 - 60;
    self.radioV.title.text = [NSString stringWithFormat:@"%@ %@",model.album,model.title];
    self.radioV.time.text = model.programtime;
    if (model.anchor.length > 0) {
        self.radioV.zhuchi.text = [NSString stringWithFormat:@"主持: %@",model.anchor];
    }
}




#pragma mark   -  ----- 上下首歌 --------------
- (void)aboveAction{
    [[MyPlayerManager defaultManager] lastMusic];
    NSInteger index = [MyPlayerManager defaultManager].index;
    [self.albumV loadDataWithAlbumIndex:index];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"relaData" object:nil];
}
- (void)nextAction{
    [[MyPlayerManager defaultManager] nextMusic];
    [self.albumV loadDataWithAlbumIndex:[MyPlayerManager defaultManager].index];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"relaData" object:nil];
}



// 定时器
-(void)timerAction{
    CGFloat total = [[MyPlayerManager defaultManager] totalTime];
    CGFloat current = [[MyPlayerManager defaultManager] currentTime];
    if (total == 0 || current == 0) {
        return;
    }
    self.albumV.slider.maximumValue = total;
    self.albumV.slider.value = current;
    self.albumV.current.text = [NSString stringWithFormat:@"%.2ld:%.2ld:%0.2ld",(NSInteger)current/3600,((NSInteger)current % 3600) / 60,(NSInteger)current % 60];
    self.albumV.all.text = [NSString stringWithFormat:@"%.2ld:%.2ld:%0.2ld",(NSInteger)total/3600,((NSInteger)total % 3600)/60 ,(NSInteger)total%60];
    
    if (current >= total - 2) {
        
        [[MyPlayerManager defaultManager] playerDidFinish];
        [self.albumV loadDataWithAlbumIndex:[MyPlayerManager defaultManager].index];
    }
}


#pragma mark ---- ---下载 --------
- (void)downLoadBtnAction:(UIButton *)btn{
    NSInteger index = [MyPlayerManager defaultManager].index;
    AlbumDetailModel *model = [MyPlayerManager defaultManager].musicLists[index];
    
    DownloadManager *dManager = [DownloadManager defaultManager];
    Download *task = [dManager createDownload:model.program_fileurl];
    [task start];
    [task monitorDownload:^(long long bytesWritten, NSInteger progress) {
        NSLog(@"%ld",progress);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:[NSString stringWithFormat:@"%ld%%",progress]];
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld%%",progress] forKey:model.program_fileurl];
        
        
        
        
    } DidDownload:^(NSString *savePath, NSString *url) {
        model.downloadType = DiDdwonload;
        
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



- (void)ListcloseAction{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    }];
    [self.albumV loadDataWithAlbumIndex:[MyPlayerManager defaultManager].index];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self.listVC.view]; //返回触摸点在视图中的当前坐标
    if (point.y < kScreenHeight/5.0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.ListView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        }];
       [self.albumV loadDataWithAlbumIndex:[MyPlayerManager defaultManager].index];
    }
}


- (void)changeValue:(NSNotification *)notification{
    NSString *string = notification.object;
    self.albumV.downloadL.text = string;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)dealloc{
    NSLog(@"..........%s",__FUNCTION__);
}



@end
