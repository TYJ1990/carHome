//
//  BlurView.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurView : UIView
//@property (strong, nonatomic) IBOutlet UIImageView *background;
//@property (strong, nonatomic) IBOutlet UIImageView *icon;
//@property (strong, nonatomic) IBOutlet UILabel *like;
//@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
//@property (strong, nonatomic) IBOutlet UILabel *content;
//@property (strong, nonatomic) IBOutlet UILabel *titleL;


@property (strong, nonatomic) UIImageView *background;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *like;
@property (strong, nonatomic) UIButton *likeBtn;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *titleL;

@property(nonatomic,strong)UIButton *timeBtn;
@property(nonatomic,strong)UIButton *hotBtn;

@end
