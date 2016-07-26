//
//  FoundViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "FoundViewController.h"
#import "FoundModel.h"
#import "SmallModel.h"
#import "LikeAndIntroduceTableViewCell.h"
#import "ListTableViewCell.h"
#import "MyButton.h"
#import "ListCarTableViewCell.h"
#import "MallViewController.h"
#import "CarMusicViewController.h"

@interface FoundViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *tableModelArray;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)FoundModel *topViewModel;

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"发现";
    
    [self loadCarousData];
    [self loadViewData];
    [self loadTableViewData];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - 属性 -------------------
- (NSMutableArray *)tableModelArray{
    if (!_tableModelArray) {
        _tableModelArray = [NSMutableArray array];
    }
    return _tableModelArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"LikeAndIntroduceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"likeCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"ListCarTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"listCell"];
        _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    return _tableView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 71)];
    }
    return _topView;
}







#pragma mark - 网络请求-----------------
// 轮播图
- (void)loadCarousData{
    [RequestManager requestWithUrlString:kCarousURL requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSMutableArray *array = [FoundModel modelCarousConfigureJsonDic:dic];
        [self creatCarousWithArray:array];
    } error:^(NSError *error) {
        NSLog(@"000000");
    }];
}

// 上部分视图
-(void)loadViewData{
    [RequestManager requestWithUrlString:kTopViewURL requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.topViewModel = [FoundModel modelTopViewConfigureJsonDic:dic];
        [self creatTopView:self.topViewModel];
    } error:^(NSError *error) {
        
    }];
}

// tableView
- (void)loadTableViewData{
    [RequestManager requestWithUrlString:kTableViewURL requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.tableModelArray = [FoundModel modelTableViewConfigureJsonDic:dic];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}






#pragma mark - 创建轮播图 -------------------
- (void)creatCarousWithArray:(NSArray *)imagesArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (FoundModel *model in imagesArray) {
        [arr addObject:model.imgurl];
    }
    CarouselView *carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/3.0 - 10) imageURLs:arr];
    [self.topView addSubview:carouselView];
    __weak FoundViewController *weakSelf = self;
    carouselView.imageClick = ^(NSInteger index){
        
        MallViewController *mallVC = [[MallViewController alloc] init];
        FoundModel *model = imagesArray[index];
        mallVC.url = model.url;
        [weakSelf.navigationController pushViewController:mallVC animated:YES];
    };
}




#pragma mark - 创建上部分三个视图 -----------------
- (void)creatTopView:(FoundModel *)model{
    
    NSArray *array = model.functionlistArray;
    int width = (kScreenWidth - 100)/5.0;
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth/3.0 - 10, kScreenWidth, width*12/5.0 + 30)];
    grayView.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:grayView];
    for (int i = 0; i < 10; i++) {
        MyButton *btn = [[MyButton alloc] initWithFrame:CGRectMake(10 + (i % 5) * (width + 20), 10 + (i / 5) * (10 + width*6/5.0), width, width*6/5.0)];
        btn.tag = 1000 + i;
        SmallModel *smallModel = array[i];
        [btn.imageV sd_setImageWithURL:[NSURL URLWithString:smallModel.iconurl]];
        btn.label.text = smallModel.title;
        btn.label.textColor = [UIColor grayColor];
        btn.label.font = [UIFont systemFontOfSize:11.0];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [grayView addSubview:btn];
    }
    
    
    NSArray *imageads = model.imageadsArray;
    UIView *grayView2 = [[UIView alloc] initWithFrame:CGRectMake(0, grayView.bottom + 10, kScreenWidth, (kScreenWidth - 42)*2/9.0 + 50)];
    grayView2.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:grayView2];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    titleL.text = model.title;
    titleL.font = [UIFont systemFontOfSize:16.0];
    titleL.textColor = [UIColor grayColor];
    [grayView2 addSubview:titleL];
    UIButton *moreBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    moreBtn.frame = CGRectMake(kScreenWidth - 80 , titleL.top - 1, 80, 20);
    [moreBtn setTitle:@"更多活动" forState:(UIControlStateNormal)];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    moreBtn.tintColor = [UIColor lightGrayColor];
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [grayView2 addSubview:moreBtn];
    
    for (int i = 0; i < imageads.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activityTap:)];
        SmallModel *smallModel = imageads[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * ((kScreenWidth - 42)/3.0 + 11), titleL.bottom + 10, (kScreenWidth - 42)/3.0, (kScreenWidth - 42)*2/9.0)];
        imageView.image = [UIImage imageNamed:@"shipinbg"];
        imageView.tag = 500 + i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:smallModel.imgurl]];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        [grayView2 addSubview:imageView];
    }
    
    for (int i = 0; i < 2; i++) {
        UIImageView *viticalView = [[UIImageView alloc] initWithFrame:CGRectMake(5 +  (10 + (kScreenWidth - 42)/3.0) * (i + 1) , titleL.bottom + 10, 0.6, (kScreenWidth - 42)*2/9.0)];
        viticalView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [grayView2 addSubview:viticalView];
    }
    
    
    
    NSArray *activitylist = model.activitylistArray;
    for (int i = 0; i < activitylist.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activityTap:)];
        SmallModel *smallModel = activitylist[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, grayView2.bottom + 10 + kScreenWidth / 5.0 * i, kScreenWidth,kScreenWidth / 5.0)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"shipinbg"];
        imageView.tag = 2000 + i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:smallModel.imgurl]];
        [imageView addGestureRecognizer:tap];
        [self.topView addSubview:imageView];
    }
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, self.topView.frame.size.height - (2 - activitylist.count) * kScreenWidth / 5.0);
    self.tableView.tableHeaderView = self.topView;
}




