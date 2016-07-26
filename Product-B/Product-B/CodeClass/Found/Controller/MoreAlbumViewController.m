//
//  MoreAlbumViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MoreAlbumViewController.h"
#import "LiveModel.h"
#import "MusicModel.h"
#import "AlbumButton.h"
#import "LIveTimeManager.h"
#import "BottomView.h"
#import "AlbumDetailModel.h"
#import "MyPlayerManager.h"
#import "MusicDetailViewController.h"
#import "ListViewController.h"

@interface MoreAlbumViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)UIView *ListView;
@property(nonatomic,strong)ListViewController *listVC;

@end

@implementation MoreAlbumViewController

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self creatTitle];
}


- (void)loadData{
    [RequestManager requestWithUrlString:kMoreAlbum requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [MusicModel modelConfigureJsonDic:dic];
        [self creatScrollView];
        [self creatBottom];
        [self getValue];
        [self creatListView];
    } error:^(NSError *error) {
        
    }];
}



- (void)creatScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth,kScreenHeight - 60)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, 70 + ((self.modelArray.count - 1) / 3 + 1) * (kScreenWidth / 3.0 + 20 ));
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.modelArray.count; i++) {
        MusicModel *model = self.modelArray[i];
        AlbumButton *albumBtn = [[AlbumButton alloc] initWithFrame:CGRectMake((i % 3) * kScreenWidth/3.0, ( i / 3) * (kScreenWidth/3.0 + 20) + 20, kScreenWidth/3.0, kScreenWidth/3.0)];
        [albumBtn.imageV sd_setImageWithURL:[NSURL URLWithString:model.album_imgurl] placeholderImage:[UIImage imageNamed:@""]];
        albumBtn.title.text = model.album_name;
        albumBtn.timeL.text = model.update_time;
        albumBtn.tag = 100+i;
        [albumBtn addTarget:self action:@selector(albumBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.scrollView addSubview:albumBtn];
    }
}

- (void)creatTitle{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    title.text = @"点播";
    title.textColor = [UIColor grayColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:title];
    
    UIButton *back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [back setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    back.frame = CGRectMake(5, 30, 40, 20);
    [back setTintColor:self.view.tintColor];
    [back addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:back];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)creatBottom{
    self.bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 55, kScreenWidth, 55)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    self.bottomView.vc = self;
    [self.bottomView.next addTarget:self action:@selector(listShow1) forControlEvents:(UIControlEventTouchUpInside)];
    __weak MoreAlbumViewController *weakSelf = self;
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
        [btn addTarget:self action:@selector(carClose1) forControlEvents:(UIControlEventTouchUpInside)];
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


- (void)albumBtnAction:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    MusicModel *model = self.modelArray[index];
    MusicDetailViewController *detailVC = [[MusicDetailViewController alloc] init];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    if (![LIveTimeManager shareInstance].isPlay) {
        [MyPlayerManager defaultManager].bottiomView = self.bottomView;
    }
}

- (void)listShow1{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
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


- (void)carClose1{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    }];
}





@end
