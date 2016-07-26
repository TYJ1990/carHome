//
//  SearchViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    label.backgroundColor = [UIColor greenColor];
    label.text = @"\n搜搜";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame = CGRectMake(kScreenWidth - 70, 27, 50, 30);
    [button setTitle:@"返回" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // UISearchController初始化
    
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchVC.searchResultsUpdater = self;
    self.searchVC.delegate = self;
    self.searchVC.searchBar.frame = CGRectMake(0, 100, kScreenWidth, 44);
    self.searchVC.searchBar.barTintColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
    
    
    // 设置为NO,可以点击搜索出来的内容
    self.searchVC.dimsBackgroundDuringPresentation = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.keyArray.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 取每个section对应的数组
    NSArray *arr = [self.sectionDictionary objectForKey:self.keyArray[section]];
    return arr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSArray *arr = [self.sectionDictionary objectForKey:self.keyArray[indexPath.section]];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

// section的标题

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return self.keyArray[section];
}

// 搜索界面将要出现

- (void)willPresentSearchController:(UISearchController *)searchController
{}
// 搜索界面将要消失
-(void)willDismissSearchController:(UISearchController *)searchController
{}

-(void)didDismissSearchController:(UISearchController *)searchController
{
//    [self customSortingOfChinese:self.dataArray];
    [self.tableView reloadData];
}


#pragma mark -- 搜索方法   
// 搜索时触发的方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchStr = [self.searchVC.searchBar text];
    // 谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchStr];
    // 过滤数据
    NSMutableArray *resultDataArray = [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:predicate]];
    // 调用地名排序的方法
//    [self customSortingOfChinese:resultDataArray];
    // 刷新列表
    [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *arlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"表点啦" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"听话", nil];
    [arlertView show];
    
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
