//
//  RadioPlayerView.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayViewController.h"

@interface RadioPlayerView : UIView
@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UIButton *timing;
@property (strong, nonatomic) IBOutlet UIButton *share;
@property (strong, nonatomic) IBOutlet UIImageView *radiopic;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIButton *list;
@property (strong, nonatomic) IBOutlet UIButton *playAndPause;
@property (strong, nonatomic) IBOutlet UIButton *comment;
@property (strong, nonatomic) IBOutlet UILabel *zhuchi;

@property(nonatomic,strong)MusicPlayViewController *vc;


@end
