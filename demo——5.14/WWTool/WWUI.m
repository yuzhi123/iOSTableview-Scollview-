//
//  WWUI.m
//  Demo
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 WangWu. All rights reserved.
//

#import "WWUI.h"
#import <UIKit/UIKit.h>
#import "UIView+Addition.h"
#import "UIImage+WWaddtion.h"

@implementation WWUI
+(UILabel*)creatLabel:(CGRect)cg backGroundColor:(UIColor*)bgColor textAligment:(NSInteger)alignment font:(UIFont*)font textColor:(UIColor*)textColor text:(NSString*)text
{
    UILabel* label = [[UILabel alloc]initWithFrame:cg];
    
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    label.userInteractionEnabled = YES;
    label.textAlignment = alignment;
    label.font = font;
    label.textColor = textColor;
    label.text = text;
    
    return label;
}

+(UIImageView *)creatImageView:(CGRect)cg backGroundImageV:(NSString *)imageName
{
    UIImageView* imageV = [[UIImageView alloc]initWithFrame:cg];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.userInteractionEnabled = YES;
    return imageV;
}

// 原图展示
+(UIButton*)creatButton:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font originalImage:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title
{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    
    UIImageView* imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [bt addSubview:imv];
  
    imv.center =CGPointMake(bt.width/2, bt.height/2);
    
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}





// 不带高亮
+(UIButton*)creatButton:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title
{
   
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    [bt setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateHighlighted];
    
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}
// 带高亮
+(UIButton*)creatButtonWithHight:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title
{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    [bt setBackgroundImage:[[UIImage imageNamed:backImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    // [bt setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}

// 定制高亮颜色
+(UIButton*)creatButtonWithMyHight:(CGRect)cg hightLightColor:(UIColor*)hightColor targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font nomalColor:(UIColor*)nomalColor title:(NSString*)title
{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitle:title forState:UIControlStateHighlighted];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [bt setBackgroundImage:[UIImage imageWithColor:nomalColor andSize:cg.size] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageWithColor:hightColor andSize:cg.size] forState:UIControlStateHighlighted];
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
  
    return bt;
}




//slider
+(UISlider*)creatSlider:(CGRect)frame andMaxNumber:(float)maxNumber  andMinNUmber:(float)minNunmber andDefuultValue:(float)defaultValue andMinColor:(UIColor*)minColor andMaxColor:(UIColor*)maxColor andThumbColor:(UIColor*) thumbColor andTagdet:(id)target sel:(SEL)sel
{
    UISlider* slider = [[UISlider alloc]initWithFrame:frame];
    [slider addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    slider.minimumValue = minNunmber;
    slider.maximumValue = maxNumber;
    slider.value = defaultValue;
    slider.minimumTrackTintColor = minColor;
    slider.maximumTrackTintColor = maxColor;
    slider.thumbTintColor = thumbColor;
    return slider;
}



@end

