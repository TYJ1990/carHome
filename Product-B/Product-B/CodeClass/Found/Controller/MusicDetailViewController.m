//
//  MusicDetailViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "BlurView.h"
#import "AlbumDetailModel.h"
#import "AlbumDetailTableViewCell.h"
#import "BottomView.h"
#import "LiveModel.h"
#import "LIveTimeManager.h"
#import "MyPlayerManager.h"
#import "ListViewController.h"
#import "DownloadManager.h"
#import "Download.h"
#import "MusicDownloadTable.h"

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)BlurView *blurView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,assign )BOOL isDownload;
@property(nonatomic,strong)UIView *animationView;
@property(nonatomic,assign)BOOL isFirst;
@property(nonatomic,strong)UIView *ListView;
@property(nonatomic,strong)ListViewController *listVC;

@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatTableView];
    [self creatBlurView];
    [self creatTopView];
    [self loadData];
    [self creatBottomView];
    [self getValue];
    [self creatListView];
    [self.view addSubview:self.animationView];
    
    [self download];
    
}

- (void)download{
    
}



#pragma mark ---------- 创建视图 --------
- (void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 55) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:@"AlbumDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (void)creatBlurView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3.0 + 40)];
    self.tableView.tableHeaderView = view;
    self.blurView = [[BlurView alloc] initWithFrame:CGRectMake(0, -160, kScreenWidth, kScreenHeight / 3.0 + 160 + 40)];
    [self.blurView.timeBtn addTarget:self action:@selector(sortTime) forControlEvents:(UIControlEventTouchUpInside)];
    [self.blurView.hotBtn addTarget:self action:@selector(sortHot) forControlEvents:(UIControlEventTouchUpInside)];
    [self.blurView.icon sd_setImageWithURL:[NSURL URLWithString:self.model.album_imgurl] placeholderImage:[UIImage imageNamed:self.model.album_imgurl]];
    self.blurView.titleL.text = self.model.album_name;
    self.blurView.content.text = self.model.album_descrition;
    [view addSubview:self.blurView];
}

- (void)creatTopView{
    self.topView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    self.topView.backgroundColor = [UIColor blackColor];
    self.topView.alpha = 0.1;
    [self.view addSubview:self.topView];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(5, 32, 40, 18);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    UIButton *download = [UIButton buttonWithType:(UIButtonTypeSystem)];
    download.frame = CGRectMake(kScreenWidth - 65, 25, 55, 25);
    download.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [download setTitle:@"批量下载" forState:(UIControlStateNormal)];
    [download setTintColor:[UIColor whiteColor]];
    [download addTarget:self action:@selector(downloadAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:download];
}

- (UIView *)animationView{
    if (!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 50)];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.8;
        [_animationView addSubview:view];
        
        UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancelBtn setTintColor:[UIColor whiteColor]];
        [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        cancelBtn.frame = CGRectMake(0, 0, kScreenWidth/2.0, 50);
        [_animationView addSubview:cancelBtn];
        
        UIButton *downloadBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [downloadBtn setTitle:@"下载" forState:(UIControlStateNormal)];
        [downloadBtn setTintColor:[UIColor lightGrayColor]];
        [downloadBtn addTarget:self action:@selector(downLoadBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        downloadBtn.frame = CGRectMake(kScreenWidth/2.0, 0, kScreenWidth/2.0, 50);
        [_animationView addSubview:downloadBtn];
    }
    return _animationView;
}


#pragma mark  ----- 创建底部视图，并赋值 --------
- (void)creatBottomView{
    self.bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 55, kScreenWidth, 55)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    self.bottomView.vc = self;
    [self.bottomView.next addTarget:self action:@selector(listShow2) forControlEvents:(UIControlEventTouchUpInside)];
    __weak MusicDetailViewController *weakSelf = self;
    self.bottomView.resultBlock = ^(NSString *title,NSString *album,NSString *icon){
        [weakSelf.bottomView.icon sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@""]];
        weakSelf.bottomView.titleL.text = title;
        weakSelf.bottomView.album.text = album;
        [weakSelf.bottomView.next setImage:[UIImage imageNamed:@"下一首"] forState:(UIControlStateNormal)];
    };
    [self.view addSubview:self.bottomView];
}

