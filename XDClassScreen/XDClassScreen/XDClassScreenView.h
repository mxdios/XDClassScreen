//
//  XDClassScreenView.h
//  XDClassScreen
//
//  Created by miaoxiaodong on 16/7/22.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XDClassScreenViewDelegate <NSObject>
/**
 *  筛选控件代理方法
 *
 *  @param selectBtnTag 筛选标题按钮的tag
 *  @param selectText   点击的筛选项
 *  @param selectContentBtnTag   点击的筛选项的tag
 */
- (void)classScreenViewSelectBtnTag:(NSInteger)selectBtnTag selectText:(NSString *)selectText selectContentBtnTag:(NSInteger)selectContentBtnTag;

@end

@interface XDClassScreenView : UIView
@property (nonatomic, strong)NSArray *classArray;

@property (nonatomic, weak) id<XDClassScreenViewDelegate> delegate;

@end
