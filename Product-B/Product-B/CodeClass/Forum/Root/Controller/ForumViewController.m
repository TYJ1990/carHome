//
//  ForumViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#define kContentUrl @"http://club.app.autohome.com.cn/club_v5.6.0/club/jingxuantopic-pm1-c0-p1-s30.json"
#define kCarsUrl @"http://club.app.autohome.com.cn/club_v6.1.0/club/clubsseries-pm1-st635870541536899236.json"
#define kRegionUrl @"http://club.app.autohome.com.cn/club_v6.1.0/club/clubsarea-pm1-st635700482153179437.json"
#define kThemeUrl @"http://club.app.autohome.com.cn/club_v6.1.0/club/clubstheme-pm1-st635700482153179437.json"

#import "ForumViewController.h"
#import "WonderfulModel.h"
#import "WonCollectionViewCell.h"
#import "WonContentModel.h"
#import "WonContentTableViewCell.h"
#import "DetailsViewController.h"
#import "PostsModel.h"
#import "PostsTableViewCell.h"
#import "ListTableViewCell.h"
#import "CommonModel.h"
#import "CommonTableViewCell.h"
#import "CarsModel.h"
#import "RTModel.h"
#import "ComListTableViewCell.h"
#import "CommonlViewController.h"
#import "AdjustHeight.h"
@interface ForumViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *wonderfulBut;
@property (nonatomic, strong) UIButton *postsBut;
@property (nonatomic, strong) UIButton *commonBut;
@property (nonatomic, strong) UIButton *searchBut;
@property (nonatomic, strong) NSMutableArray *wonArray;
@property (nonatomic, strong) NSMutableArray *contentArr;
@property (nonatomic, strong) NSMutableArray *postsArr;
@property (nonatomic, strong) NSMutableArray *commonArr;
@property (nonatomic, strong) NSMutableDictionary *carsDic;
@property (nonatomic, strong) NSMutableDictionary *RTDic;
@property (nonatomic, strong) NSMutableArray *RTArr;
@property (nonatomic, strong) NSMutableArray *carsHeadArr;
@property (nonatomic, strong) NSMutableArray *regionHeadArr;
@property (nonatomic, strong) NSMutableArray *carArr;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *wonTableView;
@property (nonatomic, strong) UITableView *postsTableView;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UITableView *commonTableView;
@property (nonatomic, strong) UITableView *comListTableView;
@property (nonatomic, assign) NSInteger typeID;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger postsIndex;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) UIView *carView;
@property (nonatomic, strong) NSIndexPath *onIndexPath;
@property (nonatomic, strong) UILabel *titleL;
@end

@implementation ForumViewController
#pragma mark 懒加载
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)postsArr {
    if (!_postsArr) {
        _postsArr = [NSMutableArray array];
    }
    return _postsArr;
}

- (NSMutableArray *)contentArr {
    if (!_contentArr) {
        _contentArr = [NSMutableArray array];
    }
    return _contentArr;
}

- (NSMutableArray *)wonArray {
    if (!_wonArray) {
        _wonArray = [NSMutableArray array];
        
    }
    return _wonArray;
}

- (NSMutableArray *)commonArr {
    if (!_commonArr) {
        _commonArr = [NSMutableArray array];
        NSArray *arr1 = @[@"车系论坛.png", @"地区论坛.png", @"主题论坛.png"];
        NSArray *arr2 = @[@"车系论坛", @"地区论坛", @"主题论坛"];
        NSArray *arr3 = @[@"为你的爱车找队伍", @"老乡见老乡，两眼泪汪汪", @"兴趣爱好的聚集地"];
        for (int i = 0; i < 3; i++) {
            CommonModel *model = [[CommonModel alloc] init];
            model.image = arr1[i];
            model.bbsname = arr2[i];
            model.introduce = arr3[i];
            [_commonArr addObject:model];
        }
    }
    return _commonArr;
}

- (NSMutableDictionary *)carsDic {
    if (!_carsDic) {
        _carsDic = [NSMutableDictionary dictionary];
    }
    return _carsDic;
}

- (NSMutableDictionary *)RTDic {
    if (!_RTDic) {
        _RTDic = [NSMutableDictionary dictionary];
    }
    return _RTDic;
}

