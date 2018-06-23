//
//  WWTableVGroupsControllerViewController.m
//  demo——5.14
//
//  Created by koudaishu on 2018/5/15.
//  Copyright © 2018年 zkl. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "WWTableVGroupsControllerViewController.h"
#import "UIViewController+Addtion.h"
#import "WWUI.h"
#import "Masonry.h"
#import "NSString+addtion.h"



@interface WWTableVGroupsControllerViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView* SC;
@property (nonatomic,strong)UIScrollView* topSC;
@property (nonatomic,strong)NSMutableArray<WWTableVGroupsControllerViewController*>* subControllerArray;
@property (nonatomic,assign)CGFloat lastContentOffset_Y;
@property (nonatomic,assign)NSInteger currentIndex;// 当前的子试图的序号
@property (nonatomic,strong)NSMutableArray<UIButton*>* itemBTArray;    // 标签栏按钮

@property (nonatomic,strong)UIView* itemLineV;  // 标签栏底部线

@property (nonatomic,strong)UIColor* selectColor;   // 选中颜色
@property (nonatomic,strong)UIColor* normalColor;   // 默认颜色

@property (nonatomic,assign)CGPoint lastOffset; // 当前childvc的offset

// 接受传入的参数
@property (nonatomic,strong)UIView* headV;
@property (nonatomic,strong)NSMutableArray* itemArray;
@property (nonatomic,strong)NSMutableArray<UIViewController*>* controllerArray;
@property (nonatomic,assign)CGSize topSize;
@property (nonatomic,assign)NSInteger maxCount;
@property (nonatomic,assign)CGFloat itmeSpace;
@property (nonatomic,assign)CGSize lineVSize;
@property (nonatomic,assign)CGFloat topHeight;

@property (nonatomic,assign)CGFloat fontSize;  // 文字大小

@end

@implementation WWTableVGroupsControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _fontSize = 15.0;
    self.normalColor = [UIColor lightGrayColor];
    self.selectColor = [UIColor orangeColor];
    self.itemBTArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

#pragma mark -- getter
// childVC 父试图
-(UIScrollView*)SC{
    if (!_SC) {
        _SC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _SC.delegate = self;
        _SC.pagingEnabled = true;
        _SC.contentOffset = CGPointZero;
       
        _SC.contentSize = CGSizeMake(self.controllerArray.count*WIDTH, HEIGHT);
        for (int i = 0; i<self.controllerArray.count; i++) {
            UIViewController* vc = _controllerArray[i];
            vc.view.frame = CGRectMake(i*WIDTH, 0, WIDTH, HEIGHT);
            [self addChildViewController:vc];
            [_SC addSubview:vc.view];
            [vc didMoveToParentViewController:self];
            
            [vc.WWSC addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
           
            self.currentIndex = 0;
        }
       
    }
    return _SC;
}

// childVC标签栏
-(UIScrollView*)topSC{
    if (!_topSC) {
        _topSC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.topSize.width, self.topSize.height)];
        
        UIButton* lastBt;
        for (int i = 0 ; i<self.itemArray.count; i++) {
            UIButton* bt = [WWUI creatButton:CGRectZero targ:self sel:@selector(itemAction:) titleColor:_normalColor font:[UIFont systemFontOfSize:_fontSize] image:nil backGroundImage:nil title:self.itemArray[i]];
            bt.tag = 1200+i;
            [_topSC addSubview:bt];
            [self.itemBTArray addObject:bt];
            
            if (_maxCount) {    // 居中布局
                bt.frame = CGRectMake(i*self.topSize.width/self.maxCount, 0, self.topSize.width/self.maxCount, self.topSize.height);
            }
            else{       // 间距布局
                if (lastBt) {
                    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(lastBt.mas_right).offset(_itmeSpace);
                        make.height.mas_equalTo(self.topSize.height);
                        make.centerY.mas_equalTo(_topSC);
                    }];
                }
                else{
                    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(_itmeSpace/2.0);
                        make.height.mas_equalTo(self.topSize.height);
                        make.centerY.mas_equalTo(_topSC);
                    }];
                }
                lastBt = bt;
            }
            if (_maxCount) {    // 设置_topSC的contentsize
                 _topSC.contentSize = CGSizeMake(self.topSize.width/_maxCount*self.itemArray.count, self.topSize.height);
            }
            else{
                [lastBt mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(_topSC.mas_right).offset(_itmeSpace/2.0);
                }];
            }
            
        }
        // 创建底部lineV
        self.itemLineV = [[UIView alloc]init];
        [_topSC addSubview:_itemLineV];
        NSString* tempTitle = self.itemArray.firstObject;
        CGFloat lineLength = [tempTitle stringLengthwithFont:_fontSize].width;
        self.itemLineV.backgroundColor = self.selectColor;
        _itemLineV.frame = CGRectMake(CGRectGetMidX(self.itemBTArray[0].frame)-lineLength/2.0, self.topSize.height-self.lineVSize.height, lineLength, self.lineVSize.height);
        [self.itemBTArray[0] setTitleColor:self.selectColor forState:UIControlStateNormal];
    }
    return _topSC;
}

