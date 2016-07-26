//
//  RecommendedViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "RecommendedViewController.h"
#import "titleCollectionViewCell.h"
#import "RecommendModel.h"
#import "RecommendTableViewCell.h"
#import "VideoTableViewCell.h"
#import "NewsflashTableViewCell.h"
#import "PicTableViewCell.h"
#import "OnlyOne.h"
#import "SearchAndSort.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "NewsflashViewController.h"
#import "UnihubViewController.h"
#import "PicViewController.h"
#import "SortViewController.h"

@interface RecommendedViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *moveView;
@property(nonatomic,strong)CarouselView *CarouselView;
@property(nonatomic,strong)NSArray *requestArray;
@property(nonatomic,strong)NSMutableArray *normalImages;
@property(nonatomic,strong)NSMutableArray *refreshImages;
@property(nonatomic,strong)SearchAndSort *searchView;
@property(nonatomic,assign)CGFloat length;
@property(nonatomic,strong)UIView *sortView;
@property(nonatomic,strong)UIView *head;
@property(nonatomic,strong)SortViewController *sortVC;
@end

@implementation RecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.titleArray = @[@"最新",@"优创＋",@"快报",@"视频",@"新闻",@"评测",@"导购",@"行情",@"用车",@"技术",@"文化",@"改装",@"游记",@"原创视频",@"说客"];
    self.requestArray = @[zuixin,youchuang,kuaibao,shipin,xinwen,pingce,daogou,hangqing,yongche,jishu,wenhua,gaizhuang,youji,yuanchuangshipin,shuoke];
    self.searchView = [[SearchAndSort alloc] initWithFrame:CGRectMake(kScreenWidth - 75, 20, 75, 40)];
    [self.searchView.sortBtn addTarget:self action:@selector(sortAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.searchView.searchBtn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.scrollView];
    [self.collectionView addSubview:self.moveView];
    [self.view addSubview:self.searchView];
    [self creatImages];
    [self creatTableView];
    [self.view addSubview:self.sortView];
    [self.view addSubview:self.head];
    UITableView *tableView = [self.scrollView viewWithTag:1000];
    [tableView.mj_header beginRefreshing];
    [[OnlyOne shareInstance].titleArray setObject:@"hah" forKey:self.titleArray[0]];
}

#pragma mark  --------属性 ----------
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 20;
        
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 20, kScreenWidth- 80, 40) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[titleCollectionViewCell class] forCellWithReuseIdentifier:@"titleCell"];
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:(UICollectionViewScrollPositionNone)];
    }
    return _collectionView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60 - 44)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(kScreenWidth *self.titleArray.count, 0);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (UIView *)moveView{
    if (!_moveView) {
        _moveView = [[UIView alloc] initWithFrame:CGRectMake(10, 38, 34, 2)];
        _moveView.backgroundColor = self.view.tintColor;
        _moveView.tag = 100;
    }
    return _moveView;
}

- (UIView *)sortView{
    if (!_sortView) {
        _sortView = [[UIView alloc] initWithFrame:CGRectMake(0, -kScreenHeight, kScreenWidth,kScreenHeight - 200)];
        self.sortVC = [[SortViewController alloc] init];
        self.sortVC.view.backgroundColor = [UIColor clearColor];
        [_sortView addSubview:self.sortVC.view];
    }
    return _sortView;
}
- (UIView *)head{
    if (!_head) {
        _head = [[UIView alloc] initWithFrame:CGRectMake(-kScreenWidth, 0, kScreenWidth, 60)];
        _head.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [btn setTitle:@"全部频道" forState:(UIControlStateNormal)];
        btn.frame = CGRectMake(0, 20, 80, 40);
        [_head addSubview:btn];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(1, 58, 75, 2)];
        view.backgroundColor = self.view.tintColor;
        [_head addSubview:view];
        UIButton *editBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [editBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        editBtn.frame = CGRectMake(kScreenWidth - 50, 25, 40, 30);
        [_head addSubview:editBtn];
    }
    return _head;
}



