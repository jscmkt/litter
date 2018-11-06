//
//  NormalViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/14.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "NormalViewController.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

-(void)backPresent{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 40, 50, 20);
    [backBtn setTitle:@"back" forState:(UIControlStateNormal)];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backPresent) forControlEvents:(UIControlEventTouchUpInside)];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:backBtn];
    [self.view insertSubview:backBtn atIndex:1000];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.layer removeAllAnimations];
    
}
-(void)dealloc{
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
