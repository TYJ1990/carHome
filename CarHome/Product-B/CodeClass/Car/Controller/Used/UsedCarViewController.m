//
//  UsedCarViewController.m
//  Product-B
//
//  Created by super on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "UsedCarViewController.h"
#import "UsedCarFilterTableViewCell.h"
#import "UsedCarFindTableViewCell.h"
#import "UsedCarTableViewCell.h"

@interface UsedCarViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *mdoelArray;
@end

@implementation UsedCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTable];
}
- (void)requestData{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createTable{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, H - 44) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 0;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UsedCarFilterTableViewCell *filtercell = [tableView dequeueReusableCellWithIdentifier:@"filter"];
    UsedCarFindTableViewCell *findcell = [tableView dequeueReusableCellWithIdentifier:@"find"];
    UsedCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row == 0) {
        if (!filtercell) {
            filtercell = [[UsedCarFilterTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"filter"];
        }
        filtercell.selectionStyle =UITableViewCellSelectionStyleNone;

        return filtercell;
    }else if (indexPath.row == 1){
        if (!findcell) {
            findcell = [[UsedCarFindTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"find"];
        }
        findcell.selectionStyle =UITableViewCellSelectionStyleNone;

        return findcell;
    }else{
        if (!cell) {
            cell = [[UsedCarTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        return 50;
    }else if (indexPath.row == 1){
        return 160;
    }else{
        return 150;
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
