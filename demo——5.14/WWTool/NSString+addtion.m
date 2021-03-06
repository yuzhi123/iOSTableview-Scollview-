//
//  NSString+addtion.m
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/8/21.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//

#import "NSString+addtion.h"
#import "WWHeader.h"
@implementation NSString (addtion)

//单行字符串获取长度
-(CGSize)stringLengthwithFont:(CGFloat)font
{
      CGSize stringSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
     return stringSize;
}

//多行字符串获取高度
-(CGSize)stringHightwithfont:(NSInteger)font withWidth:(CGFloat)width
{
    CGSize stringSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return stringSize;
}

//判断字符串中是否含有中文
-(BOOL)checkIsChinese:(NSString *)string
{
    for (int i=0; i<string.length; i++)
    {
        unichar ch = [string characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5)
        {
            return YES;
        }
    }
    return NO;
}

//获得字符串的长度（一个汉字两个字节）
-(NSUInteger) unicodeLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

//phone text (中间字符代替) 参数一，起始位置，参数二，参数3，需要代替的字符串
-(NSString*) phoneString:(NSInteger)BeginIndex andlength:(NSInteger)length andReplaceChar:(NSString*)str
{
    NSString* newStr = str;
    for (int i = 0; i<length-1; i++) {
        [newStr stringByAppendingString:str];
    }
    NSString* strMy = self;
    NSMutableString * str1 = [NSMutableString stringWithString:strMy];
    [str1 replaceCharactersInRange:NSMakeRange(BeginIndex, length) withString:newStr];
    return str1;
}

// label  用于设置label的行高，注意需要设置label的各种属性，大小，来限定大小 1.行间距 2.行数 3 label
-(UILabel*)labelLineSpace:(NSInteger) lineSpace withlines:(NSInteger)lines withLabel:(UILabel*)label
{
    
    label.numberOfLines = 2;
    
    NSString* textStr = label.text;
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    label.attributedText = attributedString;
    // 设置省略号
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    [label sizeToFit];
    return label;
    
}



@end
