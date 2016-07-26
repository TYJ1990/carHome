//
//  UnihubViewController.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface UnihubViewController : UIViewController

@property(nonatomic,strong)NSNumber *newsid;
@property(nonatomic,strong)RecommendModel *model;

@property(nonatomic,strong)NSString *videoURL;
@property(nonatomic,assign)BOOL isScro;

@end
