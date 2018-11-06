//
//  TransionViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/3.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "TransionViewController.h"
#import "TransionVCCollectLayout.h"
#import "TransionCollectionViewCell.h"
#import "ForithmFromViewController.h"
#import "SwipeFromViewController.h"
#import "CustomFromViewController.h"
#import "RoundDotFromViewController.h"

#import "SpringFromViewController.h"
static NSString * const Identifier = @"collectionView";
@interface TransionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong) NSArray *collectionViewTitleArr;

@end

@implementation TransionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[TransionCollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    
    _collectionViewTitleArr  = @[@"逐渐出现",@"右滑拉动",@"底部卡片",@"弹性POP",@"圆点扩散"/*,@"翻页效果"*/];
    [self.view addSubview:({
        UIButton *btn = [[UIButton alloc]init];
        
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,NAVIGATION_BAR_HEIGHT,100, 50);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        btn;
    })];
}

-(void)presentNextControllerClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TransionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 40;
    cell.titleLabel.text = self.collectionViewTitleArr[indexPath.row];
    return cell;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            // 逐渐显示自定义转场
            ForithmFromViewController * controlller =  [[ForithmFromViewController alloc]init];
            UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
            [self presentViewController:naController animated:YES completion:nil];
        }
            break;

        case 1:{

            // 逐渐显示自定义转场
            SwipeFromViewController * controlller =  [[SwipeFromViewController alloc]init];
            UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
            [self presentViewController:naController animated:YES completion:nil];
        }
            break;
//
        case 2:{

            // 底部卡片自定义转场
            CustomFromViewController * controlller =  [[CustomFromViewController alloc]init];
            UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
            [self presentViewController:naController animated:YES completion:nil];
        }
            break;
        case 3:{

            //弹性POP
            SpringFromViewController * controlller =  [[SpringFromViewController alloc]init];
            UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
            [self presentViewController:naController animated:YES completion:nil];
        }
            break;
        case 4:{

            //圆点扩散
            RoundDotFromViewController * controlller =  [[RoundDotFromViewController alloc]init];
            UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
            [self presentViewController:naController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        TransionVCCollectLayout * layout = [[TransionVCCollectLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor =[UIColor whiteColor];
    }
    return _collectionView;
}

@end
