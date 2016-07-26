//
//  DownloadViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "DownloadViewController.h"
#import "BottomView.h"
#import "LiveModel.h"
#import "LIveTimeManager.h"
#import "MyPlayerManager.h"
#import "ListViewController.h"

@interface DownloadViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *download;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)ListViewController *listVC;
@property(nonatomic,strong)UIView *ListView;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    [self creatTitle];
    [self creatBottomView];
    [self.view addSubview:self.tableView];
    [self getValue];
    [self creatListView];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, kScreenWidth, kScreenHeight - 105 - 55) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}




- (void)creatTitle{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    title.text = @"离线下载";
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16.0];
    [view addSubview:title];
    
    UIButton *back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    back.backgroundColor = [UIColor whiteColor];
    [back setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    back.frame = CGRectMake(5, 30, 40, 20);
    [back setTintColor:self.view.tintColor];
    [back addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:back];
    
    self.download = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.download setTintColor:self.view.tintColor];
    [self.download setTitle:@"编辑" forState:(UIControlStateNormal)];
    self.download.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.download.frame = CGRectMake(kScreenWidth - 50, 30, 35, 20);
    [view addSubview:self.download];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"已下载",@"正在下载"]];
    seg.frame = CGRectMake(5, 70, kScreenWidth - 10, 25);
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(segAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:seg];
    
    
    
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)segAction:(UISegmentedControl *)seg{
    
}




- (void)creatBottomView{
    self.bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 55, kScreenWidth, 55)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    self.bottomView.vc = self;
    [self.bottomView.next addTarget:self action:@selector(listShow2) forControlEvents:(UIControlEventTouchUpInside)];
    __weak DownloadViewController *weakSelf = self;
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
        [btn addTarget:self action:@selector(carClose2) forControlEvents:(UIControlEventTouchUpInside)];
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





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


- (void)viewWillAppear:(BOOL)animated{
    if (![LIveTimeManager shareInstance].isPlay) {
        [MyPlayerManager defaultManager].bottiomView = self.bottomView;
    }
}

- (void)listShow2{
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

- (void)carClose2{
    [UIView animateWithDuration:0.2 animations:^{
        self.ListView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    }];
}



@end
