//
//  config.h
//  AVFunction
//
//  Created by shoule on 2018/9/7.
//  Copyright © 2018年 WT. All rights reserved.
//

#ifndef config_h
#define config_h


/** 屏幕宽高 */
#define SCREEN_FRAME        [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
// App Frame Height&Width
#define App_Frame_Height                                [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width                                 [[UIScreen mainScreen] applicationFrame].size.width

// MainScreen bounds
#define Main_Screen_Bounds                              [[UIScreen mainScreen]      bounds]
// MainScreen Height&Width
#define Main_Screen_Height                              [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width                               [[UIScreen mainScreen] bounds].size.width


// view tag
#define TAG                 10000

// 全局边距
#define MARGIN              15

#define MINSPACE            10

// 全局圆角
#define CORNER_RADIUS       5

// 全局cell 以及 一些输入视图框视图的高度
#define CELL_HEIGHT         50

// 全局遮罩透明度
#define GLOBAL_SHADOW_ALPHA 0.5

// textField 左边距
#define TEXTFIELD_LEFTMARGIN 8



// 黑体字体
#define HeiTi_SC                    @"Heiti SC"


// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)    [UIFont                     boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)        [UIFont                     systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)        [UIFont                     fontWithName:(NAME) size:(FONTSIZE)]

/** 随机颜色 */
#define randomColor                 [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
// 字体色彩
#define COLOR_WORD_YELLOW           HEXCOLOR(0xE0BA31)
#define COLOR_WORD_BLACK            HEXCOLOR(0x333333)
#define COLOR_WORD_GRAY_1           HEXCOLOR(0x666666)
#define COLOR_WORD_GRAY_2           HEXCOLOR(0x999999)
#define COLOR_WORD_RED              HEXCOLOR(0xdd0101)
// 背景灰色
#define COLOR_BACK_GRAY             HEXCOLOR(0xF6F6F6)
// 主题色
#define COLOR_MAIN                  HEXCOLOR(0xdd0101)
// 导航栏按钮图片的tinColor
#define COLOR_NAV_BARITEM_TINCOLOR  [UIColor blackColor]
// 线条颜色
#define COLOR_UNDER_LINE            HEXCOLOR(0xC6C6C6)

/** 颜色 */
#define BSKColor(R, G, B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width
#define TextLe      [TextControlSingleton sharedTextControlSingleton]
#define isIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define isIOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define isIOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define IdentifierStr [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define IPADD [SingleExchange getInstance].IPAddress
#define iphone5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone4    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphoneX   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define NavTopHeight (iphoneX ? 88.f : 64.f)

#define  StatusBarHeight      (iphoneX ? 44.f : 20.f)

#define  TabbarSafeBottomMargin        (iphoneX ? 34.f : 0.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iphoneX ? (49.f+34.f) : 49.f)

#endif /* config_h */
