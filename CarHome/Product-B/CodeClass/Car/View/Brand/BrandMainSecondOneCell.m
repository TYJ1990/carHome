//
//  BrandMainSecondOneCell.m
//  Product-B
//
//  Created by super on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandMainSecondOneCell.h"
@implementation BrandMainSecondOneCell

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

        // 车名
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, W - 20, 20)];
        [self.contentView addSubview:self.label];
        // 厂商指导价
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.label.bottom + 5, W - 20, 20)];
        self.label1.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.label1];
     
        // 配置 口碑 等自定义button创建
        for (int i = 0; i < 12; i++) {
            self.button = [[BrandMainSecondOneButton alloc]initWithFrame:CGRectMake(i%2 * W/2, i/2 * 60 + 70, W/2, 60)];
            self.button.tag = i + 1;
            [self.button.layer setBorderColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1
].CGColor];
            [self.button.layer setBorderWidth:0.3];
            [self.contentView addSubview:self.button];
        }
        
    }
    return self;
}

- (void)cellModel:(BrandMainSecondModel *)model{
    
    // 车名  价格  赋值
        self.label.text = model.name;
        self.label1.text = [NSString stringWithFormat:@"%@%@",model.fctpricename ,model.fctprice];
    
    // 配置 口碑 等数据的array
        NSArray *array = model.tabinfos;
    
    
        for (int i = 0; i < array.count; i++) {
            // 每个数据的字典 dic
        NSDictionary *dic = array[i];
            // 获取tag 对应button
        self.button = [self.contentView viewWithTag:i+1];
            // 如果是第 1 - 10 个按钮
            if (self.button.tag >0 && self.button.tag < 11) {
            
            // 先移除自定义button 上的label
                for (UIView *view1 in self.button.subviews) {
                [view1 removeFromSuperview];
            }
                // 获取小标题
//                "tabsubtitle": "<font color='#4680d1' >0</font> 款车型配置"
                NSArray *arr = [dic[@"tabsubtitle"] componentsSeparatedByString:@">"];
                NSArray *arr1 = [arr[1] componentsSeparatedByString:@"<"];
                
                NSString *str = [NSString stringWithFormat:@"%@%@",arr1[0],arr[2]];
            
                // 创建自定义button 并 赋值
                [self.button title:dic[@"tabtitle"] content:str];
            
            }else{
                // 如果是第11 个button（第11个button的小标题有点复杂，获取方式与前10个不同）
//                "tabsubtitle": "<font color='#4680d1' >210</font> 新车 | <font color='#4680d1' >暂无</font> 可靠性"
                
                for (UIView *view1 in self.button.subviews) {
                    [view1 removeFromSuperview];
                }
                // 截取字符串
                NSArray *array = [dic[@"tabsubtitle"]componentsSeparatedByString:@"|"];
                NSArray *arr = [array[0] componentsSeparatedByString:@">"];
                NSArray *arr1 = [arr[1] componentsSeparatedByString:@"<"];
                NSString *str = [NSString stringWithFormat:@"%@%@",arr1[0],arr[2]];
                
                NSArray *arr2 = [array[1] componentsSeparatedByString:@">"];
                NSArray *arr3 = [arr2[1]componentsSeparatedByString:@"<"];
                NSString *str2 = [NSString stringWithFormat:@"%@%@",arr3[0], arr2[2]];
                
                NSString *string = [NSString stringWithFormat:@"%@|%@",str, str2];
                // 赋值
                [self.button title:dic[@"tabtitle"] content:string];

            }
         
        }

}
@end
