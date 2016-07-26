//
//  CommonlViewController.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTModel.h"
#import "CarModel.h"
@interface CommonlViewController : UIViewController
@property (nonatomic, strong) RTModel *model;
//@property (nonatomic, strong) CarModel *carmodel;
@property (nonatomic, assign) NSInteger type;
@end
