//
//  AlbumListViewController.h
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumListViewController : UIViewController


@property(nonatomic,strong)UIView *graryView;

@property(nonatomic,strong)UIButton *today;
@property(nonatomic,strong)UIButton * tomorrow;
@property(nonatomic,strong)UIView *todayView;
@property(nonatomic,strong)UIView *tomorrowView;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *close;
@property(nonatomic,assign)BOOL isToday;



@end