- (NSMutableArray *)RTArr {
    if (!_RTArr) {
        _RTArr = [NSMutableArray array];
    }
    return _RTArr;
}

- (NSMutableArray *)carsHeadArr {
    if (!_carsHeadArr) {
        _carsHeadArr = [NSMutableArray array];
    }
    return _carsHeadArr;
}

- (NSMutableArray *)regionHeadArr {
    if (!_regionHeadArr) {
        _regionHeadArr = [NSMutableArray array];
    }
    return _regionHeadArr;
}

- (NSMutableArray *)carArr {
    if (!_carArr) {
        _carArr = [NSMutableArray array];
    }
    return _carArr;
}

- (UIButton *)wonderfulBut {
    if (!_wonderfulBut) {
        _wonderfulBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _wonderfulBut.frame = CGRectMake(5, 5, 80, 30);
        _wonderfulBut.tag = 1;
        [_wonderfulBut setTitle:@"精选推荐" forState:(UIControlStateNormal)];
        [_wonderfulBut setTintColor:self.view.tintColor];
        [_wonderfulBut addTarget:self action:@selector(buttonAciton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _wonderfulBut;
}

- (UIButton *)postsBut {
    if (!_postsBut) {
        _postsBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _postsBut.frame = CGRectMake(100, 5, 40, 30);
        _postsBut.tag = 2;
        [_postsBut setTitle:@"热帖" forState:(UIControlStateNormal)];
        [_postsBut setTintColor:[UIColor grayColor]];
        [_postsBut addTarget:self action:@selector(buttonAciton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _postsBut;
}

- (UIButton *)commonBut {
    if (!_commonBut) {
        _commonBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _commonBut.frame = CGRectMake(155, 5, 80, 30);
        _commonBut.tag = 3;
        [_commonBut setTitle:@"常用论坛" forState:(UIControlStateNormal)];
        [_commonBut setTintColor:[UIColor grayColor]];
        [_commonBut addTarget:self action:@selector(buttonAciton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _commonBut;
}

- (UIButton *)searchBut {
    if (!_searchBut) {
        _searchBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _searchBut.frame = CGRectMake(kWidth - 35, 10, 20, 20);
        [_searchBut setImage:[UIImage imageNamed:@"搜索.png"] forState:(UIControlStateNormal)];
        [_searchBut addTarget:self action:@selector(searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _searchBut;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, kNaviH - 3, 70, 3)];
        _lineView.backgroundColor = self.view.tintColor;
    }
    return _lineView;
}

- (UIView *)transparentView {
    if (!_transparentView) {
        _transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kHeight - 20)];
        _transparentView.backgroundColor = [UIColor grayColor];
        _transparentView.hidden = YES;
        _transparentView.alpha = 0.7;
        _transparentView.tag = 201;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_transparentView addGestureRecognizer:tap];
    }
    return _transparentView;
}

- (UIView *)listView {
    if (!_listView) {
        _listView = [[UIView alloc] initWithFrame:CGRectMake(kWidth + 1, 20, 1, kHeight - 20)];
        _listView.backgroundColor = [UIColor whiteColor];
        _listView.tag = 202;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth / 5.0 * 4, kNaviH)];
        view.backgroundColor = [UIColor whiteColor];
        [_listView addSubview:view];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNaviH - 1, kWidth / 5.0 * 4, 1)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.7;
        [view addSubview:line];
        
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth / 5.0 * 4, kNaviH)];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.alpha = 0.7;
        
        [view addSubview:_titleL];
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = CGRectMake(view.frame.size.width - 50, 0, 40, 40);
        [button setTitle:@"关闭" forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(takeBackListView:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        
        
    }
    return _listView;
}

- (UIView *)carView {
    if (!_carView) {
        _carView = [[UIView alloc] initWithFrame:CGRectMake(kWidth + 1, 20, 1, kHeight - 20)];
        _carView.backgroundColor = [UIColor whiteColor];
        _carView.tag = 203;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth / 5.0 * 4, kNaviH)];
        view.backgroundColor = [UIColor whiteColor];
        [_carView addSubview:view];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNaviH - 1, kWidth / 5.0 * 4, 1)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.7;
        [view addSubview:line];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth / 5.0 * 4, kNaviH)];
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 0.7;
        label.text = @"车系论坛";
        
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.tag = 11;
        button.frame = CGRectMake(view.frame.size.width - 50, 0, 40, 40);
        [button setTitle:@"关闭" forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(takeBackListView:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        
        UIButton *back = [UIButton buttonWithType:(UIButtonTypeSystem)];
        back.frame = CGRectMake(10, 0, 40, 40);
        [back setTitle:@"返回" forState:(UIControlStateNormal)];
        [back addTarget:self action:@selector(goBackToListView) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:back];
    }
    return _carView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.transparentView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.listView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.carView];
    [self requestCollectionViewData];
    [self createTabBar];
    [self createScrollView];
    [self createWonderfulView];
    [self createListTableView];
    [self createCommonTableView];
    [self createTopPosts];
    [self createComListTableView];
    
    [self.listView addSubview:self.comListTableView];