- (void)creatListView{
    self.ListView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.ListView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.ListView];
    self.ListView.tag = 520;
    self.listVC = [[ListViewController alloc] init];
    if ([LIveTimeManager shareInstance].isPlay) {
        UIButton *btn = [self.listVC.view viewWithTag:1024];
        [btn addTarget:self action:@selector(carClose3) forControlEvents:(UIControlEventTouchUpInside)];
    }
    [self.ListView addSubview:self.listVC.view];
    
}



- (void)getValue{
    if ([LIveTimeManager shareInstance].isPlay) {
        NSInteger index = [LIveTimeManager shareInstance].index;
        LiveModel *model = [LIveTimeManager shareInstance].livetimeArray[index];
        [self.bottomView.icon sd_setImageWithURL:[NSURL URLWithString:model.radiopicurl] placeholderImage:[UIImage imageNamed:@""]];
        self.bottomView.titleL.text = @"汽车之家音频";
        self.bottomView.album.text = model.album;
        [self.bottomView.play setImage:[UIImage imageNamed:@"暂停2"] forState:(UIControlStateNormal)];
        [self.bottomView.next setImage:[UIImage imageNamed:@"列表"] forState:(UIControlStateNormal)];
    }
    else{
        [MyPlayerManager defaultManager].bottiomView = self.bottomView;
    }
}


#pragma mark ------- 网络请求 --------------
- (void)loadData{
    
    [RequestManager requestWithUrlString:[NSString stringWithFormat:@"http://news.app.autohome.com.cn/radio_v5.6.0/News/newsonewradiolist-pm1-aid%@-p1-s50-tp0.json",self.model.album_id] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [AlbumDetailModel modelConfigureJsonDic:dic];
        [self.tableView reloadData];
        if ([self.model.album_name isEqualToString:[MyPlayerManager defaultManager].albumName]) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[MyPlayerManager defaultManager].index inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
        }
        self.blurView.like.text = [NSString stringWithFormat:@"%@人喜欢",[self.modelArray lastObject]];
    } error:^(NSError *error) {
        
    }];
}





#pragma mark - -  tableView 代理方法 -----------------
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count - 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.downLoad addTarget:self action:@selector(downloadAction2:) forControlEvents:(UIControlEventTouchUpInside)];
    
    AlbumDetailModel *model = self.modelArray[indexPath.row];
    [cell cellWithDetailModel:model];
    if ([MyPlayerManager defaultManager].isPlay && [self.model.album_name isEqualToString:[MyPlayerManager defaultManager].albumName]) {
        if (indexPath.row == [MyPlayerManager defaultManager].index) {
            cell.title.textColor = self.view.tintColor;
            cell.countL.textColor = self.view.tintColor;
            cell.time.textColor = self.view.tintColor;
            cell.byte.textColor = self.view.tintColor;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isDownload) {
        return;
    }
    
    
    
    AlbumDetailModel *model = self.modelArray[indexPath.row];
    model.isPlay = YES;
    
    AlbumDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.title.textColor = self.view.tintColor;
    cell.countL.textColor = self.view.tintColor;
    cell.time.textColor = self.view.tintColor;
    cell.byte.textColor = self.view.tintColor;
    
    [[LIveTimeManager shareInstance].player pause];
    [LIveTimeManager shareInstance].isPlay = NO;
    [MyPlayerManager defaultManager].musicLists = self.modelArray;
    [MyPlayerManager defaultManager].isPlay = YES;
    [MyPlayerManager defaultManager].albumName = self.model.album_name;
    [MyPlayerManager defaultManager].index = indexPath.row;
    [[MyPlayerManager defaultManager] changeMusicWith:indexPath.row];
    self.bottomView.resultBlock(cell.title.text,self.model.album_name,self.model.album_imgurl);
    [MyPlayerManager defaultManager].dic = [@{@"title":cell.title.text,@"albumname":self.model.album_name,@"image":self.model.album_imgurl} mutableCopy];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailModel *model = self.modelArray[indexPath.row];
    model.isPlay = NO;
    AlbumDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.title.textColor = [UIColor blackColor];
    cell.countL.textColor = [UIColor lightGrayColor];
    cell.time.textColor = [UIColor lightGrayColor];
    cell.byte.textColor = [UIColor lightGrayColor];
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailModel *model = self.modelArray[indexPath.row];
    CGFloat heigth = [UILabel getHeightByWidth:kScreenWidth - 50 title:[NSString stringWithFormat:@"%@ %@",model.program_live_time,model.program_title] font:[UIFont systemFontOfSize:15.0]];
    return heigth + 50;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1|2;
}