#pragma mark -- publicMethod
// 初始化UI
-(void)initWithHeadV:(UIView*)headV
         andTopVItem:(NSArray*)itemArray
      andTopViewSize:(CGSize)topVSize
    andSubController:(NSArray*)controllerArray
 andTopVItemMaxCount:(NSInteger)maxCount
        andItemSpace:(CGFloat)itemSpace
    andItemLaneVSize:(CGSize)lineVSize{
    
    _headV = headV;
    _itemArray = [NSMutableArray arrayWithArray:itemArray];
    _controllerArray = [NSMutableArray arrayWithArray:controllerArray];
    _topSize = topVSize;
    _maxCount = maxCount;
    _itmeSpace = itemSpace;
    _lineVSize = lineVSize;
    _topHeight = headV.frame.size.height + self.topSize.height; //  头部高度
    [self.view addSubview:self.SC];
    _itemV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headV.frame), WIDTH, self.topSize.height)];
    _itemV.backgroundColor = [UIColor yellowColor];
    [_itemV addSubview:self.topSC];
    [self.view addSubview:_itemV];
     [self.view addSubview:_headV];
   
}

-(void)setItmesNormanlColor:(UIColor*)normalColor
             andSelectColor:(UIColor*)selectColor{
    self.normalColor = normalColor;
    self.selectColor = selectColor;
    //颜色处理
    for (int i = 0; i<self.itemArray.count; i++) {
        [self.itemBTArray[i] setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
    [self.itemBTArray[self.currentIndex] setTitleColor:self.selectColor forState:UIControlStateNormal];
    self.itemLineV.backgroundColor = selectColor;
}
#pragma mark -- parviteMethod
// 颜色设置


#pragma mark -- Action
-(void)itemAction:(UIButton*)bt{    //  事件点击
    // 回调处理
    if (self.selectItemBlock) {
        self.selectItemBlock(bt.tag - 1200);
    }
   
    // tableV的contentoffset问题
    CGFloat tableViewLastOffsetY = self.lastOffset.y;
    if (tableViewLastOffsetY <= 0) {
        for (UIViewController *vc in self.controllerArray) {
            if (self.controllerArray[self.currentIndex] != vc) {
                if ([vc.WWSC isMemberOfClass:[UITableView class]]) {
                    vc.WWSC.contentOffset = CGPointMake(0, 0);
                }
                else{
                    vc.WWSC.contentInset = UIEdgeInsetsMake(_topHeight, 0, 0, 0);
                    vc.WWSC.contentOffset = CGPointMake(0, -_topHeight);
                }
            }
        }
    } else if (tableViewLastOffsetY < self.headV.frame.size.height) {
        for (UIViewController *vc in self.controllerArray) {
            if(self.controllerArray[self.currentIndex] != vc){
                
                    if ([vc.WWSC isMemberOfClass:[UITableView class]]) {
                        vc.WWSC.contentOffset = self.lastOffset;
                     //    [self configWithoutDataSouce:vc];  // 解决没有数据源问题
                    }else{
                        vc.WWSC.contentInset = UIEdgeInsetsMake(_topHeight, 0, 0, 0);
                        vc.WWSC.contentOffset = CGPointMake(0,self.lastOffset.y - _topHeight);
                    }
                
            }
        }
    } else {
        for (UIViewController *vc in self.controllerArray) {
            if(self.controllerArray[self.currentIndex] != vc){
                if ([vc.WWSC isMemberOfClass:[UITableView class]]) {
                    vc.WWSC.contentOffset = CGPointMake(0, self.headV.frame.size.height);
                   //  [self configWithoutDataSouce:vc];
                }
                else{
                    vc.WWSC.contentInset = UIEdgeInsetsMake(_topHeight, 0, 0, 0);
                    vc.WWSC.contentOffset = CGPointMake(0, self.headV.frame.size.height-_topHeight);
                }

            }
        }
    }
    
    self.currentIndex = bt.tag - 1200;
    
    
    // 解决当前没有数据源的问题
    [self configWithoutDataSouce:self.controllerArray[self.currentIndex]];
    
    //颜色处理
    for (int i = 0; i<self.itemArray.count; i++) {
        [self.itemBTArray[i] setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
    [bt setTitleColor:self.selectColor forState:UIControlStateNormal];
    [self startAnimation];  // 执行动画
    
    self.SC.contentOffset = CGPointMake((bt.tag-1200)*WIDTH, 0);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    UIScrollView* sc = (UIScrollView*)object;
    if (self.controllerArray[self.currentIndex].WWSC != sc) {
        return;
    }
    if (![object isMemberOfClass:[UITableView class]]) {    // 网页
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if(offset.y<-_topHeight) {
            
            self.headV.frame = CGRectMake(0, 0, self.headV.frame.size.width, self.headV.frame.size.height);
            self.itemV.frame = CGRectMake(0, self.headV.frame.size.height, WIDTH, self.topSize.height);
        }
        else if(offset.y < self.headV.frame.size.height-_topHeight){
            
            self.headV.frame = CGRectMake(0, -offset.y-_topHeight, self.headV.frame.size.width, self.headV.frame.size.height);
            self.itemV.frame = CGRectMake(0, self.headV.frame.size.height-offset.y-_topHeight, WIDTH, self.topSize.height);
            
        }
        else{
            self.headV.frame = CGRectMake(0, -(self.topSize.height+self.headV.frame.size.height), self.headV.frame.size.width, self.headV.frame.size.height);
            self.itemV.frame = CGRectMake(0,0, WIDTH, self.topSize.height);
        }
        self.lastOffset = CGPointMake(0, offset.y + _topHeight);
    }
    else{       // tableView
        if ([keyPath isEqualToString:@"contentOffset"]) {
            
            CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
            if(offset.y<0) {
                
                self.headV.frame = CGRectMake(0, 0, self.headV.frame.size.width, self.headV.frame.size.height);
                self.itemV.frame = CGRectMake(0, self.headV.frame.size.height, WIDTH, self.topSize.height);
            }
            else if(offset.y<self.headV.frame.size.height){
                
                self.headV.frame = CGRectMake(0, -offset.y, self.headV.frame.size.width, self.headV.frame.size.height);
                self.itemV.frame = CGRectMake(0, self.headV.frame.size.height-offset.y, WIDTH, self.topSize.height);
                
            }
            else{
                self.headV.frame = CGRectMake(0, -(self.topSize.height+self.headV.frame.size.height), self.headV.frame.size.width, self.headV.frame.size.height);
                self.itemV.frame = CGRectMake(0,0, WIDTH, self.topSize.height);
            }
            self.lastOffset = offset;
        }
    }
    
}


#pragma mark -- sc代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat tableViewLastOffsetY = self.lastOffset.y;
    if (tableViewLastOffsetY < 0) {
        for (UIViewController *vc in self.controllerArray) {
            if(self.controllerArray[self.currentIndex] != vc){
                if ([vc.WWSC isMemberOfClass:[UITableView class]]) {
                    vc.WWSC.contentOffset = CGPointMake(0, 0);
                }else{
                     vc.WWSC.contentOffset = CGPointMake(0, -_topHeight);
                }
            }
        }
    } else if (tableViewLastOffsetY < self.headV.frame.size.height) {
        for (UIViewController *vc in self.controllerArray) {
            if(self.controllerArray[self.currentIndex] != vc){
                 if ([vc.WWSC isMemberOfClass:[UITableView class]]) {
                    vc.WWSC.contentOffset = self.lastOffset;
                     // [self configWithoutDataSouce:vc];  // 解决没有数据源问题
                 }else{
                      vc.WWSC.contentOffset = CGPointMake(0,self.lastOffset.y - _topHeight);
                 }
            }
        }
    } else {
        for (UIViewController *vc in self.controllerArray) {
            if(self.controllerArray[self.currentIndex] != vc){
                 if ([vc.WWSC isMemberOfClass:[UITableView class]]) {
                      vc.WWSC.contentOffset = CGPointMake(0, self.headV.frame.size.height);
                   // [ self configWithoutDataSouce:vc];
                 }
                 else{
                      vc.WWSC.contentOffset = CGPointMake(0, self.headV.frame.size.height-_topHeight);
                 }
            
             
            }
        }
    }
    
}

// 横向滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.SC) {

    self.currentIndex = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    for (int i = 0; i<self.itemArray.count; i++) {
        [self.itemBTArray[i] setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
    [self.itemBTArray[_currentIndex] setTitleColor:self.selectColor forState:UIControlStateNormal];

        [self startAnimation];  // 执行动画
        
    }
    [self configWithoutDataSouce:self.controllerArray[self.currentIndex]];
}


#pragma mark -- animation
-(void)startAnimation{
    
    UIButton* bt = self.itemBTArray[self.currentIndex];
    NSString* title = self.itemArray[self.currentIndex];
    CGFloat length = [title stringLengthwithFont:15.f].width;
    // 动画处理
    if (bt.frame.origin.x<(self.topSize.width-bt.frame.size.width)/2.0  ) {     // bt不用移动的情况下
        [UIView animateWithDuration:0.2 animations:^{
            self.topSC.contentOffset = CGPointMake(0, 0);
            self.itemLineV.width = length;
            self.itemLineV.center = CGPointMake(bt.center.x, self.itemLineV.center.y);
            
        }];
        
    }
    else if (CGRectGetMidX(bt.frame)>(self.topSC.contentSize.width/2.0)){
        [UIView animateWithDuration:0.2 animations:^{
            self.topSC.contentOffset = CGPointMake(self.topSC.contentSize.width - self.topSize.width, 0);
             self.itemLineV.width = length;
            self.itemLineV.center = CGPointMake(bt.center.x, self.itemLineV.center.y);
            
        }];
        
    }
    else{   // 移动至中间
        
        [UIView animateWithDuration:0.2 animations:^{
            self.topSC.contentOffset = CGPointMake(CGRectGetMidX(self.itemBTArray[_currentIndex].frame) - self.topSize.width/2.0, 0);
            self.itemLineV.width = length;
            self.itemLineV.center = CGPointMake(bt.center.x, self.itemLineV.center.y);
            
        }];
        
    }
    
}

#pragma mark -- 解决没有数据源问题
-(void)configWithoutDataSouce:(UIViewController*)baseVC{
    if (baseVC.WWSC.contentSize.height < baseVC.WWSC.frame.size.height) {        //没有数据源
        if ([baseVC.WWSC isMemberOfClass:[UITableView class]]) {
            baseVC.WWSC.contentOffset = CGPointZero;
        }
        else{
            baseVC.WWSC.contentInset = UIEdgeInsetsMake(_topHeight, 0, 0, 0);
            baseVC.WWSC.contentOffset = CGPointMake(0, -_topHeight);
        }
        self.headV.frame = CGRectMake(0, 0, self.headV.frame.size.width, self.headV.frame.size.height);
        self.itemV.frame = CGRectMake(0, self.headV.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.topSize.height);
    }
    
}


#pragma mark --delloc
- (void)dealloc {
    for (NSInteger i = 0; i < self.controllerArray.count; i++) {
        UIViewController *vc = self.controllerArray[i];
        [vc.WWSC removeObserver:self forKeyPath:@"contentOffset"];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
