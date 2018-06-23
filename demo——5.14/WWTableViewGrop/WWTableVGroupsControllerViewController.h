//
//  WWTableVGroupsControllerViewController.h
//  demo——5.14
//
//  Created by koudaishu on 2018/5/15.
//  Copyright © 2018年 zkl. All rights reserved.
//


/**
 使用须知:
    此vc可作为childvc直接添加于vc上
    对于此vc的childvc必须继承WWBaseChildViewController,
 并且将内部需要监测的scrollview子类赋给myScollview
 */



#import <UIKit/UIKit.h>

typedef void(^SelectItemBlock)(NSInteger slectIndex);

@interface WWTableVGroupsControllerViewController : UIViewController

@property (nonatomic,strong)UIView* itemV;  // 标签栏父试图

// 标签栏选择的回调
@property (nonatomic,copy) SelectItemBlock selectItemBlock;

/**
 @param headV  页面头部试图,需要给定frame
 @param itemArray  底部scrollv对应的标签  数组元素字符串
 @param topVSize   标签栏大小
 @param controllerArray  子试图对象
 @param maxCount   标签栏item一行最大数量 (当设置此数量时,item会采用居中模式,如果数值为0 则采用间距模式) 优先级高于itemSpace
 @param itemSpace  标签栏item之间的间隔
 @param lineVSize  标签栏item下面线条大小
 */

-(void)initWithHeadV:(UIView*)headV
         andTopVItem:(NSArray*)itemArray
      andTopViewSize:(CGSize)topVSize
    andSubController:(NSArray*)controllerArray
 andTopVItemMaxCount:(NSInteger)maxCount
        andItemSpace:(CGFloat)itemSpace
    andItemLaneVSize:(CGSize)lineVSize;

/**
 @param normalColor 标签与文字的默认颜色
 @param selectColor 标签与文字的选中颜色
 */
-(void)setItmesNormanlColor:(UIColor*)normalColor
             andSelectColor:(UIColor*)selectColor;

@end
