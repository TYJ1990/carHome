//
//  DetailViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "NewsflashViewController.h"
#import "NewsflashModel.h"
#import "NesflashDetailTableViewCell.h"
#import "HeadView.h"
#import "AuthViewController.h"

@interface NewsflashViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *collection;
@property(nonatomic,strong)UIButton *share;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)UIImageView *topView;
@property(nonatomic,strong)HeadView *headView;

@end

@implementation NewsflashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -400, kScreenWidth, 600)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.35;
    [self.tableView insertSubview:view atIndex:1];
    [self.tableView insertSubview:self.topView atIndex:1];
    [self.view addSubview:self.tableView];
    [self creatUI];
    [self loadData];
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 44) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"NesflashDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
    }
    return _tableView;
}

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (HeadView *)headView{
    if (!_headView) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil] firstObject];
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

- (UIImageView *)topView{
    if (!_topView) {
        _topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -100, kScreenWidth, 300)];
        _topView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _topView;
}

#pragma mark -   导航栏控件
- (void)creatUI{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 25, 40, 30)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [self.view addSubview:view];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(10, 5, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"返回2"] forState:(UIControlStateNormal)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:backBtn];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 45, 25, 40, 30)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.5;
    [self.view addSubview:view2];
    UIButton *share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    share.frame = CGRectMake(10, 5, 20, 20);
    [share setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    share.backgroundColor = [UIColor clearColor];
    [share setTintColor:[UIColor whiteColor]];
    [share addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view2 addSubview:share];
    
}

- (void)creatHeadView:(NSDictionary *)dic{
    self.headView.frame = CGRectMake(0, -100, kScreenWidth, 280);
    self.headView.title.text = dic[@"result"][@"newsdata"][@"title"];
    self.headView.authName.text = dic[@"result"][@"newsdata"][@"newsauthor"];
    self.headView.replayCount.text = [NSString stringWithFormat:@"%@人浏览",dic[@"result"][@"newsdata"][@"reviewcount"]];
    self.headView.carname.text = @"帝豪GL";
    self.headView.carprice.text = @"11.98 - 22.98万";
    [self.headView.carPic sd_setImageWithURL:[NSURL URLWithString:self.model.img]];
    self.tableView.tableHeaderView = self.headView;
    [self.topView sd_setImageWithURL:[NSURL URLWithString:dic[@"result"][@"newsdata"][@"img"]]];
}

- (void)loadData{
    if (self.model.id) {
        self.newsid = self.model.id;
    } else{
        self.newsid = self.model.newsid;
    }
    
    [RequestManager requestWithUrlString:[NSString stringWithFormat:@"http://223.99.255.20/newsnc.app.autohome.com.cn/fastnews_v5.9.5/content/News/fastnewscontent-n%@-lastid0-o0.json",self.newsid] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [NewsflashModel ModelConfigureJsonDic:dic];
        [self creatHeadView:dic];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}





#pragma mark - 导航栏button 方法
- (void)backAction{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionAction:(UIButton *)btn{
}

- (void)shareAction:(UIButton *)btn{
}

- (void)authDetail:(UITapGestureRecognizer *)tap{
    AuthViewController *auth = [[AuthViewController alloc] init];
    NesflashDetailTableViewCell *cell = (NesflashDetailTableViewCell *)tap.view.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NewsflashModel *model = self.modelArray[indexPath.row];
    auth.blogUrl = model.blogurl;
    auth.name = model.authorname;
    [self.navigationController pushViewController:auth animated:YES];
}


#pragma mark - tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NesflashDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsflashModel *model = self.modelArray[indexPath.row];
    [cell cellWithNewsflashModel:model];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(authDetail:)];
    [cell.authorname addGestureRecognizer:tap];
    [cell.headimg addGestureRecognizer:tap];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsflashModel *model = self.modelArray[indexPath.row];
    CGFloat h1 = [UILabel getHeightByWidth:kScreenWidth - 20 title:model.content font:[UIFont systemFontOfSize:17.0]];
    CGFloat h2 = [UILabel getHeightByWidth:kScreenWidth - 61 title:model.content1 font:[UIFont systemFontOfSize:14.0]];
    CGFloat h3 = [UILabel getHeightByWidth:kScreenWidth - 61 title:model.content2 font:[UIFont systemFontOfSize:14.0]];
    CGFloat h4 = [UILabel getHeightByWidth:kScreenWidth - 61 title:model.content3 font:[UIFont systemFontOfSize:14.0]];
    
    return h1 + h2 + h3 + h4 + model.attachments.count * (kScreenWidth*5/7.0 + 10) + 350;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat down = -60 - scrollView.contentOffset.y;
    if (down < 0) {
        return;
    }
    CGRect frame = self.topView.frame;
    frame.origin.y = -100 - down;
    frame.size.height = 300 + down/2.0 ;// 系数 5 决定速度
    self.topView.frame = frame;
}




@end