#pragma mark 上拉刷新下拉加载
    self.typeID = 0;
    self.index = 1;
    [self requestTableViewData];
    self.wonTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self requestTableViewData];
    }];
    
    self.wonTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.index += 1;
        [self requestTableViewData];
    }];
    
    self.postsIndex = 1;
    [self requestDataWithPosts];
    self.postsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.postsIndex = 1;
        [self requestDataWithPosts];
    }];
    
    self.postsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.postsIndex += 1;
        [self requestDataWithPosts];
    }];
    [self.listView addSubview:self.listTableView];
}

#pragma mark 精选推荐
- (void)createWonderfulView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 50;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 20);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth - 20, kNaviH) collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.scrollView addSubview:self.collectionView];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kWidth - kNaviH, 0, kNaviH, kNaviH)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.scrollView addSubview:view];
    
    UIButton *allBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    allBut.frame = CGRectMake(11, 11, 18, 18);
    [allBut setImage:[UIImage imageNamed:@"四方框.png"] forState:(UIControlStateNormal)];
    [allBut addTarget:self action:@selector(allButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:allBut];
    
    _wonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviH, kWidth, kHeight - (20 + 2 * kNaviH) - 44)];
    _wonTableView.delegate = self;
    _wonTableView.dataSource = self;
    _wonTableView.tag = 100;
//    _wonTableView.rowHeight = (kHeight - (20 + 2 * kNaviH) - 44)/6;
    [self.scrollView addSubview:_wonTableView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNaviH - 1, kWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:line];
    
    [self.collectionView registerClass:[WonCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.wonTableView registerNib:[UINib nibWithNibName:@"WonContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"tcell"];

}

#pragma mark 热帖 
- (void)createTopPosts {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kWidth, 150, 50, 50)];
    view.backgroundColor = [UIColor orangeColor];
    [self.scrollView addSubview:view];
    
    
    self.postsTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight - (20 + kNaviH) - 44)];
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    self.postsTableView.tag = 101;
//    self.postsTableView.rowHeight = (kHeight - (20 + 2 * kNaviH) - 44)/6;
    [self.scrollView addSubview:self.postsTableView];
    [self.postsTableView registerNib:[UINib nibWithNibName:@"PostsTableViewCell" bundle:nil] forCellReuseIdentifier:@"postscell"];
}

#pragma mark 常用论坛
- (void)createCommonTableView {
    self.commonTableView = [[UITableView alloc] initWithFrame:CGRectMake(2 * kWidth, 0, kWidth, kHeight - 20 - kNaviH - 44)];
    self.commonTableView.delegate = self;
    self.commonTableView.dataSource = self;
    self.commonTableView.tag = 103;
    self.commonTableView.bounces = NO;
    [self.scrollView addSubview:_commonTableView];
    [self.commonTableView registerNib:[UINib nibWithNibName:@"CommonTableViewCell" bundle:nil] forCellReuseIdentifier:@"comcell"];
}

#pragma mark 栏目列表页面
- (void)createListTableView {
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviH, kWidth / 5.0 * 4, kHeight - kNaviH)];

    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.bounces = NO;
    self.listTableView.tag = 102;
    [self.listTableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listcell"];
}

#pragma mark 论坛列表页面
- (void)createComListTableView {
    self.comListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviH, kWidth / 5.0 * 4, kHeight - 40 - 20)];
    self.comListTableView.delegate = self;
    self.comListTableView.dataSource = self;
    self.comListTableView.bounces = NO;
