//
//  NSString+Emoji.m
//  EmojiTest
//
//  Created by 1 on 2017/2/10.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "NSString+Emoji.h"

@implementation NSString (Emoji)

//判断是否为emoji
- (BOOL)isEmoji{
    const unichar high = [self characterAtIndex:0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff && self.length >= 2) {
        const unichar low = [self characterAtIndex:1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}


//转成UTF16（只转表情）
- (NSString *)emojiStrToUTF16{
    if (self.length <= 1) {
        return self;
    }
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         if (![self isEmoji:substring]) {
             return ;
         }
         NSString *hexstr = @"";
         for (int i=0;i< [substring length];i++)
         {
             hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"\\u%1X",[substring characterAtIndex:i]]];
         }
         
         [str replaceCharactersInRange:substringRange withString:hexstr];
     }];
    
    return [str lowercaseString];
}


//utf16转emoji
- (NSString *)utf16StrToEmoji{
    NSMutableString *emojiUTF16 = [NSMutableString stringWithString:self];
    
    NSString *hexstr = @"";
    for (int i=0;i< [emojiUTF16 length];i++)
    {
        unichar c = [emojiUTF16 characterAtIndex:i];
        
        NSString *specialStr = [NSString stringWithFormat:@"%C",c];
        
        if ([self deptIdInputShouldAlphaNum:specialStr] || c < 256) {
            hexstr = [hexstr stringByAppendingFormat:@"%@",specialStr];
        } else {
            //汉字和非法字符(中)转UTF-16
            hexstr = [hexstr stringByAppendingString:[NSString stringWithFormat:@"\\u%1X",[emojiUTF16 characterAtIndex:i]]];
        }
    }
    //emoji
    hexstr = [NSString stringWithCString:[hexstr cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    
    return hexstr;
}


//判断是否为emoji
- (BOOL)isEmoji:(NSString *)str{
    const unichar high = [str characterAtIndex:0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff && self.length >= 2) {
        const unichar low = [str characterAtIndex:1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

//判断是否是纯数字和字母
- (BOOL) deptIdInputShouldAlphaNum:(NSString *)str
{
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

@end
