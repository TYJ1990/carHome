//
//  WonCollectionViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WonderfulModel.h"
@interface WonCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameL;

- (void)cellConfigureModel:(WonderfulModel *)model;

@end
