//
//  BrandCarTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandCarTableViewCell.h"

@implementation BrandCarTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self.contentView addSubview:self.imageV];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 30)];
        [self.contentView addSubview:self.label];
    }
    return self;
}
- (void)cellDic:(NSDictionary *)dic{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgurl"]]];
    self.label.text = [dic objectForKey:@"name"];
}
@end
