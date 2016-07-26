//
//  ListViewController.m
//  Product-B
//
//  Created by lanou on 16/7/24.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "ListViewController.h"
#import "LIveTimeManager.h"
#import "LiveListTableViewCell.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *graryView;

@end

@implementation ListViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _close = [UIButton buttonWithType:(UIButtonTypeSystem)];
    }
    return self;
}

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
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    title.text = @"节目单";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.graryView addSubview:title];
    
    [self createBtn];


    [self.view addSubview:self.tableView];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[LIveTimeManager shareInstance].index inSection:0] atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
    
    NSLog(@"666");
}








- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight/5.0 + 70, kScreenWidth, kScreenHeight*4/5.0 - 70 - 50) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"LiveListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        _tableView.rowHeight = 70;
    }
    return _tableView;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"1212");
    return [LIveTimeManager shareInstance].livetimeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    LiveModel *model = [LIveTimeManager shareInstance].livetimeArray[indexPath.row];
    if (self.isToday) {
        [cell cellWithDetailModel:model];
        [self changeColor:cell color:[UIColor whiteColor]];
        if (model.isTomorrow) {
            [cell.appointment setTitle:@"已预约" forState:(UIControlStateNormal)];
            [cell.appointment setTintColor:[UIColor grayColor]];
            [cell.appointment.layer setBorderColor:[UIColor grayColor].CGColor];
        }else {
            [cell.appointment setTitle:@"预约" forState:(UIControlStateNormal)];
            [cell.appointment setTintColor:[UIColor whiteColor]];
            [cell.appointment.layer setBorderColor:[UIColor whiteColor].CGColor];
        }
    }else{
        [cell cellWithDetailModel:model];
        if (indexPath.row < [LIveTimeManager shareInstance].index) {
            [self changeColor:cell color:[UIColor grayColor]];
        }else if (indexPath.row == [LIveTimeManager shareInstance].index){
            [self changeColor:cell color:self.view.tintColor];
        }else{
            [self changeColor:cell color:[UIColor whiteColor]];
        }
        if (model.isAppoint) {
            [cell.appointment setTitle:@"已预约" forState:(UIControlStateNormal)];
            [cell.appointment setTintColor:[UIColor grayColor]];
            [cell.appointment.layer setBorderColor:[UIColor grayColor].CGColor];
        }else if (!model.isAppoint && indexPath.row > [LIveTimeManager shareInstance].index){
            [cell.appointment setTitle:@"预约" forState:(UIControlStateNormal)];
            [cell.appointment setTintColor:[UIColor whiteColor]];
            [cell.appointment.layer setBorderColor:[UIColor whiteColor].CGColor];
        }
    }
    cell.appointment.tag = indexPath.row + 200;
    [cell.appointment addTarget:self action:@selector(appointmentAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}


- (void)createBtn{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 69, kScreenWidth, 1)];
    view.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    [self.graryView addSubview:view];
    
    self.today = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.today setTitle:@"今天" forState:(UIControlStateNormal)];
    [self.today setTintColor:[UIColor whiteColor]];
    self.today.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.today.frame = CGRectMake(0, 39, kScreenWidth/2.0, 30);
    [self.today addTarget:self action:@selector(todayAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.graryView addSubview:self.today];
    
    self.todayView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/4.0 - 20, 68, 40, 2)];
    self.todayView.backgroundColor = [UIColor whiteColor];
    [self.graryView addSubview:self.todayView];
    
    
    self.tomorrow = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.tomorrow setTitle:@"明天" forState:(UIControlStateNormal)];
    [self.tomorrow setTintColor:[UIColor whiteColor]];
    [self.tomorrow addTarget:self action:@selector(tomorrowAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.tomorrow.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.tomorrow.frame = CGRectMake(kScreenWidth/2.0, 39, kScreenWidth/2.0, 30);
    [self.graryView addSubview:self.tomorrow];
    
    self.tomorrowView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*3/4.0 - 20, 68, 40, 2)];
    self.tomorrowView.backgroundColor = [UIColor whiteColor];
    self.tomorrowView.hidden = YES;
    [self.graryView addSubview:self.tomorrowView];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight*4/5.0 - 50, kScreenWidth, 1)];
    view2.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    [self.graryView addSubview:view2];
    
    self.close = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.close.frame = CGRectMake(0, kScreenHeight*4/5.0 - 49, kScreenWidth, 49);
    self.close.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.close setTintColor:[UIColor whiteColor]];
    self.close.tag = 1024;
    self.close.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.close setTitle:@"关闭" forState:(UIControlStateNormal)];
    [self.graryView addSubview:self.close];
}



- (void)changeColor:(LiveListTableViewCell *)cell color:(UIColor *)color{
    cell.album.textColor = color;
    cell.time.textColor = color;
    cell.play.textColor = color;
    [cell.appointment setTintColor:color];
    cell.appointment.titleLabel.textColor = color;
    [cell.appointment.layer setBorderColor:color.CGColor];

}







- (void)todayAction:(UIButton *)btn{
    [self.today setTintColor:[UIColor whiteColor]];
    self.todayView.hidden = NO;
    
    [self.tomorrowView setTintColor:[UIColor lightGrayColor]];
    self.tomorrowView.hidden = YES;
    
    self.isToday = NO;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[LIveTimeManager shareInstance].index inSection:0] atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
    [self.tableView reloadData];
}

- (void)tomorrowAction:(UIButton *)btn{
    [self.today setTintColor:[UIColor lightGrayColor]];
    self.todayView.hidden = YES;
    
    [self.tomorrowView setTintColor:[UIColor whiteColor]];
    self.tomorrowView.hidden = NO;
    
    self.isToday = YES;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:NO];

    [self.tableView reloadData];
}


- (void)appointmentAction:(UIButton *)btn{
    NSInteger index = btn.tag - 200;
    LiveModel *model = [LIveTimeManager shareInstance].livetimeArray[index];
    [btn setTitle:@"已预约" forState:(UIControlStateNormal)];
    btn.titleLabel.textColor = [UIColor grayColor];
    [btn setTintColor:[UIColor grayColor]];
    [btn.layer setBorderColor:[UIColor grayColor].CGColor];
    if (self.isToday) {
        model.isTomorrow = YES;
    }else{
        model.isAppoint = YES;
    }
    
}





@end
