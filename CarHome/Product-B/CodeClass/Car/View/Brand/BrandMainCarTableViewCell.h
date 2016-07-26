//
//  BrandMainCarTableViewCell.h
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "BrandMainModel.h"
@interface BrandMainCarTableViewCell : UITableViewCell
@property (nonatomic, strong)CustomButton *button;
- (void)cellModel:(NSMutableArray *)modelArray;
@end
