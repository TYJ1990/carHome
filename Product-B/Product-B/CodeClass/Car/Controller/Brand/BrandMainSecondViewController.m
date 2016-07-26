//
//  BrandMainSecondViewController.m
//  Product-B
//
//  Created by super on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

#import "BrandMainSecondViewController.h"
#import "BrandMainSecondModel.h"
#import "BrandMainSecondTableModel.h"
#import "BrandMainSecondRecommendModel.h"
// cell
#import "BrandMainSecondOneCell.h"
#import "BrandMainSecondTwoCell.h"
#import "BrandMainSecondThreeCell.h"
#import "BrandMainSecondFourCell.h"
#import "BrandMainSecondFiveCell.h"
#import "BrandMainSecondSixCell.h"
#import "OnlyOne.h"
@interface BrandMainSecondViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>{
    UIImageView *_zoomImageView;
    UIImageView *_circleView;
    UILabel *_textLabel;
}
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)BrandMainSecondModel *brandSecondModel;
@property (nonatomic, strong)NSMutableArray *tableModelArray;
@property (nonatomic, strong)NSMutableArray *recommendModelArray;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *recommend;
@end

@implementation BrandMainSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createTableView];
    [self createNavigationBarView];
    self.url = [NSString stringWithFormat:@"http://223.99.255.20/cars.app.autohome.com.cn/carinfo_v6.0.0/cars/seriessummary-pm1-s%@-t-c310100.json", self.seriesid];
    // id 3615
    self.recommend = [NSString stringWithFormat:@"http://223.99.255.20/cars.app.autohome.com.cn/cars_v5.8.0/cars/seriesattentionseries.ashx?appid=2&seriesid=%@", self.seriesid];
    [self upImage:nil];

    [self request:self.url];
    [self request:self.recommend];
    
}

