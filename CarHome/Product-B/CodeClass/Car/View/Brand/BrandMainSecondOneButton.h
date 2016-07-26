//
//  BrandMainSecondOneButton.h
//  Product-B
//
//  Created by super on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandMainSecondOneButton : UIButton
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UILabel *clabel;
- (void)title:(NSString *)title content:(NSString *)content;
@end
