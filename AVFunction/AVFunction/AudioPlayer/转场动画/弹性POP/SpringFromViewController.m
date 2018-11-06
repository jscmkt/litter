//
//  SpringFromViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "SpringFromViewController.h"
#import "SpringToViewController.h"
#import "SpringTransitionAnimation.h"
@interface SpringFromViewController ()<UIViewControllerTransitioningDelegate>
@property(nonatomic,strong)UIButton *leftItem;
@property(nonatomic,strong)UIButton *presentNextController;

@end

@implementation SpringFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sccnn"]];
    imgVIew.frame = CGRectMake((self.view.frame.size.width-250)/2, 74, 250, 250);
    imgVIew.layer.cornerRadius = 10;
    imgVIew.layer.masksToBounds = YES;
    [self.view addSubview:imgVIew];
    
    [self.view addSubview:self.presentNextController];
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


#pragma mark -
-(UIButton *)presentNextController{
    
    if (!_presentNextController) {
        
        _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
        _presentNextController.frame = CGRectMake(138,423,100, 20);
        [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_presentNextController setTitle:@"弹性POP" forState:UIControlStateNormal];
        [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentNextController;
}


-(void)presentNextControllerClicked{
    
    SpringToViewController *  springToViewController =[[SpringToViewController alloc]init];
//    springToViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//    springToViewController.transitioningDelegate = self;
    [self presentViewController:springToViewController animated:YES completion:NULL];
}

-(void)backClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**/
@end
