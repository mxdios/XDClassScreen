//
//  XDClassBtn.m
//  XDClassScreen
//
//  Created by miaoxiaodong on 16/7/22.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "XDClassBtn.h"
#import "UIView+Frame.h"

@implementation XDClassBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeLeft;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.backgroundColor = [UIColor whiteColor];
        [self setImage:[UIImage imageNamed:@"classdown"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"classright"] forState:UIControlStateSelected];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.width * 0.4;
    CGFloat imageH = self.height;
    CGFloat imageX = self.width * 0.5 + 8;
    return CGRectMake(imageX, 0, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = self.width * 0.5;
    CGFloat titleH = self.height;
    return CGRectMake(0, 0, titleW, titleH);
}

@end