//    self.comListTableView.tag = 104;
    
    self.comListTableView.hidden = YES;
    [self.comListTableView registerClass:[ComListTableViewCell class] forCellReuseIdentifier:@"CLcell"];
}

#pragma mark 收回滚轮列表方法
- (void)takeBackListView:(UIButton *)sender {
    _transparentView.hidden = YES;
    
    if (sender.tag == 11) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];// 动画执行时间
        [UIView setAnimationRepeatCount:1];// 动画的执行次数
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        self.listView.frame = CGRectMake(kWidth + 1, 20, 1, kHeight - 20);
        self.carView.frame = CGRectMake(kWidth + 1, 20, 1, kHeight - 20);
        // 动画提交
        [UIView commitAnimations];
    }  else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];// 动画执行时间
        [UIView setAnimationRepeatCount:1];// 动画的执行次数
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        self.listView.frame = CGRectMake(kWidth + 1, 20, 1, kHeight - 20);
        // 动画提交
        [UIView commitAnimations];
    }
}
// 回到上级滚轮列表
- (void)goBackToListView {
    self.comListTableView.tag = 104;
    [self.listView addSubview:self.comListTableView];
    [self requestDataWithBBSIndex:0];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];// 动画执行时间
    [UIView setAnimationRepeatCount:1];// 动画的执行次数
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    self.carView.frame = CGRectMake(kWidth + 1, 20, 1, kHeight - 20);
    // 动画提交
    [UIView commitAnimations];
}
// 详细汽车
- (void)launchCarViewModel:(CarsModel *)model {
    self.comListTableView.tag = 107;
    NSArray *array = model.seriesclub;
    [self.carArr removeAllObjects];
    for (NSDictionary *dic in array) {
        RTModel *model = [[RTModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.carArr addObject:model];
    }
    [self.carView addSubview:self.comListTableView];
    [self.comListTableView reloadData];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];// 动画执行时间
    [UIView setAnimationRepeatCount:1];// 动画的执行次数
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    self.carView.frame = CGRectMake(kWidth / 5.0, 20, kWidth / 5.0 * 4, kHeight - 20);
    // 动画提交
    [UIView commitAnimations];
}

#pragma mark 弹出滚轮列表方法
- (void)launchListView:(NSInteger)index {
    NSLog(@"index = %ld", index);
    switch (index) {
        case 0:
            self.listTableView.hidden = NO;
            self.comListTableView.hidden = YES;
            self.titleL.text = @"栏目分类";
            break;
        case 1:
            self.comListTableView.hidden = NO;
            self.comListTableView.tag = 104;
            self.titleL.text = @"车系论坛";
            self.listTableView.hidden = YES;
            [self requestDataWithBBSIndex:index - 1];
            break;
        case 2:
            self.comListTableView.hidden = NO;
            self.comListTableView.tag = 105;
            self.titleL.text = @"地区论坛";
            self.listTableView.hidden = YES;
            [self requestDataWithBBSIndex:index - 1];
            break;
        case 3:
            self.comListTableView.hidden = NO;
            self.comListTableView.tag = 106;
            self.titleL.text = @"主题论坛";
            self.listTableView.hidden = YES;
            [self requestDataWithBBSIndex:index - 1];
            break;
            
        default:
            break;
    }
    NSLog(@"tag = %ld", self.comListTableView.tag);
    
    _transparentView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];// 动画执行时间
    [UIView setAnimationRepeatCount:1];// 动画的执行次数
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    self.listView.frame = CGRectMake(kWidth / 5.0, 20, kWidth / 5.0 * 4, kHeight - 20);
    // 动画提交
    [UIView commitAnimations];
}

#pragma mark 滚轮选取
- (void)allButAction {
    [self launchListView:0];
}
#pragma mark 手势点击回收选取
- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self takeBackListView:nil];
}


#pragma mark 标题栏
- (void)createTabBar {
    
    UIView *stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    stateView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:stateView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kNaviH)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNaviH + 19, kWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    [view addSubview:self.wonderfulBut];
    [view addSubview:self.postsBut];
    [view addSubview:self.commonBut];
    [view addSubview:self.searchBut];
    [view addSubview:self.lineView];

}
#pragma mark 主页
- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNaviH + 20, kWidth, kHeight - kNaviH - 20)];
    _scrollView.contentSize = CGSizeMake(kWidth * 3, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
}
#pragma mark scrollView 代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = _scrollView.contentOffset.x / kWidth;
    [self moveTheSubscriptWith:index];
    [self selectWith:index];
    
}

