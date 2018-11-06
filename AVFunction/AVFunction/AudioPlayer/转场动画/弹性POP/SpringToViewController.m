//
//  SpringToViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "SpringToViewController.h"
#import "SpringTransitionAnimation.h"

@interface SpringToViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) UIButton * presentNextController;
@end

@implementation SpringToViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        // 没有设置的话确实会造成presentVC被移除，需要dimiss时再添加（即使不添加也没问题只是会有一个淡出的动画），但是我测试的时候如果设置了的话，dismiss结束后presentVC也消失了
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor yellowColor];
    
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

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [SpringTransitionAnimation new];
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [SpringTransitionAnimation new];
}

@end
