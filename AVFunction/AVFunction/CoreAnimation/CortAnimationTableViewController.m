//
//  CortAnimationTableViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/12.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "CortAnimationTableViewController.h"
#import "ProgressLayerViewController.h"
#import "FlowViewController.h"
#import "CALayerDefaultAnimationViewController.h"
#import "CALayerDrawInRectViewController.h"
#import "CustomLayerDrawInRectViewController.h"
#import "BaseAnimeViewController.h"
#import "KeyFrameAnimationViewController.h"
#import "AnimationGroupViewController.h"
#import "TransitionAnimationViewController.h"
#import "CADisplaylinkAnimationViewController.h"
#import "AnimationFromUIVIewViewController.h"
#import "KeyFrameAnimationFromUIView.h"
#import "TransitionAnimationFromView.h"
#import "ModelLayerAndPresentationLayer.h"
#import "CAShapeLayerViewController.h"
#import "BezierAnimationViewController.h"
#import "VectorViewController.h"
#import "GradientLayerViewController.h"
#import "BounceSpringEffectViewController.h"
#import "LoginSpringBounceViewController.h"
@interface CortAnimationTableViewController ()
@property(nonatomic)NSDictionary *DataDict;
@end

@implementation CortAnimationTableViewController
-(void)backPresent{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, -40, 50, 20);
    [backBtn setTitle:@"back" forState:(UIControlStateNormal)];
    [backBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backPresent) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    self.tableView.contentInset = UIEdgeInsetsMake(100,0 ,100,0);
    
    
    
    self.DataDict = @{@"自定义progressView":@"ProgressLayerViewController",@"注水动画":@"FlowViewController",@"CALayer基础属性":@"CALayerDefaultAnimationViewController",@"圆角阴影":@"CALayerDrawInRectViewController",@"自定义图层绘制":@"CustomLayerDrawInRectViewController",@"基础动画":@"BaseAnimeViewController",@"关键帧动画":@"KeyFrameAnimationViewController",@"动画组":@"AnimationGroupViewController",@"过场动画":@"TransitionAnimationViewController",@"逐帧动画":@"CADisplaylinkAnimationViewController",@"UIView基础动画":@"AnimationFromUIVIewViewController",@"UIView关键帧动画":@"KeyFrameAnimationFromUIView",@"UIView转场动画":@"TransitionAnimationFromView",@"CALayer模型层和展示层":@"ModelLayerAndPresentationLayer",@"CAShapeLayer绘制":@"CAShapeLayerViewController",@"BezierPathAnimation":@"BezierAnimationViewController",@"向量绘制":@"VectorViewController",@"渐变进度条绘制":@"GradientLayerViewController",@"图形抖动":@"BounceSpringEffectViewController",@"登录抖动":@"LoginSpringBounceViewController"};
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.DataDict.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
        
    }
    
    cell.textLabel.text = self.DataDict.allKeys[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self presentViewController:(UIViewController*)self.DataDict[cell.textLabel.text] animated:YES completion:nil];
    Class class = NSClassFromString(self.DataDict[cell.textLabel.text]);
    if ([[class new] isKindOfClass:[UIViewController class]]) {
        UIViewController * VC = [class new];
        [self presentViewController:VC animated:YES completion:nil];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