- (void)buttonAciton:(UIButton *)sender {
    [self moveTheSubscriptWith:sender.tag - 1];
    [self selectWith:sender.tag - 1];
  
}
// 更加移动或者点击 button tableView
- (void)selectWith:(NSInteger)index {
    
    switch (index) {
        case 0:
            [_wonderfulBut setTintColor:self.view.tintColor];
            [_postsBut setTintColor:[UIColor grayColor]];
            [_commonBut setTintColor:[UIColor grayColor]];
            self.scrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
            [_wonderfulBut setTintColor:[UIColor grayColor]];
            [_postsBut setTintColor:self.view.tintColor];
            [_commonBut setTintColor:[UIColor grayColor]];
            self.scrollView.contentOffset = CGPointMake(kWidth, 0);
            break;
        case 2:
            [_wonderfulBut setTintColor:[UIColor grayColor]];
            [_postsBut setTintColor:[UIColor grayColor]];
            [_commonBut setTintColor:self.view.tintColor];
            self.scrollView.contentOffset = CGPointMake(2 * kWidth, 0);
            break;
            
        default:
            break;
    }
}

// 下标线
- (void)moveTheSubscriptWith:(NSInteger)index {
    
    switch (index) {
        case 0:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];// 动画执行时间
            [UIView setAnimationRepeatCount:1];// 动画的执行次数
            [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
            self.lineView.frame = CGRectMake(10, kNaviH - 3, 70, 3);
            // 动画提交
            [UIView commitAnimations];
            break;
        case 1:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];// 动画执行时间
            [UIView setAnimationRepeatCount:1];// 动画的执行次数
            [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
            self.lineView.frame = CGRectMake(100, kNaviH - 3, 40, 3);
            // 动画提交
            [UIView commitAnimations];
            break;
        case 2:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];// 动画执行时间
            [UIView setAnimationRepeatCount:1];// 动画的执行次数
            [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
            self.lineView.frame = CGRectMake(160, kNaviH - 3, 70, 3);
            // 动画提交
            [UIView commitAnimations];
            break;
        default:
            break;
    }
    
}

#pragma mark 跳转搜索页面
- (void)searchAction:(UIButton *)sender {
    
}

