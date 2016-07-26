//
//  BrandViewController.m
//  Product-B
//
//  Created by super on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height


#import "BrandViewController.h"
#import "CustomButton.h"
// cell
#import "BrandTableViewCell.h"
#import "BrandHotTableViewCell.h"
#import "BrandMainCarTableViewCell.h"
#import "BrandChooseCarTableViewCell.h"
#import "BrandCarTableViewCell.h"
// model
#import "BrandHotModel.h"
#import "BrandMainModel.h"
#import "BrandChooseModel.h"
#import "BrandCarModel.h"
// controller
#import "BrandCarSecondViewController.h"
#import "BrandMainSecondViewController.h"
#import "BrandChooseSecondViewController.h"
#import "CustomView.h"
@interface BrandViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *BrandHotModelArray;
@property (nonatomic, strong)NSMutableArray *BrandMainModelArray;
@property (nonatomic, strong)NSMutableArray *BrandChooseModelArray;
@property (nonatomic, strong)NSMutableArray *BrandCarModelArray;
@property (nonatomic, strong)NSMutableArray *sectionArray;
@property (nonatomic, strong)NSString *Hoturl;
@property (nonatomic, strong)NSString *mainurl;
@property (nonatomic, strong)NSString *chooseurl;
@property (nonatomic, strong)NSString *carurl;
// 抽屉
@property (nonatomic, strong)CustomView *customView;
@property (nonatomic, assign)CGPoint openPointCenter;
@property (nonatomic, assign)CGPoint closePointCenter;

@property (nonatomic, strong)BrandCarSecondViewController *brandCarSecond;
@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    self.Hoturl = @"http://cars.app.autohome.com.cn/dealer_v6.0.0/dealer/hotbrands-pm1.json";
    self.mainurl = @"http://adnewnc.app.autohome.com.cn/autov5.7.0/ad/infoad.ashx?appid=2&platform=1&version=6.1.0&networkid=0&adtype=1&provinceid=0&lng=0.000000&lat=0.000000&pageindex=1&deviceid=cfdcddd20332d4ad40deea075438e18004771dc0&idfa=FDA917EF-BF2C-4F87-A49E-81DE31077108&devicebrand=apple&devicemodel=iPhone&gps_city=0&pageid=cfdcddd20332d4ad40deea075438e18004771dc01468299031600&isretry=0";
    self.chooseurl = @"http://cars.app.autohome.com.cn/cars_v5.8.0/cars/getmarks-a2-pm1.json";
    
    self.carurl = @"http://app.api.autohome.com.cn/autov4.2.5/cars/brands-a2-pm1-v4.2.5-ts0.html";
    
    [self requestData:self.Hoturl];
    [self requestData:self.mainurl];
    [self requestData:self.chooseurl];
    [self requestData:self.carurl];
    [self createTableView];
    
    
//    self.tabBarController.tabBar.hidden = YES;
    
    

}
// 手势方法
- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    float x = self.brandCarSecond.view.center.x + translation.x;
    if (x < self.view.center.x) {
        x = self.view.center.x;
    }
    self.brandCarSecond.view.center = CGPointMake(x, self.openPointCenter.y);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
            if (x > self.openPointCenter.x - 70) {
                self.brandCarSecond.view.center = self.openPointCenter;
            }else{
                self.view.center = CGPointMake(self.openPointCenter.x - 200, self.openPointCenter.y);
            }
        }];
    }
    [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer{
    [UIView animateWithDuration:0.2 animations:^{
        self.brandCarSecond.view.center = CGPointMake(self.openPointCenter.x - 220, self.openPointCenter.y);
    }];
}
//  tableview
- (void)createTableView{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, H) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}
#pragma mark 网络请求