#pragma mark ------- button 的跳转方法 --------
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadAction{
    if (self.isDownload) {
        [self.tableView setEditing:NO animated:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.animationView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 50);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
            }];
        }];
    }else{
        [super setEditing:YES animated:NO];
        [self.tableView setEditing:YES animated:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 50);
        } completion:^(BOOL finished) {
           [UIView animateWithDuration:0.5 animations:^{
               self.animationView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
           }];
        }];
    }
    self.isDownload = !self.isDownload;
}


- (void)cancelBtn:(UIButton *)btn{
    [self.tableView setEditing:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.animationView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 50);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
        }];
    }];
    self.isDownload = NO;
}


// 批量下载
- (void)downLoadBtn:(UIButton *)btn{
    
}


//下载
- (void)downloadAction2:(UIButton *)btn{
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






#pragma mark -------排序 ----------
- (void)sortTime{
    [self.blurView.timeBtn setTintColor:self.view.tintColor];
    [self.blurView.hotBtn setTintColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
    
    
    
}

- (void)sortHot{
    [self.blurView.hotBtn setTintColor:self.view.tintColor];
    [self.blurView.timeBtn setTintColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
    
    
}

#pragma mark -------- 调节顶部视图透明度 ----------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > 0) {
        CGFloat rat = (scrollView.contentOffset.y + 5) / 100.0;
        self.topView.alpha = rat;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    if (![LIveTimeManager shareInstance].isPlay) {
        [MyPlayerManager defaultManager].bottiomView = self.bottomView;
    }
    if (self.isFirst) {
        for (int i = 0; i < self.modelArray.count - 1; i++) {
            AlbumDetailModel *model = self.modelArray[i];
            
            [self judgeDownloadWith:model index:i];
            
            if (i == [MyPlayerManager defaultManager].index) {
                model.isPlay = YES;
            }else{
                model.isPlay = NO;
            }
        }
    }else{
        self.isFirst = YES;
        return;
    }
    [self.tableView reloadData];
}



- (void)judgeDownloadWith:(AlbumDetailModel *)model index:(NSInteger )i{
    
    NSString *progres = [[NSUserDefaults standardUserDefaults] objectForKey:model.program_fileurl];
    if (progres) {
        AlbumDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([progres isEqualToString:@"100%"]) {
            cell.downloadL.text = @"完成";
        }else{
            cell.downloadL.text = progres;
            DownloadManager *dManager = [DownloadManager defaultManager];
            Download *task = [dManager createDownload:model.program_fileurl];
            [task monitorDownload:^(long long bytesWritten, NSInteger progress) {
                
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld%%",progress] forKey:model.program_fileurl];
                cell.downloadL.text = [NSString stringWithFormat:@"%ld%%",progress];
                [self.tableView reloadData];
            } DidDownload:^(NSString *savePath, NSString *url) {
                cell.downloadL.text = @"完成";
            }];
        }
    }
}








- (void)listShow2{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
- (void)carClose3{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    }];
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


@end
