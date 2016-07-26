//
//  PicViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "PicViewController.h"
#import "MyScrollView.h"

@interface PicViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIButton *collection;
@property(nonatomic,strong)UIButton *share;
@property(nonatomic,strong)UIButton *download;
@property(nonatomic,strong)UILabel *countL;
@property(nonatomic,strong)UIScrollView *scrV;
@property(nonatomic,strong)MyScrollView *myScr;
@property(nonatomic,strong)NSMutableArray *messegeAray;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,assign)BOOL isShow;
@end

@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    [self initScrollView];
    [self initMyScrollView];
    [self creatUI];
    self.messegeAray = [@[@"源计划雷 - 卢锡安 ",@"源计划 林 - 易",@"源计划 山 - 蕾欧娜",@"源计划 火 - 菲奥娜",@"源计划 阴 - 劫",@"",@"",@"",@"",@"",@"",@""] mutableCopy];
    
}


- (void)creatUI{
    
    self.countL = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, kScreenWidth, 20)];
    self.countL.textAlignment = NSTextAlignmentCenter;
    self.countL.font = [UIFont systemFontOfSize:15.0];
    self.countL.textColor = [UIColor whiteColor];
    self.countL.text = @"1/12";
    [self.view addSubview:self.countL];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(0, 23, 65, 20);
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"返回2"] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.tintColor = [UIColor whiteColor];
    [self.view addSubview:btn];
    
    self.collection = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.collection.frame = CGRectMake(kScreenWidth - 70, 20, 25, 25);
    [self.collection setImage:[UIImage imageNamed:@"下载"] forState:(UIControlStateNormal)];
    [self.collection addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.collection setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.collection];
    
    self.share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.share.frame = CGRectMake(kScreenWidth - 32, 24, 20, 20);
    [self.share setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    [self.share setTintColor:[UIColor whiteColor]];
    [self.share addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.share];
    
    self.content = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 + kScreenHeight*4/7.0, kScreenWidth, 60)];
    self.content.textColor = [UIColor whiteColor];
    self.content.textAlignment = NSTextAlignmentCenter;
    self.content.text = @"源计划 雷 - 卢锡安";
    self.content.numberOfLines = 0;
    [self.view addSubview:self.content];
    
    self.btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.btn1 setTitle:@"源计划" forState:(UIControlStateNormal)];
    self.btn1.tintColor = self.view.tintColor;
    self.btn1.frame = CGRectMake(100, kScreenHeight - 100, 50, 30);
    [self.btn1 addTarget:self action:@selector(btn1Action) forControlEvents:(UIControlEventTouchUpInside)];
    self.btn1.backgroundColor = [UIColor clearColor];
    [self.btn1.layer setBorderWidth:1.0];
    [self.btn1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.view addSubview:self.btn1];
    
    self.btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.btn2 setTitle:@"美女" forState:(UIControlStateNormal)];
    self.btn2.tintColor = [UIColor whiteColor];
    self.btn2.frame = CGRectMake(kScreenWidth - 150 , kScreenHeight - 100, 50, 30);
    [self.btn2 addTarget:self action:@selector(btn2Action) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn2.layer setBorderWidth:1.0];
    self.btn2.backgroundColor = [UIColor clearColor];
    [self.btn2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.view addSubview:self.btn2];
    
}




//定义小的滚动视图
- (void)initMyScrollView{
    //产生小的滚动视图
    for (int i = 0; i < 12; i++) {
        NSString *s = [NSString stringWithFormat:@"%d.jpg",i];
        UIImage *image = [UIImage imageNamed:s];
        //循环产生滚动视图
        self.myScr = [[MyScrollView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight) image:image];
        //设置tag值
        self.myScr.tag = i + 1;
        //将小的滚动视图添加到大的滚动视图上
        [self.scrV addSubview:self.myScr];
    }

    self.myScr.backgroundColor = [UIColor blackColor];
    [self.scrV addSubview:self.myScr];
    
}

//定义一个大的滚动视图
- (void)initScrollView{
    self.scrV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //配置一系列属性
    self.scrV.contentSize = CGSizeMake(12 * kScreenWidth, 0);
    //隐藏滚动条
    self.scrV.showsHorizontalScrollIndicator = NO;
    //设置整页翻动
    self.scrV.pagingEnabled = YES;
    //设置代理
    self.scrV.delegate = self;
    [self.view addSubview:self.scrV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(showAction:)];
    [self.scrV addGestureRecognizer:tap];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigAction:)];
    tap2.numberOfTapsRequired = 2;
    [self.scrV addGestureRecognizer:tap2];
    [tap requireGestureRecognizerToFail:tap2];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.countL.text = [NSString stringWithFormat:@"%.0f/12",scrollView.contentOffset.x/kScreenWidth + 1];
    if (scrollView.contentOffset.x / kScreenWidth < 5) {
        self.btn1.tintColor = self.view.tintColor;
        self.btn2.tintColor = [UIColor whiteColor];
    }else{
        self.btn2.tintColor = self.view.tintColor;
        self.btn1.tintColor = [UIColor whiteColor];
    }
    NSInteger index = (NSInteger)scrollView.contentOffset.x / kScreenWidth;
    self.content.text = self.messegeAray[index];
}


- (void)backAction:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btn1Action{
    self.btn1.tintColor = self.view.tintColor;
    self.btn2.tintColor = [UIColor whiteColor];
    self.scrV.contentOffset = CGPointMake(0, 0);
    self.countL.text = @"1/12";
    self.content.text = self.messegeAray[0];
}

- (void)btn2Action{
    self.btn2.tintColor = self.view.tintColor;
    self.btn1.tintColor = [UIColor whiteColor];
    self.scrV.contentOffset = CGPointMake(kScreenWidth * 5, 0);
    self.countL.text = @"6/12";
    self.content.text = self.messegeAray[5];
}

- (void)showAction:(UITapGestureRecognizer *)tap{
    if (!self.isShow) {
        for (UIView *view in self.view.subviews) {
            view.hidden = YES;
        }
        tap.view.hidden = NO;
    }else{
        for (UIView *view in self.view.subviews) {
            view.hidden = NO;
        }
    }
    self.isShow = !self.isShow;
}

- (void)bigAction:(UITapGestureRecognizer *)tap{
    NSLog(@"222");
    [tap.view setTransform:CGAffineTransformScale(tap.view.transform, 1.5, 1.5)];
    
}














@end
