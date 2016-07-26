//
//  AlbumListViewController.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AlbumListViewController.h"
#import "LIveTimeManager.h"
#import "AlbumDetailTableViewCell.h"
#import "MyPlayerManager.h"
#import "AlbumDetailModel.h"
#import "MusicPlayViewController.h"

@interface AlbumListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AlbumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.4;
    view.tag = 100;
    [self.view addSubview:view];
    
    self.graryView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/5.0, kScreenWidth, kScreenHeight*4/5.0)];
    self.graryView.backgroundColor = [UIColor colorWithRed:32/255.0 green:33/255.0 blue:34/255.0 alpha:0.9];
    self.graryView.alpha = 1;
    [self.view addSubview:self.graryView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    title.text = @"节目单";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.graryView addSubview:title];
    
    
    UIView *HorizolView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
    HorizolView.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    [self.graryView addSubview:HorizolView];
    
    [self createBtn];
    [self.view addSubview:self.tableView];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[MyPlayerManager defaultManager].index inSection:0] atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[MyPlayerManager defaultManager].index inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionMiddle)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relaData) name:@"relaData" object:nil];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight/5.0 + 51, kScreenWidth, kScreenHeight*4/5.0 - 51 - 50) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"AlbumDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}



- (void)createBtn{
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight*4/5.0 - 50, kScreenWidth, 1)];
    view2.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    [self.graryView addSubview:view2];
    
    self.close = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.close.frame = CGRectMake(0, kScreenHeight*4/5.0 - 49, kScreenWidth, 49);
    self.close.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.close setTintColor:[UIColor whiteColor]];
    self.close.tag = 512;
    self.close.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.close setTitle:@"关闭" forState:(UIControlStateNormal)];
    [self.graryView addSubview:self.close];
}



- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",[MyPlayerManager defaultManager].musicLists.count);
    return [MyPlayerManager defaultManager].musicLists.count - 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"11111");
    AlbumDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AlbumDetailModel *model = [MyPlayerManager defaultManager].musicLists[indexPath.row];
    [cell cellWithDetailModel:model];
    if (indexPath.row == [MyPlayerManager defaultManager].index) {
        cell.title.textColor = self.view.tintColor;
        cell.countL.textColor = self.view.tintColor;
        cell.time.textColor = self.view.tintColor;
        cell.byte.textColor = self.view.tintColor;
        cell.downLoad.hidden = YES;
    }else{
        cell.title.textColor = [UIColor whiteColor];
        cell.countL.textColor = [UIColor whiteColor];
        cell.time.textColor = [UIColor whiteColor];
        cell.byte.textColor = [UIColor whiteColor];
        cell.downLoad.hidden = YES;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailModel *model = [MyPlayerManager defaultManager].musicLists[indexPath.row];
    CGFloat heigth = [UILabel getHeightByWidth:kScreenWidth - 50 title:[NSString stringWithFormat:@"%@ %@",model.program_live_time,model.program_title] font:[UIFont systemFontOfSize:15.0]];
    return heigth + 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailModel *model = [MyPlayerManager defaultManager].musicLists[indexPath.row];
    model.isPlay = YES;
    
    AlbumDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.title.textColor = self.view.tintColor;
    cell.countL.textColor = self.view.tintColor;
    cell.time.textColor = self.view.tintColor;
    cell.byte.textColor = self.view.tintColor;
    
    [[LIveTimeManager shareInstance].player pause];
    [LIveTimeManager shareInstance].isPlay = NO;
    [MyPlayerManager defaultManager].isPlay = YES;
    [MyPlayerManager defaultManager].index = indexPath.row;
    [[MyPlayerManager defaultManager] changeMusicWith:indexPath.row];
    
    [MyPlayerManager defaultManager].dic[@"title"] = [NSString stringWithFormat:@"%@ %@",model.program_live_time,model.program_title];

}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AlbumDetailModel *model = self.modelArray[indexPath.row];
//    model.isPlay = NO;
    AlbumDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.title.textColor = [UIColor whiteColor];
    cell.countL.textColor = [UIColor whiteColor];
    cell.time.textColor = [UIColor whiteColor];
    cell.byte.textColor = [UIColor whiteColor];
}



- (void)relaData{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[MyPlayerManager defaultManager].index inSection:0] atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
    [self.tableView reloadData];
}











@end
