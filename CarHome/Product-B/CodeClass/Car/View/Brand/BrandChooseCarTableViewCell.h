//
//  BrandChooseCarTableViewCell.h
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandChooseCarTableViewCell : UITableViewCell
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)NSMutableArray *array;
- (void)cellModelArray:(NSMutableArray *)array;

@end