#pragma mark collectionView的数据请求
- (void)requestCollectionViewData {
    [RequestManager requestWithUrlString:kTotalUrl requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.wonArray = [WonderfulModel modelconfigureJsonDic:dic];
        [self.listTableView reloadData];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

#pragma mark tableview数据请求
- (void)requestTableViewData {
    
    NSString *url = [NSString stringWithFormat:@"http://club.app.autohome.com.cn/club_v5.6.0/club/jingxuantopic-pm1-c%ld-p%ld-s30.json", self.typeID, self.index];
    [RequestManager requestWithUrlString:url requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSString *totalCount = [NSString stringWithFormat:@"%@", dic[@"result"][@"pagecount"]];
        NSString *indexCount = [NSString stringWithFormat:@"%ld", self.index - 1];
        if ([totalCount isEqualToString:indexCount]) {
            [self.wonTableView.mj_footer endRefreshing];
            return;
        }
        
        if (self.index == 1) {
            [self.contentArr removeAllObjects];
        }
        NSArray *array = [WonContentModel modelConfigureJsonDic:dic];
        for (WonContentModel *model in array) {
            [self.contentArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.wonTableView reloadData];
        });
        
        [self.wonTableView.mj_header endRefreshing];
        [self.wonTableView.mj_footer endRefreshing];
        
        
    } error:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
    
}

#pragma mark 热帖数据请求
- (void)requestDataWithPosts {
    
    NSString *postsUrl = [NSString stringWithFormat:@"http://club.app.autohome.com.cn/club_v6.1.0/club/shotfoumlist-pm1-p%ld-s50.json", self.postsIndex];
    
    [RequestManager requestWithUrlString:postsUrl requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSString *totalCount = [NSString stringWithFormat:@"%ld", [dic[@"result"][@"rowcount"] integerValue] / 50 + 1];
        NSString *indexCount = [NSString stringWithFormat:@"%ld", self.postsIndex - 1];
        if ([totalCount isEqualToString:indexCount]) {
            [self.postsTableView.mj_footer endRefreshing];
            return;
        }
        
        if (self.postsIndex == 1) {
            [self.postsArr removeAllObjects];
        }
        
        NSArray *array = [PostsModel modelConfigureJsonDic:dic];
        for (PostsModel *model in array) {
            [self.postsArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.postsTableView reloadData];
        });
        
        [self.postsTableView.mj_header endRefreshing];
        [self.postsTableView.mj_footer endRefreshing];
    } error:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
    
}
#pragma mark 论坛数据请求
- (void)requestDataWithBBSIndex:(NSInteger)index {
//    NSLog(@"论坛数据请求 = %ld", index);
//    [self createComListTableView];
    
    NSString *url;
    switch (index) {
        case 0:
            url = kCarsUrl;
            break;
        case 1:
            url = kRegionUrl;
            break;
        case 2:
            url = kThemeUrl;
            break;
        default:
            break;
    }
    
    [RequestManager requestWithUrlString:url requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (index == 0) {
            [self.carsDic removeAllObjects];
            self.carsDic = [CarsModel modelConfigureJsonDic:dic];
            if (self.carsHeadArr.count == 0) {
//                [self.carsHeadArr removeAllObjects];
                NSArray *result = [[self.carsDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
                self.carsHeadArr = (NSMutableArray *)result;
            }
        } else {
            [self.RTArr removeAllObjects];
            [self.carsDic removeAllObjects];
            if (index == 1) {
                self.RTDic = [RTModel modelConfigureDic:dic];
                if (self.regionHeadArr.count == 0) {
                    [self.regionHeadArr removeAllObjects];
                    NSArray *arr = [[self.RTDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
                    self.regionHeadArr = (NSMutableArray *)arr;
                }
            } else {
                self.RTArr = [RTModel modelConfigureJsonDic:dic];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.comListTableView reloadData];
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.comListTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
        });
        
    } error:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
    
    
}


#pragma mark tableview的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (tableView.tag - 100) {
        case 0:
            return self.contentArr.count;
            break;
        case 1:
            return self.postsArr.count;
            break;
        case 2:
            return self.wonArray.count;
            break;
        case 3:
            return self.commonArr.count;
            break;
        case 4:
            if (tableView.tag == 104) {
                NSString *key = self.carsHeadArr[section];
                NSArray *arr = self.carsDic[key];
                return arr.count;
            }
            break;
        case 5:
            if (tableView.tag == 105) {
                NSString *key = self.regionHeadArr[section];
                NSArray *arr = self.RTDic[key];
                return arr.count;
            }
            break;
        case 6:
            return self.RTArr.count;
            break;
        case 7:
            return self.carArr.count;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.wonTableView]) {
       WonContentModel *model = self.contentArr[indexPath.row];
       CGFloat h = [AdjustHeight adjustHeightByString:model.title width:kWidth - 16 - 92 font:16];
        return tableView.height / 6 - 20 + h;
    } else if ([tableView isEqual:self.postsTableView]) {
        PostsModel *model = self.postsArr[indexPath.row];
        CGFloat h = [AdjustHeight adjustHeightByString:model.title width:kWidth - 16 font:16];
        return tableView.height / 7.0 - 20 + h;
    } else if ([tableView isEqual:self.listTableView]) {
        return (kHeight - kNaviH) / 11;
    } else if ([tableView isEqual:self.commonTableView]) {
        return 60;
    } else if ([tableView isEqual:self.comListTableView]) {
        
        if (tableView.tag == 104) {
            return tableView.height / 13.0 / 5 * 6;
        } else {
            return tableView.height / 13.0;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 104) {
        return self.carsHeadArr.count;
    } else if (tableView.tag == 105) {
        return self.regionHeadArr.count;
    }
    return 1;
}

// 分组标题栏
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.postsTableView]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20 + kNaviH, kWidth, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = @"  24小时内热门";
        return label;
    } else if ([tableView isEqual:self.comListTableView]) {
        
        if (self.comListTableView.tag == 104) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth / 5.0 * 4, 20)];
            view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];;
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kWidth / 5.0 * 4, 15)];
            titleL.backgroundColor = [UIColor whiteColor];
            titleL.text = self.carsHeadArr[section];
            
            [view addSubview:titleL];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 19, kWidth / 5.0 * 4, 1)];
            line.alpha = 0.6;
            line.backgroundColor = [UIColor grayColor];
            [view addSubview:line];
            
            return view;
        } else if (self.comListTableView.tag == 105) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth / 5.0 * 4, 20)];
            view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];;
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kWidth / 5.0 * 4, 15)];
            titleL.backgroundColor = [UIColor whiteColor];
            titleL.text = self.regionHeadArr[section];
            [view addSubview:titleL];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 19, kWidth / 5.0 * 4, 1)];
            line.alpha = 0.6;
            line.backgroundColor = [UIColor grayColor];
            [view addSubview:line];
            return view;
        }
        
        return nil;
    }
    
    return nil;
    
}
// 标题头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.postsTableView]) {
        return 20;
    } else if ([tableView isEqual:self.comListTableView]) {
        switch (self.comListTableView.tag - 104) {
            case 0:
                return 20;
                break;
            case 1:
                return 20;
                break;
            case 2:
                return 0;
                break;
                
            default:
                break;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([tableView isEqual:self.wonTableView]) {
        WonContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tcell" forIndexPath:indexPath];
        WonContentModel *model = self.contentArr[indexPath.row];
        
        [cell cellConfigureModel:model];
        return cell;
    } else if ([tableView isEqual:self.postsTableView]) {
        PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postscell" forIndexPath:indexPath];
        [cell cellConfigureModel:self.postsArr[indexPath.row]];
        return cell;
    } else if ([tableView isEqual:self.listTableView]) {
        ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell" forIndexPath:indexPath];
        WonderfulModel *model = self.wonArray[indexPath.row];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            model.isSelect = YES;
        });
        [cell cellConfigureModel:model];
        return cell;
    } else if ([tableView isEqual:self.commonTableView]) {
        CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comcell" forIndexPath:indexPath];
        [cell cellConfigureModel:self.commonArr[indexPath.row]];
        return cell;
    } else if ([tableView isEqual:self.comListTableView]) {
        ComListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLcell" forIndexPath:indexPath];
        if (tableView.tag == 104) {
            NSArray *arr = self.carsDic[_carsHeadArr[indexPath.section]];
            [cell cellConfigureCarsModel:arr[indexPath.row]];
            return cell;
        } else if (tableView.tag == 105) {
            NSArray *arr = self.RTDic[_regionHeadArr[indexPath.section]];
            [cell cellConfigureRTModel:arr[indexPath.row]];
            return cell;
        } else if (tableView.tag == 106) {
            [cell cellConfigureRTModel:self.RTArr[indexPath.row]];
            return cell;
        } else {
            
            [cell cellConfigureRTModel:self.carArr[indexPath.row]];
            return cell;
        }
    }
    return nil;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView.tag == 104) {
        return self.carsHeadArr;
    } else if (tableView.tag == 105) {
        return self.regionHeadArr;
    } else {
        return nil;
    }
}
// 索引条点击
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    
//}

