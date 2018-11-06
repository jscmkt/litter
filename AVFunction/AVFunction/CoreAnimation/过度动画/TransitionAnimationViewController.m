//
//  TransitionAnimationViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/17.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "TransitionAnimationViewController.h"
#define kImageCount 8
@interface TransitionAnimationViewController ()
@property(nonatomic,strong)UIImageView *myImageView;
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation TransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.myImageView.image = [UIImage imageNamed:@"00"];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_myImageView];
    //添加手势
    UISwipeGestureRecognizer* leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer* rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

#pragma mark - 向左滑动浏览下张图片
- (void)leftSwipe:(UISwipeGestureRecognizer*)gesture {
    [self transitionAnimtion:YES];
}

#pragma mark - 向右滑动浏览上张图片
- (void)rightSwipe:(UISwipeGestureRecognizer*)gesture {
    [self transitionAnimtion:NO];
}

-(void)transitionAnimtion:(BOOL)flag{
    //1.创建转场动画对象
    CATransition *transition = [[CATransition alloc]init];
    //2.设置动画类型
    transition.type = @"cube";
    //设置子类型
    if (flag) {
        transition.subtype = kCATransitionFromRight;
        
    }else transition.subtype = kCATransitionFromLeft;
    
    //设置转场动画时长
    transition.duration = 1.0f;
    //3.设置专场动画后，给新视图添加转场动画化
    self.myImageView.image = [self getImage:flag];
    [self.myImageView.layer addAnimation:transition forKey:@"abc"];
    
    
}
- (UIImage*)getImage:(BOOL)flag {
    if (flag) {
        self.currentIndex = (self.currentIndex + 1)%kImageCount;
        
    }else {
        self.currentIndex = (self.currentIndex - 1 + kImageCount)%kImageCount;
    }
    return [UIImage imageNamed:[NSString stringWithFormat:@"0%ld",self.currentIndex]];
    
}

@end
