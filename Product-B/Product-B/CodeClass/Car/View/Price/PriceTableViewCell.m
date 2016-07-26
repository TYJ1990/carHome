//
//  PriceTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "PriceTableViewCell.h"

@implementation PriceTableViewCell

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

        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 50)];
        [self.contentView addSubview:self.imageV];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 200, 20)];
        [self.contentView addSubview:self.title];
        
        self.dealerprice = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 50, 20)];
        self.dealerprice.textColor = [UIColor redColor];
        [self.contentView addSubview:self.dealerprice];
        
        self.fctprice = [[UILabel alloc]initWithFrame:CGRectMake(150, 40, 50, 20)];
        [self.contentView addSubview:self.fctprice];
        
        self.upprice = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 40, 60, 20)];
        [self.contentView addSubview:self.upprice];
        
        self.city = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 40, 20)];
        self.city.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.city];
        
        self.shortname = [[UILabel alloc]initWithFrame:CGRectMake(50, 70, 120, 20)];
        self.shortname.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.shortname];
        
        self.distance = [[UILabel alloc]initWithFrame:CGRectMake(180, 70, 30, 20)];
        self.distance.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.distance];
        
        self.orderrange = [[UILabel alloc]initWithFrame:CGRectMake(220, 70, 50, 20)];
        self.orderrange.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.orderrange];
        
        self.calculate = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, (W-2)/3, 30)];
        [self.calculate setTitle:@"购车计算" forState:(UIControlStateNormal)];
        [self.calculate setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        self.calculate.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.calculate setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.calculate];
        
        self.phone = [[UIButton alloc]initWithFrame:CGRectMake(self.calculate.frame.size.width +1, 100, (W - 2)/3, 30)];
        [self.phone setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        self.phone.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.phone setBackgroundColor:[UIColor whiteColor]];
        [self.phone setTitle:@"立即拨打" forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.phone];
        
        self.floorprice = [[UIButton alloc]initWithFrame:CGRectMake(self.phone.frame.origin.x + (W-2)/3 + 1, 100, W/3, 30)];
        [self.floorprice setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        self.floorprice.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.floorprice setBackgroundColor:[UIColor whiteColor]];
        [self.floorprice setTitle:@"询底价" forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.floorprice];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 130, W, 5)];
        view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        [self.contentView addSubview:view];

    }
    return self;
}

- (void)cellModel:(PriceModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.specpic]];
    
    self.title.text = model.specname;
    self.dealerprice.text = model.dealerprice;
    // 设置label文本多种属性 Attributes
    NSMutableAttributedString *attrubute = [[NSMutableAttributedString alloc]initWithString:model.fctprice];
    
    // 批量设置文本属性 字典形式 大小  颜色  删除线
    NSDictionary *attributeDict = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor], NSStrikethroughStyleAttributeName : @(NSUnderlineStyleThick)};
    [attrubute addAttributes:attributeDict range:NSMakeRange(0, model.fctprice.length)];

    // 设置单个属性
//    [attrubute addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(2, 2)];
    // 赋值
    self.fctprice.attributedText = attrubute;

    float dealer = [model.dealerprice floatValue];
    float fct = [model.fctprice floatValue];
    
    self.upprice.text = [NSString stringWithFormat:@"降%.2f万",fct - dealer];
    self.upprice.textColor = [UIColor greenColor];
    self.upprice.font = [UIFont systemFontOfSize:12];
    self.city.text = model.city;
    self.shortname.text = model.shortname;
    self.distance.text = model.distance;
    self.orderrange.text= model.orderrange;
}
@end