#pragma mark 点击tableViewCell跳转详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
    
    if ([tableView isEqual:self.wonTableView]) {
        WonContentModel *model = self.contentArr[indexPath.row];
        detailsVC.topicid = model.topicid;
        detailsVC.totalNum = model.replycounts;
        [self.navigationController pushViewController:detailsVC animated:YES];
        return;
    } else if ([tableView isEqual:self.postsTableView]) {
        PostsModel *model = self.postsArr[indexPath.row];
        detailsVC.topicid = model.topicid;
        detailsVC.totalNum = model.replycounts;
        [self.navigationController pushViewController:detailsVC animated:YES];
        return;
    } else if ([tableView isEqual:self.listTableView]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            WonderfulModel *model = self.wonArray[0];
            model.isSelect = NO;
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath, nil] withRowAnimation:(UITableViewRowAnimationNone)];
        });
        
        [self takeBackListView:nil];
        ListTableViewCell *cell = (ListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.columnL.textColor = self.view.tintColor;
        cell.imageV.hidden = NO;
        WonderfulModel *model = self.wonArray[indexPath.row];
        model.isSelect = YES;
        self.typeID = [model.value integerValue];
        self.index = 1;
        [self.contentArr removeAllObjects];
        [self.wonTableView.mj_header beginRefreshing];
        [self requestTableViewData];
        // onIndexPath不为空刷新上一个被选中和当前被选中collectionViewCell
        if (self.onIndexPath != nil) {
            if (_onIndexPath != indexPath) {
                ListTableViewCell *cell = (ListTableViewCell *)[tableView cellForRowAtIndexPath:_onIndexPath];
                cell.columnL.textColor = [UIColor grayColor];
                cell.imageV.hidden = YES;
                WonderfulModel *model = self.wonArray[_onIndexPath.row];
                model.isSelect = NO;
                
                [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:_onIndexPath, indexPath,nil]];
            }
        } else {
            // onIndexPath为空 则刷新指定2个collectionViewCell
            NSIndexPath *setPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:setPath, indexPath, nil]];
        }
        _onIndexPath = indexPath;
    } else if ([tableView isEqual:self.commonTableView]) {
        [self launchListView:indexPath.row + 1];
    } else {
        if (tableView.tag == 104) {
            NSString *key = self.carsHeadArr[indexPath.section];
            CarsModel *model = self.carsDic[key][indexPath.row];
            [self launchCarViewModel:model];
        } else if (tableView.tag == 105) {
            [self takeBackListView:nil];
            
            NSString *key = self.regionHeadArr[indexPath.section];
            RTModel *model = self.RTDic[key][indexPath.row];
            CommonlViewController *cvc = [[CommonlViewController alloc] init];
            cvc.model = model;
            cvc.type = 1;
            [self.navigationController pushViewController:cvc animated:YES];
        } else if (tableView.tag == 106) {
            [self takeBackListView:nil];
            RTModel *model = self.RTArr[indexPath.row];
            CommonlViewController *cvc = [[CommonlViewController alloc] init];
            cvc.model = model;
            cvc.type = 2;
            [self.navigationController pushViewController:cvc animated:YES];
        } else {
            [self takeBackListView:nil];
            [self goBackToListView];
            RTModel *model = self.carArr[indexPath.row];
            CommonlViewController *cvc = [[CommonlViewController alloc] init];
            cvc.model = model;
            cvc.type = 0;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cvc animated:YES];
        }
    }
    

}

