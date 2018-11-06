//
//  SwipeFromViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/7.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "SwipeFromViewController.h"
#import "SwipeToViewController.h"
#import "SwipeTransitionDelegate.h"
@interface SwipeFromViewController ()


@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;
@property(nonatomic,strong) SwipeTransitionDelegate *delegate;
@end

@implementation SwipeFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
    [self.view addSubview:self.presentNextController];
    //添加屏幕边缘滑动手势
    UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizeer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(interactionTransitionRecognizerAction:)];
    //响应右边的滑动事件
    interactiveTransitionRecognizeer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:interactiveTransitionRecognizeer];
}

#pragma mark - UIScreenEdgePanGestureRecognizer
-(void)interactionTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer*)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
        SwipeToViewController *toViewController = [[SwipeToViewController alloc]init];
        SwipeTransitionDelegate *transitionDelegate = self.delegate;
        if ([sender isKindOfClass:UIGestureRecognizer.class]) 
            transitionDelegate.gestureRecognizer = sender;
            transitionDelegate.targetEdge = UIRectEdgeRight;
            toViewController.transitioningDelegate = transitionDelegate;
            toViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:toViewController animated:YES completion:nil];
        
    }
}

-(void)presentNextControllerClicked{
    
    SwipeToViewController   *  ToViewController  = [[SwipeToViewController alloc]init];
    
    SwipeTransitionDelegate * transitionDelegate = self.delegate;
    transitionDelegate.targetEdge = UIRectEdgeRight;
    transitionDelegate.gestureRecognizer = nil;
    
    ToViewController.transitioningDelegate  = transitionDelegate;
    ToViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:ToViewController animated:YES completion:nil];
}

-(SwipeTransitionDelegate *)delegate{
    
    if (!_delegate) {
        
        _delegate =[[SwipeTransitionDelegate alloc]init];
        
    }
    return _delegate;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
