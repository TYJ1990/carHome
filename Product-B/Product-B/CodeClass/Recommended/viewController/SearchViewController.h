//
//  SearchViewController.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchVC;

// 存放排好序的数据(汉字)

@property (nonatomic, strong) NSMutableDictionary *sectionDictionary;

// 存放汉字拼音大写首字母

@property (nonatomic, strong) NSArray *keyArray;

// 存放汉字(地名)

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
