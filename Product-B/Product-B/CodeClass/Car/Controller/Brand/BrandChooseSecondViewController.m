//
//  BrandChooseSecondViewController.m
//  Product-B
//
//  Created by super on 16/7/23.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

#import "BrandChooseSecondViewController.h"
#import "BrandMainSecondViewController.h"
#import "BrandChooseSecondModel.h"

#import "BrandChooseSecondCell.h"
@interface BrandChooseSecondViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *modelArray;
@end

@implementation BrandChooseSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    [self request];
    [self createNavigationBarView];
    
//    tableView上面多出来20个像素，是因为自动布局的缘故，设置一下属性就可以解决问题
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
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
    [back setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
    [view addSubview:back];
    
    
    // 选项
    for (int i = 0; i < 2; i++) {
        
        UIButton *allPrice = [[UIButton alloc]initWithFrame:CGRectMake(i * W / 2, view.bottom, W/2, 39.7)];
        allPrice.backgroundColor = [UIColor whiteColor];
        [allPrice.layer setBorderColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1].CGColor];
        if (i == 0) {
            [allPrice setTitle:@"全部价格" forState:(UIControlStateNormal)];
        }else{
            [allPrice setTitle:@"关注高" forState:(UIControlStateNormal)];
        }
        allPrice.titleLabel.font = [UIFont systemFontOfSize:13];
        [allPrice setTitleColor:[UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1
                                 ] forState:(UIControlStateNormal)];
        [allPrice.layer setBorderWidth:0.3];
        [allPrice.layer setMasksToBounds:YES];
        [self.view addSubview:allPrice];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, view.bottom + 40, W, 20)];
    label.backgroundColor = [UIColor whiteColor];
    for (BrandChooseSecondModel *model in self.modelArray) {
        label.text = [NSString stringWithFormat:@"共%@个车系%@个车型", model.rowcount, model.totalspeccount];
    }
    label.tag = 1000;
    [self.view addSubview:label];
    
}
// 导航栏返回按钮
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)request{
    NSString *str = [NSString stringWithFormat:@"http://223.99.255.20/cars.app.autohome.com.cn/cars_v5.8.0/cars/getcarbymarks-a2-pm1-p1-s20-mak%@-o0-map0-mip0.json",self.value];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.modelArray = [BrandChooseSecondModel modelJson:dic];
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)createTableView{
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, W, H - 120) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrandChooseSecondCell *brandchoosesecond = [tableView dequeueReusableCellWithIdentifier:@"brandchoose"];
    if (!brandchoosesecond) {
        brandchoosesecond = [[BrandChooseSecondCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"brandchoose"];
    }
    BrandChooseSecondModel *model = self.modelArray[indexPath.section];
    NSDictionary *dic = [model.seriesitems objectAtIndex:indexPath.row];
    
    [brandchoosesecond cellModel:dic];
    
    return brandchoosesecond;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandMainSecondViewController *brandmain = [[BrandMainSecondViewController alloc]init];
    BrandChooseSecondModel *model = self.modelArray[indexPath.section];
    NSDictionary *dic = model.seriesitems[indexPath.row];
    brandmain.seriesid = [dic objectForKey:@"id"];
    [self.navigationController pushViewController:brandmain animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BrandChooseSecondModel *model = self.modelArray[section];
    
    return model.seriesitems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
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
