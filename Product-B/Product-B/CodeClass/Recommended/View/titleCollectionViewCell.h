//
//  titleCollectionViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface titleCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *nameL;
- (void)cellFrameWithStrng:(NSString *)string;

@end
