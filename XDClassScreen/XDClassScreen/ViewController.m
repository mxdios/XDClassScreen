//
//  ViewController.m
//  XDClassScreen
//
//  Created by miaoxiaodong on 16/7/22.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "XDClassScreenView.h"
#import "UIView+Frame.h"

@interface ViewController ()<XDClassScreenViewDelegate>
{
    UILabel *_testLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    
    _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 40)];
    _testLabel.font = [UIFont systemFontOfSize:30];
    _testLabel.textColor = [UIColor redColor];
    _testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_testLabel];
    
    XDClassScreenView *classScreenView = [[XDClassScreenView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 40)];
    classScreenView.delegate = self;
    [self.view addSubview:classScreenView];
    
    NSDictionary *dict1 = @{@"classTitle" : @"积分", @"classContent" : @[@"1分",@"2分",@"3分",@"4分",]};
    NSDictionary *dict2 = @{@"classTitle" : @"排序", @"classContent" : @[@"从高到低",@"从多到少",@"从少到多",@"从大到小",@"从无到有",@"从你到我",]};
    NSDictionary *dict3 = @{@"classTitle" : @"种类", @"classContent" : @[@"水果",@"汽车",@"飞机",@"蔬菜",@"书本",@"学校",@"轮船",@"动物",@"海洋",@"水",@"老师",@"饭",@"饮料",@"菜馆"]};
    
    classScreenView.classArray = @[dict1, dict2, dict3];
}

- (void)classScreenViewSelectBtnTag:(NSInteger)selectBtnTag selectText:(NSString *)selectText selectContentBtnTag:(NSInteger)selectContentBtnTag
{
    NSLog(@"选中标题tag = %ld, 筛选项文字 = %@, 筛选项tag = %ld", selectBtnTag, selectText, selectContentBtnTag);
    _testLabel.text = [NSString stringWithFormat:@"%@",selectText];
}

@end
