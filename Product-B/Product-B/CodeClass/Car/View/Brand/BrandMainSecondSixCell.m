//
//  BrandMainSecondSixCell.m
//  Product-B
//
//  Created by super on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandMainSecondSixCell.h"

@implementation BrandMainSecondSixCell

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

        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, W, 20)];
        self.titleLabel.text = @"推荐车系";
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
        for (int i = 0; i < 3; i++) {
            // 高度是宽度的  10/6
            self.button = [[BrandMainSecondSixButton alloc]initWithFrame:CGRectMake(10 + ((W - 40)/3 + 10)*i, 0 + self.titleLabel.bottom, (W - 40)/3, (W- 40)/3 * 4/3)];
            self.button.tag = i + 1;
            [self.contentView addSubview:self.button];
        }
    }
    return self;
}
- (void)cellModelArray:(NSMutableArray *)modelArray{
    for (int i = 0; i < modelArray.count; i++) {
        BrandMainSecondRecommendModel *model = modelArray[i];
        BrandMainSecondSixButton *button = [self.contentView viewWithTag:i+1];
        [button buttonTitle:@"推荐车系" image:model.carimg name:model.seriesname score:model.kbscore price:model.pricerange];
    }
}
@end
