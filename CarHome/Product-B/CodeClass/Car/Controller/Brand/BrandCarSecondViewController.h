//
//  BrandCarSecondViewController.h
//  Product-B
//
//  Created by super on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandCarSecondViewController : UIViewController
@property (nonatomic, strong)NSString *myid;
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)UISegmentedControl *segment;

- (void)requestData:(NSString *)myid t:(NSString *)t;
@end
