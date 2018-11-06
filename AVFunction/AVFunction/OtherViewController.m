//
//  OtherViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/3.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "OtherViewController.h"
#import "TransionViewController.h"
#import "CortAnimationTableViewController.h"
#import "SqliteViewController.h"
@interface OtherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *VCdict;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _VCdict = @{@"转场动画":[TransionViewController new],@"coreAnimation":[CortAnimationTableViewController new],@"sqlite操作":[SqliteViewController new]};
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _VCdict.allKeys.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = _VCdict.allKeys[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self presentViewController:(UIViewController*)_VCdict.allValues[indexPath.row] animated:YES completion:nil];
}
@end