#pragma mark 精选collectionView代理方法实现
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.wonArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WonderfulModel *model = self.wonArray[indexPath.row];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model.isSelect = YES;
    });
    [cell cellConfigureModel:model];
    
    return cell;
}



#pragma mark 选中collectionViewCell 字体变蓝
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        WonderfulModel *model = self.wonArray[0];
        model.isSelect = NO;
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexpath, nil]];
    });
    
    WonCollectionViewCell *cell = (WonCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.nameL.textColor = self.view.tintColor;
    WonderfulModel *model = self.wonArray[indexPath.row];
    model.isSelect = YES;
    self.typeID = [model.value integerValue];
    self.index = 1;
    [self.contentArr removeAllObjects];
    [self.wonTableView.mj_header beginRefreshing];
    [self requestTableViewData];
    
    // onIndexPath不为空刷新上一个被选中和当前被选中tableViewCell
    if (self.onIndexPath != nil) {
        if (_onIndexPath != indexPath) {
            WonCollectionViewCell *cell = (WonCollectionViewCell *)[collectionView cellForItemAtIndexPath:_onIndexPath];
            cell.nameL.textColor = [UIColor grayColor];
            WonderfulModel *model = self.wonArray[_onIndexPath.row];
            model.isSelect = NO;
            [self.listTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_onIndexPath, indexPath, nil] withRowAnimation:(UITableViewRowAnimationNone)];
        }
        
    } else {
        // onIndexPath为空 则刷新指定2个tableViewCell
        NSIndexPath *setPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.listTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:setPath, indexPath, nil] withRowAnimation:(UITableViewRowAnimationNone)];
    }
    
    _onIndexPath = indexPath;
    
}

#pragma mark 动态加载item的宽度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    WonderfulModel *model = self.wonArray[indexPath.row];
    CGFloat width = model.name.length * 15;
    return CGSizeMake(width, 30);
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