// 上面大图
- (void)upImage:(NSString*)url{
    
//    _zoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    _zoomImageView = [[UIImageView alloc]init];
//    [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    _zoomImageView.frame = CGRectMake(0, -200-20, self.view.frame.size.width, 220);
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    _zoomImageView.clipsToBounds = YES;
    [self.tableV addSubview:_zoomImageView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = _tableV.contentOffset.y + 60;
    if (y > -330) {
    
//        NSLog(@"%f",y);
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _zoomImageView.frame = frame;
        if (y > 0) {
            self.tableV.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
        }else{
            self.tableV.contentInset = UIEdgeInsetsMake(260, 0, 0, 0);
        }
        
    }else{
//        NSLog(@"%f",y);
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        _zoomImageView.frame = frame;
    }
}

// 创建导航栏
- (void)createNavigationBarView{
    
    // 毛边玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    effectview.frame = CGRectMake(0, 0, W, 60);
    [self.view addSubview:effectview];
    
    // 导航栏view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 60)];
    view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.5;
    [effectview addSubview:view];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 50, 20)];
    [back setTitle:@"返回" forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [back setTitleColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255 blue:255.0/255.0 alpha:1] forState:(UIControlStateNormal)];
    [view addSubview:back];
}
// 导航栏返回按钮
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
// 网络请求
- (void)request:(NSString *)url{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        // 最下面的推荐车系的数据
        if ([url isEqualToString:self.recommend]) {
            self.recommendModelArray = [BrandMainSecondRecommendModel modelJson:dic];
            
        }else{
            // result下第一层大字典 包含了本页所有数据
            self.brandSecondModel = [BrandMainSecondModel modelJson:dic];
            
            // 给头视图赋值 图片url
            [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:self.brandSecondModel.logo]];

            // result 下 key：enginelist (存tableview数据的数组)
            self.tableModelArray = [BrandMainSecondTableModel arrayjson:dic];

        }
        
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"aaa");
    }];
}
// 创建tableView
- (void)createTableView{
    
    self.tableV = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
//    self.tableV.backgroundColor = [UIColor yellowColor];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.contentInset = UIEdgeInsetsMake(200 + 60, 0, 0, 0);
    [self.view addSubview:self.tableV];
    self.tableV.tableFooterView = [[UIView alloc]init];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5 + self.tableModelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 1;
    }else if (section == 4 + self.tableModelArray.count){
        return 1;
    }else{
        // 如果是第5个section （在售车型）
        BrandMainSecondTableModel *model = self.tableModelArray[section - 4];
        
        return model.speclist.count;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 430;
    }else if (indexPath.section == 1){
        if (self.brandSecondModel.teambuyinginfo.count == 0) {
            return 0;
        }
        return 50;
    }else if (indexPath.section == 2){
        if (self.brandSecondModel.manyvictors.count == 0) {
            return 0;
        }
        return 100;
    }else if (indexPath.section == 3){
        if (self.brandSecondModel.spectype.count == 0) {
            return 0;
        }
        return 50;
    }else if (indexPath.section == 4 + self.tableModelArray.count){
        if (self.brandSecondModel.spectype.count == 0) {
            return 0;
        }
        return W/3*4/3 + 20;
    }else{
        if (self.brandSecondModel.enginelist.count == 0) {
            return 0;
        }
        return 150;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }else if (section == 1){
        if (self.brandSecondModel.teambuyinginfo.count == 0) {
            return 0;
        }
        return 10;
    }else if (section == 2){
        if (self.brandSecondModel.manyvictors.count == 0) {
            return 0;
        }
        return 10;
    }else if (section == 3){
        if (self.brandSecondModel.spectype.count == 0) {
            return 0;
        }
        return 10;
    }else if (section == 4 + self.tableModelArray.count){
        if (self.recommendModelArray.count == 0) {
            return 0;
        }
        return 20;
    }else{
        if (self.brandSecondModel.enginelist.count == 0) {
            return 0;
        }
        return 20;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BrandMainSecondOneCell *onecell = [tableView dequeueReusableCellWithIdentifier:@"one"];
    
    BrandMainSecondTwoCell *twocell = [tableView dequeueReusableCellWithIdentifier:@"two"];
        
    BrandMainSecondThreeCell *threecell = [tableView dequeueReusableCellWithIdentifier:@"three"];
    
    BrandMainSecondFourCell *fourcell = [tableView dequeueReusableCellWithIdentifier:@"four"];
    
    BrandMainSecondFiveCell *fivecell = [tableView dequeueReusableCellWithIdentifier:@"five"];
    
    BrandMainSecondSixCell *sixcell = [tableView dequeueReusableCellWithIdentifier:@"six"];
    
    if (indexPath.section == 0) {
        
        if (!onecell) {
            onecell = [[BrandMainSecondOneCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"one"];
        }
        
        [onecell cellModel:self.brandSecondModel];
        return onecell;

    }else if (indexPath.section == 1){
        if (!twocell) {
            twocell = [[BrandMainSecondTwoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"two"];
        }
//        NSDictionary *dic = self.brandSecondModel.teambuyinginfo;
//        twocell.textLabel.text = dic[@"title"];
        [twocell cellModel:self.brandSecondModel];
        return twocell;
        
    }else if (indexPath.section == 2){
        if (!threecell) {
            threecell = [[BrandMainSecondThreeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"three"];
        }
        
        [threecell cellModel:self.brandSecondModel];
        return threecell;
        
    }else if (indexPath.section == 3){
        if (!fourcell) {
            fourcell = [[BrandMainSecondFourCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"four"];
        }
        [fourcell cellModel:self.brandSecondModel];
        
        for (int i = 0; i < self.brandSecondModel.spectype.count; i++) {
            UIButton *button = [fourcell.contentView viewWithTag:i + 100];

            if ([OnlyOne shareInstance].index == i) {
                [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];

            }else{
                [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            }
            
            [button addTarget:self action:@selector(fourCellButton:) forControlEvents:(UIControlEventTouchUpInside)];
        }
    
        return fourcell;
        
    }else if (indexPath.section == 4 + self.tableModelArray.count){
        if (!sixcell) {
            sixcell = [[BrandMainSecondSixCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"six"];
        }
        
        [sixcell cellModelArray:self.recommendModelArray];
        return sixcell;
        
    }else{
        if (!fivecell) {
            fivecell = [[BrandMainSecondFiveCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"five"];
        }
//        NSLog(@"----%f",fivecell.frame.size.width);
//        fivecell.backgroundColor = [UIColor redColor];
        BrandMainSecondTableModel *model = self.tableModelArray[indexPath.section-4];
        NSDictionary *dic = [model.speclist objectAtIndex:indexPath.row];
        [fivecell cellModel:dic];
        return fivecell;
    };
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 10)];
    view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    
    
    if (section >= 4 && section < 4 + self.tableModelArray.count) {
        BrandMainSecondTableModel *model = self.tableModelArray[section - 4];

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, W - 10, 20)];
        label.text = model.name;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
    }
    
    
    return view;
}

- (void)fourCellButton:(UIButton *)sender{
    

        [OnlyOne shareInstance].index = sender.tag - 100;

    
    NSDictionary *dic = self.brandSecondModel.spectype[sender.tag - 100];
    
    NSString *string = [NSString stringWithFormat:@"http://223.99.255.20/cars.app.autohome.com.cn/carinfo_v6.0.0/cars/seriessummary-pm1-s%@-t%@-c310100.json", self.seriesid, dic[@"value"]];
    NSLog(@"%@",string);
    [self request:string];
    
//    if (sender.tag) {
        [sender setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];

//    }else{
//        [sender setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
//    }
    
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
