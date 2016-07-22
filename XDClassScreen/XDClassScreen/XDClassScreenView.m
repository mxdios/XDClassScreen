//
//  XDClassScreenView.m
//  XDClassScreen
//
//  Created by miaoxiaodong on 16/7/22.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "XDClassScreenView.h"
#import "XDClassBtn.h"
#import "UIView+Frame.h"
#define kRedColor [UIColor colorWithRed:0.83 green:0.00 blue:0.07 alpha:1.00]
#define kBgGrayColor [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00]
#define XDViewWidth [UIScreen mainScreen].bounds.size.width
#define XDViewHeight [UIScreen mainScreen].bounds.size.height
#define setAlpColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation XDClassScreenView
{
    XDClassBtn *_classBtnInn;
    UIView *_classView;
    UIView *_alpBlackBg;
    UIScrollView *_classSubBtnsScrollView;
    UIButton *_classContentBtnInn;
    CGFloat _selfH;
    NSMutableArray *_contentSelectInnArray;//筛选项暂存哪个被选中
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSelfView];
    }
    return self;
}
- (void)setupSelfView
{
    _selfH = self.height;
    _contentSelectInnArray = [NSMutableArray array];
    
    _classView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _classView.backgroundColor = kBgGrayColor;
    [self addSubview:_classView];
    
    _alpBlackBg = [[UIView alloc] initWithFrame:CGRectMake(0, _classView.bottom, self.width, XDViewHeight - self.bottom)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alpBlackBgHidden)];
    [_alpBlackBg addGestureRecognizer:tap];
    _alpBlackBg.backgroundColor = setAlpColor(0, 0, 0, 0.5);
    [self addSubview:_alpBlackBg];
    _alpBlackBg.hidden = YES;
}
- (void)setClassArray:(NSArray *)classArray
{
    _classArray = classArray;
    CGFloat btnW = _classView.width/ classArray.count;
    for (NSInteger i = 0; i < classArray.count; i++) {
        XDClassBtn *btn = [[XDClassBtn alloc] initWithFrame:CGRectMake(btnW * i, 0, btnW, _classView.height)];
        btn.tag = i;
        [btn setTitle:classArray[i][@"classTitle"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_classView addSubview:btn];
        [_contentSelectInnArray addObject:@"0"];//刚开始全部第0个被选中
    }
}
/** 标题按钮点击 */
- (void)classBtnClick:(XDClassBtn *)btn
{
    btn.selected = !btn.selected;
    btn.selected ? [self alpBlackBgShow],[self setupScrollViewBtns:btn.tag] : [self alpBlackBgHidden];
    if (_classBtnInn != btn) {
        _classBtnInn.selected = NO;
    }
    _classBtnInn = btn;
    
}
/** 创建内容按钮 */
- (void)setupScrollViewBtns:(NSInteger)btnTag
{
    _classSubBtnsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _alpBlackBg.width, 0)];
    _classSubBtnsScrollView.backgroundColor = kBgGrayColor;
    [_alpBlackBg addSubview:_classSubBtnsScrollView];
    NSArray *classContents = self.classArray[btnTag][@"classContent"];
    for (NSInteger i = 0; i < classContents.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i * 50, _classSubBtnsScrollView.width, 50)];
        btn.tag = i;
        [btn setTitle:classContents[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:kRedColor forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
        [btn addTarget:self action:@selector(classContentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_classSubBtnsScrollView addSubview:btn];
        if (i == classContents.count - 1) {
            _classSubBtnsScrollView.contentSize = CGSizeMake(_alpBlackBg.width, btn.bottom);
            _classSubBtnsScrollView.height = btn.bottom > _alpBlackBg.height * 0.7 ? _alpBlackBg.height * 0.7 : btn.bottom;
        }
        if (i == [_contentSelectInnArray[btnTag] integerValue]) {
            btn.selected = YES;
            _classContentBtnInn = btn;
            
        }
    }
}

/** 内容按钮点击 */
- (void)classContentBtnClick:(UIButton *)btn
{
    //    if (btn.selected) {
    //        XDLog(@"点自己");
    //        return;
    //    }
    _classContentBtnInn.selected = NO;
    [_classContentBtnInn.subviews.lastObject removeFromSuperview];
    btn.selected = YES;
    _classContentBtnInn = btn;
    
    _contentSelectInnArray[_classBtnInn.tag] = [NSString stringWithFormat:@"%ld", btn.tag];
    
    if ([self.delegate respondsToSelector:@selector(classScreenViewSelectBtnTag:selectText:selectContentBtnTag:)]) {
        [self.delegate classScreenViewSelectBtnTag:_classBtnInn.tag selectText:btn.titleLabel.text selectContentBtnTag:btn.tag];
    }
    [self alpBlackBgHidden];
}
- (void)alpBlackBgHidden
{
    _alpBlackBg.hidden = YES;
    self.height = _selfH;
    _classBtnInn.selected = NO;
    [_classSubBtnsScrollView removeFromSuperview];
}
- (void)alpBlackBgShow
{
    _alpBlackBg.hidden = NO;
    self.height = XDViewHeight - self.y;
    [_classSubBtnsScrollView removeFromSuperview];
    
}
- (void)dealloc
{
    self.delegate = nil;
}


@end
