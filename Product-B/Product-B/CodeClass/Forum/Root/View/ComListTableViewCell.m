//
//  ComListTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "ComListTableViewCell.h"
#define WIDTH (self.frame.size.width)
#define HEIGHT (self.frame.size.height)
@implementation ComListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
        self.bbsnameL = [[UILabel alloc] init];
        [self.contentView addSubview:_bbsnameL];
    }
    return self;
}

- (void)cellConfigureCarsModel:(CarsModel *)model {
    self.imageV.hidden = NO;
    self.imageV.frame = CGRectMake(5, 0, HEIGHT, HEIGHT);
    self.bbsnameL.frame = CGRectMake(5 + HEIGHT + 5, HEIGHT / 4.0, 200, HEIGHT / 2.0);

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.brandimg] placeholderImage:[UIImage imageNamed:@"shipinbg.png"] completed:nil];
    self.bbsnameL.text = model.brandname;
}

- (void)cellConfigureRTModel:(RTModel *)model {
    self.imageV.hidden = YES;
    self.bbsnameL.frame = CGRectMake(5, HEIGHT / 4.0, 200, HEIGHT / 2.0);
    self.bbsnameL.text = model.bbsname;
}

//- (void)cellConfigureThemeModel:(RTModel *)model {
//    self.imageV.hidden = YES;
//    self.bbsnameL.frame = CGRectMake(5, HEIGHT / 4.0, 200, HEIGHT / 2.0);
//}


@end
