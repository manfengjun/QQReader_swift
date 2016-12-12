//
//  LFJCircleProgressView.m
//  QQReader_objc
//
//  Created by huwei on 2016/12/5.
//  Copyright © 2016年 JUN. All rights reserved.
//

#import "LFJCircleProgressView.h"
static CGFloat radiusFromAngle(CGFloat angle) {
    return (angle * M_PI)/180;
}
@interface LFJCircleProgressView()
@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UIImageView *imageView;
@end
@implementation LFJCircleProgressView
- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit
{
    _trackBackgroundColor = [UIColor lightGrayColor];
    _trackColor = [UIColor blueColor];
    _lineWidth = 10;
    _lineCap = kCGLineCapRound;
    _beginAngle = radiusFromAngle(-90);
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressLabel];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat slideLength = self.bounds.size.width;
    
    self.progressLabel.frame = CGRectMake(_lineWidth, _lineWidth, slideLength - 2*_lineWidth, slideLength - 2*_lineWidth);
}
- (void)setProgress:(CGFloat)progress
{
    if (progress > 1 || progress < 0) {
        return;
    }
    _progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    // 获取当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGFloat slideLength = self.bounds.size.width;
    CGFloat centerX = slideLength/2;
    CGFloat centerY = slideLength/2;
    // 添加背景轨道
    CGContextAddArc(currentContext, centerX, centerY, (slideLength-_lineWidth)/2, 0, 2*M_PI, 0);
    // 设置轨道宽度
    CGContextSetLineWidth(currentContext, self.lineWidth); // 设置背景颜色
    [self.trackBackgroundColor setStroke];
    // 绘制轨道
    CGContextStrokePath(currentContext);
    // 进度条轨道
    CGFloat deltaAngle = _progress*2*M_PI;
    // 根据进度progress的值绘制进度条
    // 注意: 角度需要使用弧度制
    // 设置圆心x, y坐标
    // 设置圆的半径 -- 这里需要的自然是(边长-轨道宽度)/2
    // 从beginAngle 绘制到endAngle= beginAngle+deltaAngle;
    CGContextAddArc(currentContext, centerX, centerY, (slideLength-_lineWidth)/2, self.beginAngle, self.beginAngle+deltaAngle, self.clickWise);
    // 设置进度条颜色
    [self.trackColor setStroke];
    // 设置轨道宽度
    CGContextSetLineWidth(currentContext, _lineWidth);
    // 设置轨道端点的样式
    CGContextSetLineCap(currentContext, _lineCap);
    // 使用stroke方式填充路径
    CGContextStrokePath(currentContext);
}
#pragma mark ------ 懒加载
- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 9;
        imageView.backgroundColor = [UIColor blueColor];
        _imageView = imageView;
    }
    return _imageView;
}
- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        UILabel *progressLabel = [[UILabel alloc] init];
        progressLabel.textColor = self.trackColor;
        progressLabel.backgroundColor = [UIColor clearColor];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        progressLabel.text = @"0.0%";
        _progressLabel = progressLabel;
    }
    return _progressLabel;
}
@end
