//
//  ViewController.m
//  AVFunction
//
//  Created by shoule on 2018/8/23.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self speakWithMessage];
}

-(void)speakWithMessage{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC{
        NSLog(@"unwindSegue %@", unwindSegue);
}

@end
