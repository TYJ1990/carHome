//
//  CommonlViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "CommonlViewController.h"
#import "AdjustHeight.h"
#import "CarModel.h"
#import "CarTableViewCell.h"
#import "DetailsViewController.h"
@interface CommonlViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, strong) UILabel *rowcountL;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *itme;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation CommonlViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UILabel *)rowcountL {
    if (!_rowcountL) {
        _rowcountL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2.0 - 70, 10, 140, 20)];
        _rowcountL.textAlignment = NSTextAlignmentCenter;
        _rowcountL.alpha = 0.5;
        _rowcountL.font = [UIFont systemFontOfSize:12];
        
    }
    return _rowcountL;
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        if (_type == 0) {
            _segment = [[UISegmentedControl alloc] initWithItems:@[@"最后回复", @"最新发布", @"精华帖", @"质量反馈"]];
        } else {
            _segment = [[UISegmentedControl alloc] initWithItems:@[@"最后回复", @"最新发布", @"精华帖"]];
        }
        _segment.frame = CGRectMake(6, 2 * kNaviH - 35, kWidth - 12, 30);
        _segment.selectedSegmentIndex = 0;
        [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _segment;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 2 * kNaviH, kWidth, kHeight - 20 - 3 * kNaviH)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    if (_type == 0) {
        self.itme = @"btc";
    } else if (_type == 1) {
        self.itme = @"bta";
    } else {
        self.itme = @"bto";
    }
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.startIndex = 1;
    [self requestDataWithIndex:self.segment.selectedSegmentIndex];
    [self createTitleBarAndTabBar];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.startIndex = 1;
        [self requestDataWithIndex:self.segment.selectedSegmentIndex];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.startIndex += 1;
        [self requestDataWithIndex:self.segment.selectedSegmentIndex];
    }];
}

- (void)requestDataWithIndex:(NSInteger)index {
    
    NSString *url;
    switch (index) {
        case 0:
            url = [NSString stringWithFormat:@"http://clubnc.app.autohome.com.cn/club_v6.1.0/club/topics-pm1-b%@-%@-r0-ss0-o0-p%ld-s50-qf0-c0.json", _model.bbsid,self.itme, _startIndex];
            self.tableView.hidden = NO;
            break;
        case 1:
            self.tableView.hidden = YES;
            return;
            break;
        case 2:
            self.tableView.hidden = YES;
            return;
            break;
        case 3:
            self.tableView.hidden = YES;
            return;
            break;
            
        default:
            break;
    }
    
    [RequestManager requestWithUrlString:url requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.rowcountL.text = [NSString stringWithFormat:@"共%@帖", dic[@"result"][@"rowcount"]];
        NSString *totalCount = [NSString stringWithFormat:@"%@", dic[@"result"][@"pagecount"]];
        NSString *indexcount = [NSString stringWithFormat:@"%ld", self.startIndex - 1];
        if ([totalCount isEqualToString:indexcount]) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        
        if (self.startIndex == 1) {
            [self.array removeAllObjects];
        }
        
        NSArray *arr = [CarModel modelConfigureJsonDic:dic];
        for (CarModel *model in arr) {
            [self.array addObject:model];
        }
        [self.tableView reloadData];
        // 停止菊花
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } error:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
    
}

// 创建头尾栏
- (void)createTitleBarAndTabBar {
    UIView *dataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    dataView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:dataView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, 2 * kNaviH)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 2 * kNaviH, kWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.7;
    [view addSubview:line];
    
    UIButton *backBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBut.frame = CGRectMake(5, 10, 40, 20);
    [backBut setImage:[UIImage imageNamed:@"返回.png"] forState:(UIControlStateNormal)];
    [backBut addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:backBut];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 4.0, 10, kWidth / 2.0, 20)];
    titleL.textAlignment = NSTextAlignmentCenter;
    if (_type == 1) {
        titleL.text = [NSString stringWithFormat:@"%@论坛", self.model.bbsname];
    } else {
        titleL.text = self.model.bbsname;
    }
    [view addSubview:titleL];
    
    UIButton *searchBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    searchBut.frame = CGRectMake(kWidth - 35, 10, 20, 20);
    [searchBut setImage:[UIImage imageNamed:@"搜索.png"] forState:(UIControlStateNormal)];
    [searchBut addTarget:self action:@selector(searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:searchBut];
    
    [view addSubview:self.segment];
    
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - kNaviH, kWidth, kNaviH)];
    tabView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:tabView];
    [tabView addSubview:self.rowcountL];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.7;
    [tabView addSubview:lineView];
    
    UIButton *releaseBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    releaseBut.frame = CGRectMake(tabView.width - 25, 10, 20, 20);
    [releaseBut setImage:[UIImage imageNamed:@"编辑.png"] forState:(UIControlStateNormal)];
    [releaseBut addTarget:self action:@selector(releaseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [tabView addSubview:releaseBut];
    
    UIButton *collectBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    collectBut.frame = CGRectMake(tabView.width - 40 - 30, 5, 30, 30);
    [collectBut setImage:[UIImage imageNamed:@"收藏.png"] forState:(UIControlStateNormal)];
    [collectBut addTarget:self action:@selector(collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [tabView addSubview:collectBut];
    
}
#pragma mark 加载不同顺序
- (void)segmentAction:(UISegmentedControl *)sender {
    [self requestDataWithIndex:sender.selectedSegmentIndex];
}

#pragma mark 跳转搜索页面
- (void)searchAction:(UIButton *)sender {
    
    
}

#pragma mark 发表新帖
- (void)releaseAction:(UIButton *)sender {
    
}

#pragma mark 收藏论坛
- (void)collectAction:(UIButton *)sender {
    
}

#pragma mark 返回上级界面
- (void)backAction {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarModel *model = self.array[indexPath.row];
    if (model.jximgs.length != 0) {
        CGFloat h = [AdjustHeight adjustHeightByString:model.title width:kWidth - 10 font:17];
        return tableView.height / 7.0 * 2 + h;
    } else {
        CGFloat h = [AdjustHeight adjustHeightByString:model.title width:kWidth - 10 font:17];
        return tableView.height / 7.0 + h;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell cellConfigureModel:self.array[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarModel *model = self.array[indexPath.row];
    NSString *total = [NSString stringWithFormat:@"%@", model.replycounts];
    DetailsViewController *dvc = [[DetailsViewController alloc] init];
    dvc.topicid = model.topicid;
    dvc.totalNum = total;
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
