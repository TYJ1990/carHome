//
//  PriceViewController.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "PriceViewController.h"
#import "PriceModel.h"
#import "PriceTableViewCell.h"
@interface PriceViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSString *URL;
@property (nonatomic, strong)NSMutableArray *modelArray;
@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.URL = @"http://223.99.255.20/cars.app.autohome.com.cn/dealer_v6.0.0/dealer/pdspecs-pm1-pi0-c310100-o7-b0-ss0-sp0-p1-s20-l0-minp0-maxp0-lon121.294907-lat31.134041.json";
    
    [self requestData];
    [self createTableView];
    [self createUpView];
}

- (void)requestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.modelArray = [PriceModel modelJson:dic];
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)createUpView{
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 39)];
    upView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:upView];
    
    NSArray *array = @[@"品牌", @"价格", @"级别", @"排序", @"上海"];
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10 + 60 * i, 10, 50, 20)];
        [button setTitle:array[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i + 1;
        [button addTarget:self action:@selector(buAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [upView addSubview:button];
    }
}
- (void)buAction:(UIButton *)sender
{
    
}
- (void)createTableView{
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 144) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"price"];
    if (!cell) {
        cell = [[PriceTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"price"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;

    PriceModel *model = self.modelArray[indexPath.row];
    [cell cellModel:model];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
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
