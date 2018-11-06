//
//  RoundDotToViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/11.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "RoundDotToViewController.h"
#import "RoundDotAnimation.h"

@interface RoundDotToViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) UIButton * presentNextController;
@end

@implementation RoundDotToViewController

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"椰香芒芒"]];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    imageView.backgroundColor = [UIColor redColor
//                                ];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    [self.view addSubview:self.presentNextController];
    
}


-(UIButton *)presentNextController{
    
    if (!_presentNextController) {
        
        _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
        _presentNextController.frame = CGRectMake(138,323,100, 20);
        [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_presentNextController setTitle:@"完成" forState:UIControlStateNormal];
        [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentNextController;
}

-(void)presentNextControllerClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return    [[RoundDotAnimation alloc]init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return    [[RoundDotAnimation alloc]init];
    
}

@end
