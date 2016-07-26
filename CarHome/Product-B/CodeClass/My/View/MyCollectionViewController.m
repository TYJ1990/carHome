//
//  MyCollectionViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionCollectionViewCell.h"
#import "MyModel.h"
@interface MyCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *indexP;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyCollectionViewController
#pragma mark 懒加载
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
        if (_itme == 0) {
            NSArray *arr = @[@"车系收藏", @"车型收藏", @"口碑收藏", @"文章收藏", @"收藏优创+", @"视频收藏", @"说客收藏", @"论坛收藏", @"帖子收藏"];
            for (int i = 0; i < arr.count; i++) {
                MyModel *model = [[MyModel alloc] init];
                model.name = arr[i];
                if (i == 0) {
                    model.isSelect = YES;
                }
                [_array addObject:model];
            }
        } else {
            NSArray *arr = @[@"浏览的车系", @"浏览的车型", @"浏览的口碑", @"浏览的文章", @"浏览的视频", @"浏览的说客", @"浏览的论坛", @"浏览的帖子"];
            for (int i = 0; i < arr.count; i++) {
                MyModel *model = [[MyModel alloc] init];
                model.name = arr[i];
                if (i == 0) {
                    model.isSelect = YES;
                }
                [_array addObject:model];
            }
        }
        
    }
    return _array;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if (_itme == 0) {
            layout.minimumLineSpacing = 50;
        } else {
            layout.minimumLineSpacing = 10;
        }
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(50, 0, kWidth - 50, kNaviH) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        
    }
    return _collectionView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + kNaviH, kWidth, kHeight - kNaviH - 20)];
        _scrollView.contentSize = CGSizeMake(kWidth * self.array.count, 0);
        _scrollView.backgroundColor = [UIColor grayColor];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)lineView {
    if (!_lineView) {
        if (_itme == 0) {
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, kNaviH - 2, 52, 2)];
            _lineView.backgroundColor = self.view.tintColor;
        } else {
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, kNaviH - 2, 65, 2)];
            _lineView.backgroundColor = self.view.tintColor;
        }
    }
    return _lineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self createTitleBar];
    [self.view addSubview:self.scrollView];
    [self createTableView];
    [self.collectionView addSubview:self.lineView];
}
// 标题栏和编辑
- (void)createTitleBar {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    head.backgroundColor = [UIColor blackColor];
    [self.view addSubview:head];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kNaviH)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:view];
    
    [view addSubview:self.collectionView];
    [self.collectionView registerClass:[MyCollectionCollectionViewCell class] forCellWithReuseIdentifier:@"ccell"];
    UIButton *back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    back.frame = CGRectMake(5, 10, 40, 20);
    back.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [back setImage:[UIImage imageNamed:@"返回.png"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:back];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNaviH - 1, kWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.7;
    [view addSubview:line];
    
}

// 创建tableView
- (void)createTableView {
    for (int i = 0; i < self.array.count; i++) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, self.scrollView.height)];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.tag = 100 + i;
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kWidth * i) + 100, 100, 50, 50)];
        label.textColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"第%d页", i];
        [self.scrollView addSubview:self.tableView];
        [self.scrollView addSubview:label];
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(kWidth * i, self.scrollView.height - kNaviH, kWidth, kNaviH)];
        footView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self.scrollView addSubview:footView];
        
        if (_itme == 0) {
            UIButton *editorBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
            editorBut.frame = CGRectMake(footView.width - 40, 10, 30, 20);
            editorBut.tag = 110 + i;
            [editorBut setTitle:@"编辑" forState:(UIControlStateNormal)];
            [editorBut addTarget:self action:@selector(editorAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [footView addSubview:editorBut];
        } else {
            UIButton *emptyBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
            emptyBut.tag = 120 + i;
            emptyBut.frame = CGRectMake(footView.width - 40, 10, 30, 20);
            [emptyBut setTitle:@"清空" forState:(UIControlStateNormal)];
            [emptyBut addTarget:self action:@selector(emptyAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [footView addSubview:emptyBut];
        }
        
    }
}


// 返回上级页面并显示tabbar
- (void)backAction:(UIButton *)sender {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}
// 编辑按钮点击
- (void)editorAction:(UIButton *)sender {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2.0 - 50, 500, 100, 30)];
    label.backgroundColor = [UIColor blackColor];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.text = @"暂无收藏";
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

// 清空按钮点击
- (void)emptyAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"将会清空%ld的浏览记录，是否继续?", sender.tag] preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"清空");
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = _scrollView.contentOffset.x / kWidth;
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    if (_indexP != path) {
        if (_indexP == nil) {
            // indexP为空 刷新第一个cell
            MyModel *modelA = [self.array firstObject];
            modelA.isSelect = NO;
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexpath,nil]];
            // 当前选中cell
            MyModel *modelB = self.array[path.row];
            modelB.isSelect = YES;
            MyCollectionCollectionViewCell *cell = (MyCollectionCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:path];
            cell.nameL.textColor = self.view.tintColor;
