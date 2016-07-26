//
//  DetailViewController.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface DetailViewController : UIViewController

@property(nonatomic,strong)NSNumber *newsid;
@property(nonatomic,strong)RecommendModel *model;


@property(nonatomic,assign)BOOL isScro;
@property(nonatomic,strong)NSString *urlString;
@end
