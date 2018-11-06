//
//  JBounceView.h
//  AVFunction
//
//  Created by shoule on 2018/10/9.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JBounceView;
typedef void(^JBounceViewDidClickAction)(JBounceView *bounceView);
@interface JBounceView : UIView
/**
 * 视图内容的frame，center和实际的center一样，狂傲分别比实际的狂宽高少2interval，这个社实际frame的间隔用来缓冲弹性效果
 */
@property (nonatomic, assign) CGRect contentsFrame;

/**
 *  弹性缓冲的距离，也就是contents边界和实际frame边界的距离
 */
@property (nonatomic, assign) CGFloat interval;
/**
 * view的点击事件处理block
 */
@property(nonatomic,copy) JBounceViewDidClickAction clickAction;
/**
 * contentsFrame基于自身坐标系的frame
 */
@property(nonatomic,assign,readonly) CGRect privateContentsFrame;

-(instancetype)initWithContentsFrame:(CGRect)frame interval:(CGFloat)interval;

@end
