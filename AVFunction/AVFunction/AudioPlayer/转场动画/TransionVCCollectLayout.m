//
//  TransionVCCollectLayout.m
//  AVFunction
//
//  Created by shoule on 2018/9/3.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "TransionVCCollectLayout.h"

@implementation TransionVCCollectLayout
-(void)prepareLayout{
    [super prepareLayout];
    //计算第一组item的个数
    NSInteger countSum = [self.collectionView numberOfItemsInSection:0];
    _attributeArray = [NSMutableArray array];
    //先设置半径
    CGFloat radius = MIN([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width/2);
    CGPoint center = CGPointMake(self.collectionView.width/2, self.collectionView.height/2);
    //设置每一个Ite的属性
    for (int i=0; i<countSum; i++) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attributes.size = CGSizeMake(80, 80);
        
        //shezhi9每一个Item的位置，根据大院的位置设置小圆的位置
        CGFloat x = center.x + ((radius-40)*sin(2*M_PI/countSum*i));
        CGFloat y = center.y + ((radius-40)*cos(2*M_PI/countSum*i));
        attributes.center = CGPointMake(x, y);
        
        [_attributeArray addObject:attributes];
    }
}
//返回属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributeArray;
}
//设置内容区域的大小
-(CGSize)collectionViewContentSize{
    return  self.collectionView.size;
}
@end
