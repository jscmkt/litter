//
//  CustomToViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "CustomToViewController.h"

@interface CustomToViewController ()

@property(nonatomic,strong) UIButton * presentNextController;
@property(nonatomic,strong) UISlider * slider;
@end

@implementation CustomToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =randomColor;
    [self.view addSubview:self.presentNextController];
    [self.view addSubview:_slider];
    
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
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