- (void)creatTableView{
    for (int i = 0; i < self.titleArray.count; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight - 44 - 60) style:(UITableViewStylePlain)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 1000 + i;
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [self loadDataWithIndex:i];
        }];
        [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
        [header setImages:self.normalImages forState:MJRefreshStateIdle];
        [header setImages:self.refreshImages forState:MJRefreshStatePulling];
//        header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
//        header.stateLabel.hidden = YES;
        tableView.mj_header = header;
        tableView.showsVerticalScrollIndicator = NO;
        [tableView registerNib:[UINib nibWithNibName:@"RecommendTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"recommendCell"];
        [tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"videoCell"];
        [tableView registerNib:[UINib nibWithNibName:@"NewsflashTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"newsCell"];
        [tableView registerNib:[UINib nibWithNibName:@"PicTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"picCell"];
        [self.scrollView addSubview:tableView];
    }
}


- (void)creatCarouselViewWithArray:(NSMutableArray *)imagesArray index:(NSInteger )index{
    UITableView *tableView = [self.view viewWithTag:index];
    NSMutableArray *array = [NSMutableArray array];
    for (RecommendModel *model in imagesArray) {
        NSString *imageUrl = model.imgurl;
        [array addObject:imageUrl];
    }
    self.CarouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight*7/24) imageURLs:array];
    __weak RecommendedViewController *weakSelf = self;
    self.CarouselView.imageClick = ^(NSInteger index1){
        RecommendModel *model = imagesArray[index1];
        if (index == 1000) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.model = model;
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
        }else{
            UnihubViewController *detailVC = [[UnihubViewController alloc] init];
            detailVC.model = model;
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
        }
    };
    tableView.tableHeaderView = self.CarouselView;
}





- (void)creatImages{
    self.normalImages = [@[[UIImage imageNamed:@"image1.tiff"]] mutableCopy];
    self.refreshImages = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.tiff",i]];
        [self.refreshImages addObject:image];
    }
}





#pragma mark ---------searchController 跳转 ------
- (void)pushAction:(UIButton *)btn{
    SearchViewController *searchView = [[SearchViewController alloc] init];
    [self presentViewController:searchView animated:YES completion:nil];
}
- (void)sortAction:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        self.head.frame = CGRectMake(0, 0, kScreenWidth, 60);
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.5 animations:^{
           self.sortView.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight - 300);
           [self.sortVC.mainView xw_enterEditingModel];
       } completion:nil];
    }];
}

- (void)editBtnAction:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        self.sortView.frame = CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight - 200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.head.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, 60);
            [self.sortVC.mainView xw_stopEditingModel];
        } completion:nil];
    }];
}





#pragma mark --------- 网络请求 ---------
- (void)loadDataWithIndex:(NSInteger )index{
    UITableView *tableView = [self.view viewWithTag:index + 1000];
    [RequestManager requestWithUrlString:self.requestArray[index] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [RecommendModel ModelConfigureJsonDic:dic];
        NSArray *array = dic[@"result"][@"focusimg"];
        NSArray *array2 = dic[@"result"][@"focusimgs"];
        if (array.count > 0 || array2.count > 0) {
            NSMutableArray *CarouselArray = [RecommendModel ModelCarouselWithJsonDic:dic];
            [self creatCarouselViewWithArray:CarouselArray index:index + 1000];
        }
        [tableView.mj_header endRefreshing];
        [tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}





#pragma mark ---------- collectionView 代理方法 ----------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    titleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
    cell.tintColor = [UIColor blueColor];
    [cell cellFrameWithStrng:self.titleArray[indexPath.row]];
    if (indexPath.row == self.moveView.tag - 100) {
        cell.nameL.textColor = self.view.tintColor;
    } else{
        cell.nameL.textColor = [UIColor grayColor];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (![[OnlyOne shareInstance].titleArray valueForKey:self.titleArray[indexPath.row]]) {
        UITableView *tableView = [self.view viewWithTag:1000 + indexPath.row];
        [tableView.mj_header beginRefreshing];
    }else{
        [self loadDataWithIndex:indexPath.row];
    }
    [[OnlyOne shareInstance].titleArray setValue:@"yes" forKey:self.titleArray[indexPath.row]];
    self.moveView.tag = 100 + indexPath.row;
    titleCollectionViewCell *cell = (titleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.nameL.textColor = [UIColor blueColor];
    [self initFrameAnimetion:indexPath];
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(indexPath.row * kScreenWidth, 0);
    } completion:^(BOOL finished) {
        
    }];
}



#pragma mark ---------- flowLayout 代理方法 ------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [UILabel getWidthWithTitle:self.titleArray[indexPath.row] font:[UIFont systemFontOfSize:17]];
    return CGSizeMake(width, 30);
}



