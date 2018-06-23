//
//  UIView+Addtion.m
//  demo——5.14
//
//  Created by koudaishu on 2018/5/24.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import "UIViewController+Addtion.h"
#import <objc/runtime.h>

static NSString *WWSCKey = @"WWSCKey";

@implementation UIViewController (Addtion)


-(void)setWWSC:(UIScrollView *)WWSC{
    objc_setAssociatedObject(self, &WWSCKey, WWSC, OBJC_ASSOCIATION_RETAIN);
}

-(UIScrollView*)WWSC{
    return objc_getAssociatedObject(self, &WWSCKey);
}


@end