- (void)requestData:(NSString *)url{
    
    
    AFHTTPSessionManager *Hotmanager = [AFHTTPSessionManager manager];
    Hotmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [Hotmanager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // 热门品牌接口 传dic到相应model
        if ([url isEqualToString:self.Hoturl]) {
            self.BrandHotModelArray = [BrandHotModel modelJson:dic];
            
            // 主打车接口 传dic到相应model
        }else if ([url isEqualToString:self.mainurl]){
            self.BrandMainModelArray = [BrandMainModel modelJson:dic];
            
            // 选车接口
        }else if ([url
                   isEqualToString:self.chooseurl]){
            self.BrandChooseModelArray = [BrandChooseModel modelJson:dic];
            
            
            // 找车接口
        }else if ([url isEqualToString:self.carurl]){
            self.BrandCarModelArray = [BrandCarModel modelJson:dic];
            
            
        }
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

#pragma mark -  代理方法  Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.BrandCarModelArray.count + 4;
}
#pragma mark  row 个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 1;
    }else{
        BrandCarModel *model = self.BrandCarModelArray[section - 4];
        return model.list.count;
    }
}

#pragma mark  cellforrow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BrandHotTableViewCell *HotCell = [tableView dequeueReusableCellWithIdentifier:@"hot"];
    HotCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BrandMainCarTableViewCell *mainCarCell = [tableView dequeueReusableCellWithIdentifier:@"maincar"];
    mainCarCell.selectionStyle = UITableViewCellSelectionStyleNone;

    BrandChooseCarTableViewCell *choose = [tableView dequeueReusableCellWithIdentifier:@"choose"];
    choose.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BrandCarTableViewCell *car = [tableView dequeueReusableCellWithIdentifier:@"car"];
    
    // 第一个section
    if (indexPath.section == 0) {
        if (!cell) {
            cell = [[BrandTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        }
        return cell;
        
        // 第二个热门汽车section
    }else if (indexPath.section == 1){
        if (!HotCell) {
            HotCell = [[BrandHotTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"hot"];
        }
        // 传递数据到cell
        [HotCell cellModelArray:self.BrandHotModelArray];
        // 按钮点击方法
        for (int i = 0; i < self.BrandHotModelArray.count; i++) {
            CustomButton *bu = [HotCell.contentView viewWithTag:i + 1];
            [bu addTarget: self action:@selector(bu:)
         forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        
        return HotCell;
        
        // 第三个主打车section
    }else if (indexPath.section == 2){
        if (!mainCarCell) {
            mainCarCell = [[BrandMainCarTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"maincar"];
        }
        
        [mainCarCell cellModel:self.BrandMainModelArray];
        
        for (int i = 0; i < self.BrandMainModelArray.count; i++) {
            CustomButton *button = [mainCarCell.contentView viewWithTag:i + 1];
            [button addTarget:self action:@selector(mainCarAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        return mainCarCell;
        
        // 第四个选车section
    }else if (indexPath.section == 3){
        if (!choose) {
            choose = [[BrandChooseCarTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"choose"];
        }
        [choose cellModelArray:self.BrandChooseModelArray];

        BrandChooseModel *model = self.BrandChooseModelArray[0];
        for (int i = 0; i < model.list.count; i++) {
           UIButton* button = [choose.contentView viewWithTag:i + 100];
            [button addTarget:self action:@selector(chooseButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        return choose;
    }
    // 第五个tableview
    else {
        if (!car) {
            car = [[BrandCarTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"car"];
            
        }
        
        // tableView赋值
        BrandCarModel *model = self.BrandCarModelArray[indexPath.section- 4];
        NSDictionary *dic = [model.list objectAtIndex:indexPath.row];
        
        [car cellDic:dic];
        
        return car;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >= 4) {
        
        BrandCarModel *model = self.BrandCarModelArray[indexPath.section - 4];
        NSDictionary *dic = [model.list objectAtIndex:indexPath.row];
        
        
        // 刚开始还没有创建，所以都是0
        if (self.customView.frame.origin.x == W/5) {
            NSLog(@"shuaxin");
            
            self.brandCarSecond.myid = [dic objectForKey:@"id"];
            [self.brandCarSecond requestData:[dic objectForKey:@"id"]t:@"1"];
            self.brandCarSecond.segment.selectedSegmentIndex = 0;


            return;
        }
        
        // 初始化second
        self.brandCarSecond = [[BrandCarSecondViewController alloc]init];
        self.brandCarSecond.myid = [dic objectForKey:@"id"];
        NSLog(@"=====%@",[dic objectForKey:@"id"]);
        self.brandCarSecond.segment.selectedSegmentIndex = 0;
        self.brandCarSecond.view.frame = CGRectMake(0, 0, W/5*4, H - 104);
        
            [self addChildViewController:self.brandCarSecond];
        //    [self.view addSubview:self.brandCarSecond.view];
        
#pragma mark 抽屉自定义view
        self.customView = [[CustomView alloc]initWithView:self.brandCarSecond.view parentView:self.view];
        self.customView.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:self.customView];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.customView.center = CGPointMake(W/5*3, self.brandCarSecond.view.center.y);

        }];

    }else{

    }
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1){
        return 140;
    }else if (indexPath.section == 2){
        return 110;
    }else if (indexPath.section == 3){
        return 70;
    }else {
        return 50;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section != 0) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *smallview = [[UIView alloc]initWithFrame:CGRectMake(10, 39, self.view.frame.size.width - 20, 1)];
        smallview.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        [view addSubview:smallview];
        
        UIView *Upview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
        Upview.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        [view addSubview:Upview];
        
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 20)];
        label.textColor = [UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:13];
        //    label.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:83.0/255.0 blue:83.0/255.0 alpha:1];
        [view addSubview:label];
        if (section == 1) {
            label.text = @"热门品牌";
        }else if (section == 2){
            label.text = @"主打车";
        }else if (section == 3){
            label.text = @"选车神器";
        }else{
            BrandCarModel *model = self.BrandCarModelArray[section - 4];
            
            label.text = model.letter;
            
            
        }
        return view;
        
    }
    return 0;
}
#pragma mark 右侧选择边栏
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *array = [@[@"☆",@"热",@"主",@"选"]mutableCopy];
    for (BrandCarModel *model in self.BrandCarModelArray) {
        [array addObject:model.letter];
    }
    
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    return array;
}

#pragma mark  热门品牌 按钮点击
- (void)bu:(CustomButton *)sender{
    
    BrandHotModel *model = self.BrandHotModelArray[sender.tag - 1];
    
// 刚开始还没有创建，所以都是0
    if (self.customView.frame.origin.x == W/5) {
        NSLog(@"shuaxin");

        NSLog(@"%@",self.brandCarSecond.myid);
        self.brandCarSecond.myid = model.myid;
        self.brandCarSecond.segment.selectedSegmentIndex = 0;
        [self.brandCarSecond requestData:model.myid t:@"1"];
        
        return;
    }
    
    // 初始化second
    self.brandCarSecond = [[BrandCarSecondViewController alloc]init];

    self.brandCarSecond.myid = model.myid;
    self.brandCarSecond.view.frame = CGRectMake(0, 0, W/5*4, H - 104);
    
    [self addChildViewController:self.brandCarSecond];
//    [self.view addSubview:self.brandCarSecond.view];
    
#pragma mark 抽屉自定义view
    self.customView = [[CustomView alloc]initWithView:self.brandCarSecond.view parentView:self.view];
    self.customView.backgroundColor = [UIColor redColor];

    [self.view addSubview:self.customView];
    
    [UIView animateWithDuration:0.3 animations:^{

        self.customView.center = CGPointMake(W/5*3, self.brandCarSecond.view.center.y);
        
    }];
    
}
#pragma mark 主打车点击方法
- (void)mainCarAction:(CustomButton *)sender{
    
    BrandMainSecondViewController *brandMain = [[BrandMainSecondViewController alloc]init];
    
//    for (int i = 0; i < self.BrandMainModelArray.count; i++) {
        BrandMainModel *model = self.BrandMainModelArray[sender.tag - 1];
        brandMain.seriesid = model.seriesid;
    NSLog(@"%@",model.seriesid);
//    }
    brandMain.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:brandMain animated:YES];
    
}
#pragma mark  选车神器点击方法
- (void)chooseButtonAction:(UIButton*)sender{
    BrandChooseSecondViewController *brandchooseSecond = [[BrandChooseSecondViewController alloc]init];
    NSLog(@"%ld",sender.tag);
    BrandChooseModel *model = self.BrandChooseModelArray[0];
    NSDictionary *dic = model.list[sender.tag - 100];
    brandchooseSecond.value = [dic objectForKey:@"value"];
    brandchooseSecond.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:brandchooseSecond animated:YES];
    
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
