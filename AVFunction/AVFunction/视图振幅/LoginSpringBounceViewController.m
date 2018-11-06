//
//  LoginSpringBounceViewController.m
//  AVFunction
//
//  Created by shoule on 2018/10/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "LoginSpringBounceViewController.h"
#import "JBounceView.h"
@interface LoginSpringBounceViewController ()

@end

@implementation LoginSpringBounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    JBounceView * bounceView = [[JBounceView alloc] initWithContentsFrame:CGRectMake(220, 80, 120, 40) interval:10];
    bounceView.clickAction = ^(JBounceView * bounceView) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"登录成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil] show];
        
    };
    [self.view addSubview:bounceView];
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"bg"].CGImage;
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVibrancyEffect * vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = bounceView.bounds;
    [bounceView addSubview:effectView];
    
    UIVisualEffectView * vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    vibrancyEffectView.frame = effectView.bounds;
    [effectView.contentView addSubview:vibrancyEffectView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:bounceView.privateContentsFrame];
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    
    [vibrancyEffectView.contentView addSubview:label];
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
