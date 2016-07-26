//
//  MyCollectionCollectionViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"
@interface MyCollectionCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameL;
- (void)cellConfigureModel:(MyModel *)model;
@end
