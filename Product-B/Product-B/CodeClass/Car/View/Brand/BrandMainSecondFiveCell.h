//
//  BrandMainSecondFiveCell.h
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandMainSecondTableModel.h"
@interface BrandMainSecondFiveCell : UITableViewCell
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *price;
@property (nonatomic, strong)UILabel *attention;
@property (nonatomic, strong)UIView *upview;
@property (nonatomic, strong)UIView *downview;
@property (nonatomic, strong)UILabel *minprice;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, strong)UIButton *button2;
@property (nonatomic, strong)UIButton *button3;

- (void)cellModel:(NSDictionary *)dic;

@end
