//
//  BrandCarSecondViewController.m
//  Product-B
//
//  Created by super on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandCarSecondViewController.h"
#import "BrandCarSecondModel.h"
#import "FilterHotTableViewCell.h"
#import "BrandMainSecondViewController.h"
#import "BrandViewController.h"
@interface BrandCarSecondViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *modelArray;

@end

@implementation BrandCarSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(W, 0, W/5*4, H - 104);
    
    //加阴影-
    self.view.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.view.layer.shadowOffset = CGSizeMake(-3,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.view.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.view.layer.shadowRadius = 3;//阴影半径，默认3
    // Do any additional setup after loading the view.
    
    
    
    [self createSegment];
    [self createTableView];
    [self requestData:self.myid t:@"1"];
    
}

#pragma mark  网络请求
- (void)requestData:(NSString *)myid t:(NSString *)t{
   NSString *url = [NSString stringWithFormat:@"http://223.99.255.20/cars.app.autohome.com.cn/cars_v5.8.0/cars/seriesprice-pm1-b%@-t%@.json",myid, t];
    NSLog(@"%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.modelArray = [BrandCarSecondModel modelJson:dic];
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
#pragma mark 创建segmentedControl
- (void)createSegment{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"在售", @"全部"]];
    self.segment.frame = CGRectMake(10, 10, self.view.frame.size.width - 20, 30);
    self.segment.selectedSegmentIndex = 0;
//    [segment insertSegmentWithTitle:@"在售" atIndex:0 animated:YES];
//    segment.momentary = NO; // 点击恢复原样
//    
//    segment.multipleTouchEnabled = YES;
//    segment.tintColor = [UIColor redColor];
    [self.segment addTarget:self action:@selector(selectButton:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.segment];
}

- (void)selectButton:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 1) {
        
        [self requestData:self.myid t:@"2"];
    }else{
        [self requestData:self.myid t:@"1"];
    }
    
}
#pragma mark 创建tableView
- (void)createTableView{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}
#pragma mark tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BrandCarSecondModel *model = self.modelArray[section];
    return model.serieslist.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    BrandCarSecondModel *model = self.modelArray[section];
    return model.name;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 复用了 筛选的cell
    FilterHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[FilterHotTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    BrandCarSecondModel *model = self.modelArray[indexPath.section];
    NSDictionary *dic = [model.serieslist objectAtIndex:indexPath.row];
    
    [cell BrandCarSecondDic:dic];
//    cell.textLabel.text = dic[@"name"];
//    cell.detailTextLabel.text = dic[@"price"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imgurl"]]];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 复用主打车的controller  （mainsecond）
    BrandMainSecondViewController *mainsecond = [[BrandMainSecondViewController alloc]init];
    
    BrandCarSecondModel *model = self.modelArray[indexPath.section];
    NSArray *array = model.serieslist;
    NSDictionary *dic = array[indexPath.row];
    mainsecond.seriesid = dic[@"id"];
    
    mainsecond.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:mainsecond animated:YES];
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
