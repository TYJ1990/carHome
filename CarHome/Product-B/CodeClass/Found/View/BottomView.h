//
//  BottomView.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLOCK)(NSString *,NSString *,NSString *);

@interface BottomView : UIView


@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *album;
@property(nonatomic,strong)UIButton *play;
@property(nonatomic,strong)UIButton *next;

@property(nonatomic,strong)UIView *blurView;
@property(nonatomic,copy)BLOCK resultBlock;
@property(nonatomic,strong)UIView  *listView;

@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,assign)BOOL isPause;


@end