//            _indexP = path;
        } else {
            // 上一个选中的cell
            MyCollectionCollectionViewCell *cellA = (MyCollectionCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:_indexP];
            cellA.nameL.textColor = [UIColor grayColor];
            MyModel *modelA = self.array[_indexP.row];
            modelA.isSelect = NO;
            // 当前选中的cell
            MyCollectionCollectionViewCell *cellB = (MyCollectionCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:path];
            cellB.nameL.textColor = self.view.tintColor;
            MyModel *modelB = self.array[path.row];
            modelB.isSelect = YES;
        }
    }
    // 给indexP赋值
    self.indexP = path;
    [self moveLineViewWithindex:path.row];
}

#pragma mark collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ccell" forIndexPath:indexPath];
    MyModel *model = self.array[indexPath.row];
    [cell cellConfigureModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.indexP == nil) {
        // indexP为空 刷新第一个cell
        MyModel *modelA = [self.array firstObject];
        modelA.isSelect = NO;
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:path,nil]];
        // 当前选中cell
        MyModel *modelB = self.array[indexPath.row];
        modelB.isSelect = YES;
        MyCollectionCollectionViewCell *cell = (MyCollectionCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.nameL.textColor = self.view.tintColor;
        
    } else {
        if (self.indexP != indexPath) {
            NSLog(@"index = %ld", _indexP.row);
            // 上一个选中的cell
            MyCollectionCollectionViewCell *cellA = (MyCollectionCollectionViewCell *)[collectionView cellForItemAtIndexPath:_indexP];
            cellA.nameL.textColor = [UIColor grayColor];
            MyModel *modelA = self.array[_indexP.row];
            modelA.isSelect = NO;
            // 当前选中的cell
            MyCollectionCollectionViewCell *cellB = (MyCollectionCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cellB.nameL.textColor = self.view.tintColor;
            MyModel *modelB = self.array[indexPath.row];
            modelB.isSelect = YES;
        }
    }
    // 给indexP赋值
    self.indexP = indexPath;
    self.scrollView.contentOffset = CGPointMake(indexPath.row * kWidth, 0);
    [self moveLineViewWithindex:indexPath.row];
}

// 动态加载item的宽度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyModel *model = self.array[indexPath.row];
    CGFloat width = model.name.length * 15;
    return CGSizeMake(width, 30);
}
// lineView移动
- (void)moveLineViewWithindex:(NSInteger)index {
    if (_itme == 0) {
        if (index < 4) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];// 动画执行时间
            [UIView setAnimationRepeatCount:1];// 动画的执行次数
            [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
            self.lineView.frame = CGRectMake(10 + (index * 70), kNaviH - 2, 52, 2);
            // 动画提交
            [UIView commitAnimations];
        } else {
            if (index == 4) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];// 动画执行时间
                [UIView setAnimationRepeatCount:1];// 动画的执行次数
                [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
                self.lineView.frame = CGRectMake(12.5 + (index * 70), kNaviH - 2, 60, 2);
                // 动画提交
                [UIView commitAnimations];
            } else {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];// 动画执行时间
                [UIView setAnimationRepeatCount:1];// 动画的执行次数
                [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
                self.lineView.frame = CGRectMake(25 + (index * 70), kNaviH - 2, 52, 2);
                // 动画提交
                [UIView commitAnimations];
            }
        }
    } else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];// 动画执行时间
        [UIView setAnimationRepeatCount:1];// 动画的执行次数
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        self.lineView.frame = CGRectMake(10 + (index * 85), kNaviH - 2, 65, 2);
        // 动画提交
        [UIView commitAnimations];
    }
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
