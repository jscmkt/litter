//
//  ForithmToViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/4.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "ForithmToViewController.h"

@interface ForithmToViewController ()

@property(nonatomic,strong) UIButton * presentNextController;
@end

@implementation ForithmToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    self.view.backgroundColor = [UIColor yellowColor];

    [self.view addSubview:self.presentNextController];
    
}


-(UIButton *)presentNextController{
    
    if (!_presentNextController) {
        
        _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
        _presentNextController.frame = CGRectMake(138,323,100, 20);
        [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_presentNextController setTitle:@"完成" forState:UIControlStateNormal];
        [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _presentNextController;
}

-(void)presentNextControllerClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
