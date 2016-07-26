//
//  MyCollectionCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MyCollectionCollectionViewCell.h"

@implementation MyCollectionCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nameL = [[UILabel alloc] init];
        _nameL.font = [UIFont systemFontOfSize:13];
        _nameL.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameL];
    }
    return self;
}

- (void)cellConfigureModel:(MyModel *)model {
    self.nameL.text = model.name;
    self.nameL.frame = CGRectMake(5, 0, self.nameL.text.length * 15, 30);
    if (model.isSelect) {
        self.nameL.textColor = self.contentView.tintColor;
    } else {
        self.nameL.textColor = [UIColor grayColor];
    }
}

@end
