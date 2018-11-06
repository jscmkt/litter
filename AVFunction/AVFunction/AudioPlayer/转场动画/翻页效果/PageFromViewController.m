//
//  PageFromViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/11.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "PageFromViewController.h"
#import "PageToViewController.h"
#import "PageAnimation.h"

@interface PageFromViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;

@end

@implementation PageFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
    
    self.view.backgroundColor =[UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sccnn"]];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    [self.view addSubview:self.presentNextController];
    
}


-(void)presentNextControllerClicked{
    
    PageToViewController *  pushVC =[[PageToViewController alloc]init];
    self.navigationController.delegate = pushVC;
    [self.navigationController pushViewController:pushVC animated:YES];
}


-(void)backClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
////    [[PageAnimation alloc]initWith:operation == UINavigationControllerOperationPush ? Push_type : Pop_type];
//}

@end
