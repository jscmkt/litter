//
//  CADisplaylinkAnimationViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/17.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "CADisplaylinkAnimationViewController.h"

@interface CADisplaylinkAnimationViewController ()
@property(nonatomic,strong)CALayer *fishLayer;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSMutableArray *image;
@end

@implementation CADisplaylinkAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.view.backgroundColor = [UIColor blackColor];
    
    //创建图像显示图层
    self.fishLayer = [[CALayer alloc]init];
    self.fishLayer.bounds = CGRectMake(0, 0, 250, 250);
    self.fishLayer.position = CGPointMake(160, 150);
    self.fishLayer.contents = (id)[UIImage imageNamed:@"timg_0001"].CGImage;
    self.fishLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.fishLayer];
    
    //由于鱼的图片在循环中会不断创建，而几张图片相对较小
    //与其在循环中不断创建UIImage不如直接将所有图片缓存起来
    self.image = [NSMutableArray array];
    for (int i=0 ; i<8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"timg_000%i",i];
        UIImage *image = imageName.image;
        [self.image addObject:image];
        
    }
    //定义时钟对象
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(stepFish)];
    //将时钟对象加入到朱运行循环RunLoop中
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    UIImageView*animTmageView = [[UIImageView alloc]initWithFrame:CGRectMake(100	, 400, 250, 250)];
    animTmageView.animationImages = self.image;
    animTmageView.animationDuration = 0.8;
    [animTmageView startAnimating];
    [self.view addSubview:animTmageView];
}

#pragma  mark 每次屏幕刷新就会执行一次此方法(每秒接近60次)
-(void)stepFish{
    //定义一个变量记录执行的次数
    static int s = 0;
    //每秒执行6次
    if (++s%6==0) {
        UIImage *image = self.image[self.index];
        self.fishLayer.contents = (id)image.CGImage;
        self.index = (self.index+1)%8;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
