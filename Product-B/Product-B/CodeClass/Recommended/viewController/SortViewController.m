//
//  SortViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "SortViewController.h"
#import "SortCollectionViewCell.h"

@interface SortViewController ()<XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) UIBarButtonItem *editButton;

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((kScreenWidth - 25)/4.0, 30);
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    XWDragCellCollectionView *mainView = [[XWDragCellCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    _mainView = mainView;
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.shakeLevel = 3.0f;
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView registerClass:[SortCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:mainView];
//    UIBarButtonItem *editingButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(xwp_edting:)];
//    _editButton = editingButton;
//    self.navigationItem.rightBarButtonItem = editingButton;
    
 
    
}

- (NSArray *)data{
    if (!_data) {
        _data = @[@"最新",@"优创＋",@"快报",@"视频",@"新闻",@"评测",@"导购",@"行情",@"用车",@"技术",@"文化",@"改装",@"游记",@"原创视频",@"说客"];
    }
    return _data;
}

#pragma mark - <XWDragCellCollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = self.data[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
    return _data;
}

#pragma mark - <XWDragCellCollectionViewDelegate>
- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    _data = newDataArray;
}




@end
