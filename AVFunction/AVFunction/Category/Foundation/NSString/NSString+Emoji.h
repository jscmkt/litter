//
//  NSString+Emoji.h
//  EmojiTest
//
//  Created by 1 on 2017/2/10.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

//是否为emoji
- (BOOL)isEmoji;

/**
 emoji转成UTF16
 
 !川@&@^👩🏿‍🎓123
 
 /ud83d/ude00!川@&@^/ud83d/udc69/ud83c/udfff/u200d/ud83c/udf93123

 @return NSString
 */
- (NSString *)emojiStrToUTF16;

/**
 utf16转emoji
 
 \\ud83d\\ude04ss我的
 
 😄ss我的
 
 @return NSString
 */
- (NSString *)utf16StrToEmoji;

@end
