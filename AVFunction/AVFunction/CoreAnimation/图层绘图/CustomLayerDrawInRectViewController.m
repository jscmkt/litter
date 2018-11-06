//
//  CustomLayerDrawInRectViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/14.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "CustomLayerDrawInRectViewController.h"
#import "DrawLayView.h"
@interface CustomLayerDrawInRectViewController ()

@end

@implementation CustomLayerDrawInRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DrawLayView* view = [[DrawLayView alloc]initWithFrame:CGRectMake(140, 140, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249/255.0 alpha:1];
    [self.view addSubview:view];
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
