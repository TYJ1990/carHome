//
//  WonCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "WonCollectionViewCell.h"
#define Width self.frame.size.width
#define Height self.frame.size.height
@implementation WonCollectionViewCell

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

- (void)cellConfigureModel:(WonderfulModel *)model {
    self.nameL.text = model.name;
    self.nameL.frame = CGRectMake(5, 0, self.nameL.text.length * 15, 30);
    if (model.isSelect) {
        self.nameL.textColor = self.contentView.tintColor;
    } else {
        self.nameL.textColor = [UIColor grayColor];
    }
    
}

@end
