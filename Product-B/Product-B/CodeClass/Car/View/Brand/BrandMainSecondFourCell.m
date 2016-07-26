//
//  BrandMainSecondFourCell.m
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandMainSecondFourCell.h"

@implementation BrandMainSecondFourCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;


        for (int i = 0; i < 3; i++) {
            self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            self.button.tag = 100 + i;
            self.button.titleLabel.font = [UIFont systemFontOfSize:15];

//            [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            
            [self.contentView addSubview:self.button];
        }
        
    }
    return self;
}
- (void)cellModel:(BrandMainSecondModel *)model{
    if (model.spectype.count == 0) {
        [self.contentView removeFromSuperview];
    }

    CGFloat w = 0;
    CGFloat h = 0;
    
    for (int i = 0; i < model.spectype.count; i++) {
        
        UIButton *button = [self.contentView viewWithTag:i + 100];

        NSDictionary *dic = model.spectype[i];
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [[dic objectForKey:@"name"] boundingRectWithSize:CGSizeMake(W, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h + 10, length + 20, 30);
        w = button.frame.size.width + button.frame.origin.x;
    }

    
}
@end
