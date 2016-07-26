//
//  CustomView.m

#import "CustomView.h"

#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.width //OPENCENTERX 对应确认是否打开或关闭的分界线。

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithView:(UIView *)contentview parentView:(UIView *)parentview
{
    self = [super initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, contentview.frame.size.width, contentview.frame.size.height)];
    
    if (self) {
        self.contenView = contentview;  // second页view
        self.parentView = parentview;   // brandview页view
        
        [self addSubview:self.contenView];
        
        // 手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:panGestureRecognizer];
        
        // 点击
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
//        [self addGestureRecognizer:tapGestureRecognizer];
        
        // 自定义页起始中心坐标
        openPointCenter = CGPointMake(self.contenView.center.x + 75, self.contenView.center.y);
        
        NSLog(@"openPointCenter x:%f, openPointCenter y:%f",openPointCenter.x, openPointCenter.y);

    }
    
    
    
    return self;
}
// 拖动手势
-(void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    // 获取偏移量
    CGPoint translation = [recognizer translationInView:self.contenView];
    // 自己的起始坐标x 加偏移量
    float x = self.center.x + translation.x;
    NSLog(@"translation x:%f", x);
    NSLog(@"parentView x:%f",self.contenView.center.x);
    // 判断不允许左滑
    if (x < self.contenView.center.x + W/5) {
        x = self.contenView.center.x + W/5;
    }
    // 右滑动的时候 设置中心坐标
    self.center = CGPointMake(x, openPointCenter.y);
    
    // 如果停止拖拽
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        
        [UIView animateWithDuration:0.2 animations:^{
            // 判断拖拽到的位置 设置回左边还是右边
            if (x < openPointCenter.x + 150) {
                self.center = openPointCenter;
            }else{
                self.frame = CGRectMake(375, 0, 375/5*4, self.contenView.frame.size.height);
                // 视图回到右侧 清除
                [self removeFromSuperview];

            }
            
            
        }];
        
//        [self.contenView removeFromSuperview];
    }
         
    [recognizer setTranslation:CGPointZero inView:self.parentView];
}

//-(void) handleTap:(UITapGestureRecognizer*) recognizer
//{
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        self.center = CGPointMake(openPointCenter.x - OPENCENTERX,
//                                  openPointCenter.y);
//    }];
//    
//    
//}
@end
