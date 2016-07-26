//
//  AlbumPlayerView.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayViewController.h"

@interface AlbumPlayerView : UIView


@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UIButton *timing;
@property (strong, nonatomic) IBOutlet UIButton *share;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *gust;
@property (strong, nonatomic) IBOutlet UILabel *ancho;
@property (strong, nonatomic) IBOutlet UILabel *current;
@property (strong, nonatomic) IBOutlet UILabel *all;
@property (strong, nonatomic) IBOutlet UIButton *list;
@property (strong, nonatomic) IBOutlet UIButton *above;
@property (strong, nonatomic) IBOutlet UIButton *next;
@property (strong, nonatomic) IBOutlet UIButton *comment;
@property (strong, nonatomic) IBOutlet UIButton *playAndPause;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *likeL;
@property (strong, nonatomic) IBOutlet UIButton *downLoadBtn;
@property (strong, nonatomic) IBOutlet UILabel *downloadL;



@property(nonatomic,strong)MusicPlayViewController *vc;



- (void)loadDataWithAlbumIndex:(NSInteger )index;


@end
