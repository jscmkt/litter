//
//  CustomFromViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "CustomFromViewController.h"
#import "CustomToViewController.h"
#import "CustomPresentationController.h"
@interface CustomFromViewController ()

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;
@end

@implementation CustomFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = randomColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
    [self.view addSubview:self.presentNextController];
    

}


#pragma mark -
-(UIButton *)presentNextController{
    
    if (!_presentNextController) {
        
        _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
        _presentNextController.frame = CGRectMake(138,323,100, 20);
        [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_presentNextController setTitle:@"点击跳转->" forState:UIControlStateNormal];
        [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentNextController;
}


#pragma mark -
-(UIButton *)leftItem{
    
    if (!_leftItem) {
        
        _leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftItem.frame = CGRectMake(0, 0,50, 20);
        [_leftItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftItem setTitle:@"Back" forState:UIControlStateNormal];
        [_leftItem addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftItem;
}


-(void)backClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)presentNextControllerClicked{
    CustomToViewController *ToVC = [[CustomToViewController alloc]init];
    CustomPresentationController *PresrntationVC = [[CustomPresentationController alloc]initWithPresentedViewController:ToVC presentingViewController:self];
    ToVC.transitioningDelegate = PresrntationVC;
    [self presentViewController:ToVC animated:YES completion:nil];
    
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