#pragma mark --------------- item 动画 -----------
- (void)initFrameAnimetion:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        [UIView animateWithDuration:0.6 animations:^{
            self.collectionView.contentOffset = CGPointMake(10 + (indexPath.row - 1) * (34+20), 0);
        } completion:nil];
    }
    if (indexPath.row == 1) {
        CGRect frame = self.moveView.frame;
        frame.size.width = 51;
        self.moveView.frame = frame;
    } else if (indexPath.row == 13){
        CGRect frame = self.moveView.frame;
        frame.size.width = 68;
        self.moveView.frame = frame;
    } else{
        CGRect frame = self.moveView.frame;
        frame.size.width = 34;
        self.moveView.frame = frame;
    }
    if (indexPath.row == 14) {
        [UIView animateWithDuration:0.9 animations:^{
            self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) + 17 + 34 + 5, 38, 34, 2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.9 animations:^{
                self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) + 17 + 34 - 5, 38, 34, 2);
            } completion:^(BOOL finished) {
                self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) + 17 + 34, 38, 34, 2);
            }];
        }];
    }else if (indexPath.row > 1){
        [UIView animateWithDuration:0.3 animations:^{
            self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) + 17 + 5, 38, self.moveView.frame.size.width, 2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) + 17 - 5, 38, self.moveView.frame.size.width, 2);
            } completion:^(BOOL finished) {
                self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) + 17, 38, self.moveView.frame.size.width, 2);
            }];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) + 5, 38, self.moveView.frame.size.width, 2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20) - 5, 38, self.moveView.frame.size.width, 2);
            } completion:^(BOOL finished) {
                self.moveView.frame = CGRectMake(10 + indexPath.row * (34+20), 38, self.moveView.frame.size.width, 2);
            }];
        }];
    }

}





#pragma mark  ------------ tableView 代理方法 --------------
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendModel *model = self.modelArray[indexPath.row];
    if (tableView.tag == 1001) {
            VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
            [cell cellWithModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else if (tableView.tag == 1000 || tableView.tag == 1004 || tableView.tag == 1006 || tableView.tag == 1009 || tableView.tag == 1010 || tableView.tag == 1011){
        return [self returnCell:indexPath tableView:tableView];
    }else if (tableView.tag == 1002){
        NewsflashTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
        [cell cellWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell" forIndexPath:indexPath];
        if (tableView.tag == 1007) {
            [cell cellWithModel2:model];
        } else if (tableView.tag == 1014){
            [cell cellWithModel3:model];
        } else{
            [cell cellWithModel:model];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendModel *model = self.modelArray[indexPath.row];
    NSInteger i = tableView.tag;
    if (i == 1001) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if ([model.mediatype integerValue] == 3) {
            CGFloat hight = [UILabel getHeightByWidth:kScreenWidth - 20 title:model.title font:[UIFont systemFontOfSize:15.0]];
            return hight + kScreenWidth/2.0 - 10 + 55 + 55;
        } else{
            return 165;
        }
    }else if (i == 1002){
        return 230;
    }else if (i == 1000 || i == 1004 || i == 1006 || i == 1009 || i == 1010 || i == 1011){
        if (model.indexdetail.length > 50) {
            return 130;
        } else{
            return 75;
        }
    }
    else{
        return 75;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendModel *model = self.modelArray[indexPath.row];
    if (tableView.tag == 1002) {
        NewsflashViewController *news = [[NewsflashViewController alloc] init];
        news.model = model;
        [self.navigationController pushViewController:news animated:YES];
    } else if (tableView.tag == 1001){
        UnihubViewController *unihubVC = [[UnihubViewController alloc] init];
        unihubVC.model = model;
        [self.navigationController pushViewController:unihubVC animated:YES];
    }else {
        if (model.indexdetail.length > 50 && tableView.tag != 1003 && tableView.tag != 1013) {
            PicViewController *picVC = [[PicViewController alloc] init];
            picVC.model = model;
            [self presentViewController:picVC animated:YES completion:nil];
        }else{
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.model = model;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
}






- (UITableViewCell *)returnCell:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
    RecommendModel *model = self.modelArray[indexPath.row];
    if (model.indexdetail.length > 50) {
        PicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picCell" forIndexPath:indexPath];
        [cell cellWithModel:model];
        return cell;
    }else{
        RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell" forIndexPath:indexPath];
        [cell cellWithModel:model];
        return cell;
    }
}



#pragma mark --- 结束减速触发的方法 ---
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    UICollectionView *collectionView = self.view.subviews[0];
    if (scrollView != collectionView && ![scrollView isKindOfClass:[UITableView class]] ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / kScreenWidth inSection:0];
        self.moveView.tag = 100 + indexPath.row;
        titleCollectionViewCell *cell = (titleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.nameL.textColor = [UIColor blueColor];
        [self initFrameAnimetion:indexPath];
        [self.collectionView reloadData];
        if (![[OnlyOne shareInstance].titleArray valueForKey:self.titleArray[indexPath.row]]) {
            UITableView *tableView = [self.view viewWithTag:1000 + indexPath.row];
            [tableView.mj_header beginRefreshing];
        }
        [[OnlyOne shareInstance].titleArray setValue:@"yes" forKey:self.titleArray[indexPath.row]];
        if (self.length != scrollView.contentOffset.x) {
            self.length = scrollView.contentOffset.x;
            [self loadDataWithIndex:indexPath.row];
        }
    }
    
}


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}




@end
