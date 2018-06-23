//
//  ViewController.m
//  demo——5.14
//
//  Created by koudaishu on 2018/5/14.
//  Copyright © 2018年 zkl. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "WWTableVGroupsControllerViewController.h"
#import "ChildVC.h"
#import "webV.h"
#import "Masonry.h"

@interface ViewController ()


@end

@implementation ViewController



#pragma mark -- viewDidload
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    WWTableVGroupsControllerViewController* vc = [[WWTableVGroupsControllerViewController alloc]init];
    UIView* headV =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    headV.backgroundColor = [UIColor blueColor];
    NSArray* topItemArray = @[@"瑞萌萌",@"托儿所",@"娃娃鱼",@"儿童劫",@"卡牌"];
    NSMutableArray* controllersArray = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        if (!(i%2)) {
            ChildVC* vc = [[ChildVC alloc]init];
            [controllersArray addObject:vc];
        }
        else{
            webV* vc = [[webV alloc]init];
           [controllersArray addObject:vc];
        }
       
    }
    [vc initWithHeadV:headV andTopVItem:topItemArray andTopViewSize:CGSizeMake(WIDTH, 80) andSubController:controllersArray andTopVItemMaxCount:4 andItemSpace:0 andItemLaneVSize:CGSizeMake(70, 2)];
//    UIView* redV = [[UIView alloc]initWithFrame:CGRectZero];
//    [vc.itemV addSubview:redV];
//    redV.backgroundColor = [UIColor redColor];
//    [redV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//        make.centerY.mas_equalTo(vc.itemV);
//        make.right.mas_equalTo(vc.itemV.mas_right).offset(-10);
//    }];
    vc.itemV.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    // item选中回调此处对子vc进行数据处理
    vc.selectItemBlock = ^(NSInteger slectIndex) {
        
    };
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
