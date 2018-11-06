//
//  TransionCollectionViewCell.m
//  AVFunction
//
//  Created by shoule on 2018/9/3.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "TransionCollectionViewCell.h"

@implementation TransionCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 80, 10)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = 1;
    }
    return _titleLabel;
}
@end
