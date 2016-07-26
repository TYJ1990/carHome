//
//  FilterViewController.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "FilterViewController.h"
#import "FilterModel.h"
#import "FilterTableViewCell.h"
#import "FilterHotTableViewCell.h"
#import "BrandChooseSecondCell.h"
#import "BrandChooseSecondModel.h"

#import "FilterChooseModel.h"
#import "FilterChooseCell.h"

@interface FilterViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSString *URL;
@property (nonatomic, strong)NSMutableArray *modelArray;
@property (nonatomic, assign)BOOL isselect;
@property (nonatomic, strong)UIScrollView *scrow;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)NSString *chooseURL;
@property (nonatomic, assign)BOOL exchange;
@property (nonatomic, strong)NSMutableArray *choosemodelarray;
@property (nonatomic, strong)UIButton *okbutton;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    
    self.URL = @"http://cars.app.autohome.com.cn/cars_v5.8.0/cars/gethotseries-a2-pm1-v6.1.0-p1-s20.json";
    
    [self createTableView];
    [self requestData:self.URL];
    [self createUpView];
    [self createScrowView];

}
- (void)requestData:(NSString *)url{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"%@",url);
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if ([url isEqualToString:self.URL]) {
            self.modelArray = [FilterModel modelJson:dic];
            [self.tableV reloadData];

        }else{
            self.choosemodelarray = [FilterChooseModel modelJson:dic];
            [self.tableV reloadData];

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)createUpView{

    UIView * filterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
    filterView.backgroundColor = [UIColor whiteColor];
    filterView.alpha = 1;
    [self.view addSubview:filterView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W/2-25, 10, 50, 20)];
    [button setTitle:@"条件" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [filterView addSubview:button];
    
    UIView *hotView = [[UIView alloc]initWithFrame:CGRectMake(0, 41, W, 20)];
    hotView.backgroundColor = [UIColor whiteColor];
    hotView.alpha = 1;
    [self.view addSubview:hotView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    label.text = @"热门车系";
    label.textColor = [UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:13];
    [hotView addSubview:label];

    
    
}
- (void)buttonAction:(UIButton *)sender{
    
    self.isselect = !self.isselect;
    
    if (self.isselect == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            self.scrow.frame = CGRectMake(0, 40, W, 460);
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.scrow.frame = CGRectMake(0, 40, W, 0);
        }];
    }
    
}
- (void)createScrowView{
    
    self.scrow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, W, 0)];
    self.scrow.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1
];
    [self.view addSubview:self.scrow];
    
    NSArray *array = @[@"微型车",@"小型车",@"紧凑型车",@"中型车",@"大中型车",@"大型车",@"跑车",@"MPV",@"全部SUV",@"小型SUV",@"紧凑型suv",@"中型suv",@"中大型suv",@"大型suv",@"微面",@"微卡",@"轻客",@"皮卡"];
    
    for (int i = 0; i < 18; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i%3*W/3, i/3 * 50, W/3, 50)];
        [button setTitle:array[i] forState:(UIControlStateNormal)];
        if (i < 9) {
            
            button.tag = i+1;
        }else if (i >= 9 && i <=  13){
            button.tag = i + 7;
        }else{
            button.tag = i - 3;
        }
        
        [button.layer setBorderColor:[UIColor grayColor].CGColor];
        [button.layer setBorderWidth:0.3];
        [button setTitleColor:[UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1
                               ] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(chooseCar:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.scrow addSubview:button];
    }
    
    
    self.okbutton = [[UIButton alloc]initWithFrame:CGRectMake(20, 400, W-40, 40)];
    [self.okbutton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.okbutton addTarget:self action:@selector(okAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.okbutton.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1];
    [self.scrow addSubview:self.okbutton];
    
    self.array = [NSMutableArray array];
}
- (void)chooseCar:(UIButton *)sender{
    
    if (sender.selected == NO) {
        
        [self.array addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
    }else{
        [self.array removeObject:[NSString stringWithFormat:@"%ld",sender.tag]];
    }
    NSString *str = [self.array componentsJoinedByString:@","];
    NSLog(@"%@",str);
    
    self.chooseURL = [NSString stringWithFormat:@"http://223.99.255.20/cars.app.autohome.com.cn/cars_v5.8.0/cars/searchcars.ashx?a=2&pm=1&v=6.1.0&minp=0&maxp=0&levels=%@&cids=&gs=&sts=&dsc=&configs=&order=2&pindex=1&psize=20&bids=&fids=&drives=&seats=&attribute=",str];
    
    
    sender.selected = !sender.isSelected;

    [self.okbutton setTitle:[NSString stringWithFormat:@"已选%ld项  确定",self.array.count] forState:(UIControlStateNormal)];
    
}
- (void)okAction{
    
    
    self.isselect = NO;

    [UIView animateWithDuration:0.3 animations:^{
        self.scrow.frame = CGRectMake(0, 40, W, 0);
    }];
    
    self.exchange = YES;
    
    
    [self requestData:self.chooseURL];
    
    
    
}
- (void)createTableView{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 62, W,self.view.frame.size.height - 62 - 102) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.exchange == YES) {
        FilterChooseModel *model = self.choosemodelarray[section];
        
        return model.seriesitems.count;
    }else{
        
        return self.modelArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filter"];
    FilterHotTableViewCell *hotcell = [tableView dequeueReusableCellWithIdentifier:@"hotfilter"];
    
    FilterChooseCell *choosecell = [tableView dequeueReusableCellWithIdentifier:@"choosecell"];
    
    
    if (self.exchange == YES) {
        if (!choosecell) {
            choosecell = [[FilterChooseCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"choosecell"];
        }
        FilterChooseModel *model = self.choosemodelarray[indexPath.section];
        NSDictionary *dic = [model.seriesitems objectAtIndex:indexPath.row];
        [choosecell cellModel:dic];
        return choosecell;
        
    }else{
        

        if (indexPath.row < 3) {
            if (!hotcell) {
                hotcell = [[FilterHotTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"hotfilter"];
            }
            
            hotcell.selectionStyle =UITableViewCellSelectionStyleNone;
            [hotcell cellModel:self.modelArray[indexPath.row]];
            return hotcell;
            
        }else{
            if (!cell) {
                cell = [[FilterTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"filter"];
                
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            [cell cellModel:self.modelArray[indexPath.row]];
            return cell;
        }
        
        
        
        
    }
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.exchange == YES) {
        return 130;
    }else{
        
        return 80;
    }
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
