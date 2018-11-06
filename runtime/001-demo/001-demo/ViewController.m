//
//  ViewController.m
//  001-demo
//
//  Created by shoule on 2018/8/16.
//  Copyright © 2018年 WT. All rights reserved.
//
//将真个项目中的=方法都替换掉
//修改方法调用的顺序
/**
 oc 方法
 SEL ->IMP
 
 */
#import "ViewController.h"
#import "Person.h"
#import "NSObject+JSCKVO.h"
#import <objc/message.h>
@interface ViewController ()
@property(nonatomic,strong)Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //oc -> 消息机制
    
//    Person *p = [[Person alloc]init];
//    Person *p = [Person alloc];
//    NSClassFromString(@"")
//    objc_getClass(@"")
//    NSStringFromSelector(@"")
//    sel_registerName(@"")
    /*
    Person *p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    p = [p init];
    objc_msgSend(p, @selector(init));
//    [p performSelector:@selector(eat)];
    //消息发送
    objc_msgSend(p, @selector(eat));
     */
    
//    objc_msgSend(p, @selector(eat),@"xxx");
    Person *p = [[Person alloc]init];
    //添加观察者
    //内部实现：利用runtime 动态创建一个子类，继承Person
    //修改p对象的类型
//    [p addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
//    _p = p;
    
    [p J_addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
    _p=p;
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",change);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int a;
    _p.name = [NSString stringWithFormat:@"%d",a++]
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