#pragma mark - tableView代理方法 --------------------

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableModelArray.count > 0) {
        NSArray*arr = self.tableModelArray[section];
        if (section == 2) {
            return arr.count;
        }
        return 1;
        
    }else{
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = self.tableModelArray[indexPath.section];
    if (indexPath.section == 2) {
        ListCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
        SmallModel *model = array[indexPath.row];
        [cell cellWithModel:model];
        return cell;
    }else{
        LikeAndIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"likeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellWithModel:array];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellAction:)];
        [cell addGestureRecognizer:tap];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        NSArray *arr = self.tableModelArray[indexPath.section];
        SmallModel *model = arr[indexPath.row];
        MallViewController *mallVC = [[MallViewController alloc] init];
        mallVC.url = model.murl;
        [self.navigationController pushViewController:mallVC animated:YES];
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, kScreenWidth, 32)];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor grayColor];
    if (section == 2) {
        label.text = @"  商品列表";
    }else if (section == 1){
        label.text = @"  为你推荐";
    } else {
        label.text = @"  猜你喜欢";
    }
    [view addSubview:label];
    return view;
}



- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 110;
    }else{
        return kScreenHeight - 104;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}




#pragma mark - btn跳转的方法 =-------------
-(void)btnAction:(UIButton *)btn{
    NSArray *array = self.topViewModel.functionlistArray;
    NSInteger index = btn.tag - 1000;
    SmallModel *model = array[index];
    if (index == 0) {
        CarMusicViewController *carMusicVC = [[CarMusicViewController alloc] init];
        [self.navigationController pushViewController:carMusicVC animated:YES];
        
        
    }else{
        MallViewController *mallVC = [[MallViewController alloc] init];
        mallVC.url = model.url;
        [self.navigationController pushViewController:mallVC animated:YES];
    }
}

- (void)moreBtnAction:(UIButton *)btn{
    MallViewController *mallVC = [[MallViewController alloc] init];
    mallVC.url = self.topViewModel.moreactivitysurl;
    [self.navigationController pushViewController:mallVC animated:YES];

}

- (void)activityTap:(UITapGestureRecognizer *)tap{
    NSArray *array = self.topViewModel.imageadsArray;
    NSArray *ActivityArray = self.topViewModel.activitylistArray;
    SmallModel *model;
    if (tap.view.tag > 1000) {
        NSInteger index = tap.view.tag - 2000;
        model = ActivityArray[index];
    }else{
        NSInteger index = tap.view.tag - 500;
        model = array[index];
    }
    MallViewController *mallVC = [[MallViewController alloc] init];
    mallVC.url = model.url;
    [self.navigationController pushViewController:mallVC animated:YES];
}

- (void)cellAction:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:tap.view];
    NSIndexPath *path = [self.tableView indexPathForCell:(LikeAndIntroduceTableViewCell *)tap.view];
    MallViewController *mallVC = [[MallViewController alloc] init];
    SmallModel *model;
    if (path.section == 1) {
        NSArray *introduce = self.tableModelArray[1];
        if (point.x < kScreenWidth/2.0 && point.y < kScreenHeight/2.0 - 52) {
            model = introduce[0];
        }else if(point.x > kScreenWidth/2.0 && point.y < kScreenHeight/2.0 - 52){
            model = introduce[1];
        } else if (point.x > kScreenWidth/2.0 && point.y > kScreenHeight/2.0 - 52){
            model = introduce[3];
        }else if (point.x < kScreenWidth/2.0 && point.y > kScreenHeight/2.0 - 52 ){
            model = introduce[2];
        }
    }else{
        NSArray *activity = self.tableModelArray[0];
        if (point.x < kScreenWidth/2.0 && point.y < kScreenHeight/2.0 - 52) {
            model = activity[0];
        }else if(point.x > kScreenWidth/2.0 && point.y < kScreenHeight/2.0 - 52){
            model = activity[1];
        } else if (point.x > kScreenWidth/2.0 && point.y > kScreenHeight/2.0 - 52){
            model = activity[3];
        }else if (point.x < kScreenWidth/2.0 && point.y > kScreenHeight/2.0 - 52){
            model = activity[2];
        }
    }
    mallVC.url = model.murl;
    [self.navigationController pushViewController:mallVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}



@end
