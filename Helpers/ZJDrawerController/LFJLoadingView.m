//
//  LFJLoadingView.m
//  QQReader_objc
//
//  Created by huwei on 2016/12/5.
//  Copyright © 2016年 JUN. All rights reserved.
//

#import "LFJLoadingView.h"
@interface LFJLoadingView()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UIView *triangleView;
@end
@implementation LFJLoadingView
- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _trackColor = [UIColor redColor];
    _lineWidth = 2;
    _beginAngle = -M_PI_2;
    _lineCap = kCALineCapRound;
    _animateDuration = 2.f;
    self.backgroundColor = [UIColor clearColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.bounds.size.width != 0) {
        [self stopAnimations];
        [self startAnimations];
    }
}
- (void)addAnimations {
    
    if (![self.shapeLayer superlayer]) {
        
        CGFloat width = self.bounds.size.width;
        // 设置圆的轨迹path
        CGPathRef path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:(width - _lineWidth)/2 startAngle:self.beginAngle endAngle:3*M_PI/2 clockwise:YES].CGPath;
//        CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:ovalRect].CGPath;
        // 设置为layer的path
        self.shapeLayer.path = path;
        // 添加进度条轨道
        [self addSubview:self.triangleView];
        [self.layer addSublayer:self.shapeLayer];
//        [self.layer addSublayer:self.circleLayer];
        [self.triangleView.layer addSublayer:self.triangleLayer];
//        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4); // 旋转45度
//        //    transform = CGAffineTransformMakeScale(0.5, 0.5); // 宽高均缩小一半
//        //    transform = CGAffineTransformMakeTranslation(0, 100); // 向下平移100
//        self.triangleLayer.affineTransform = transform;

    }
    
    
    // 动画调整轨道的结束点 ---
    // 设置需要执行动画的属性path
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    // 设置动画的其实点和结束点
    strokeEndAnimation.fromValue = @0;
    strokeEndAnimation.toValue = @1;
    // 设置动画时间
    strokeEndAnimation.duration = 0.5*_animateDuration;
    // 设置动画函数类型
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 动画调整轨道的开始点 相当于清除轨迹,
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @0;
    strokeStartAnimation.toValue = @1;
    // 时间比绘制时少, 看上去清除比较快
    strokeStartAnimation.duration = 0.5*_animateDuration;
    // 设置动画开始时间 在上面的动画执行完毕后在执行 --- 看上去就像是在清除轨道
    strokeStartAnimation.beginTime = 0.5*_animateDuration;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    // 设置包含的动画, 先后顺序由设置的beginTime决定
    groupAnimation.animations = @[strokeEndAnimation,strokeStartAnimation];
    // 组动画执行时间 == 上面两个动画时间之和
    groupAnimation.duration = 1.0*_animateDuration;
    // 重复次数 设置为无限大
    groupAnimation.repeatCount = MAXFLOAT;
    // 设置模式
    groupAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = @0.0;
    rotation.toValue = @(2 * M_PI);
    rotation.duration = 1.0*_animateDuration;
    rotation.repeatCount = MAXFLOAT;
    [self.triangleView.layer addAnimation:rotation forKey:@"roration"];
    
    [self.shapeLayer addAnimation:groupAnimation forKey:@"group"];
    
    
}
- (void)stopAnimations {
    [self.shapeLayer removeAllAnimations];
    [self.layer removeAllAnimations];
}

- (void)startAnimations {
    [self addAnimations];
}
- (CAShapeLayer *)shapeLayer {
    if(!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.lineCap = _lineCap;
        shapeLayer.lineWidth = _lineWidth;
        shapeLayer.strokeColor = _trackColor.CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeStart = 0.0;
        shapeLayer.strokeEnd = 1.0;
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}
- (CAShapeLayer *)triangleLayer
{
    if (!_triangleLayer) {
        CGPoint center = CGPointMake(self.triangleView.frame.size.width/2, self.triangleView.frame.size.width/2);
        CGPoint point1 = CGPointMake(center.x - 10, center.x - 10);
        CGPoint point2 = CGPointMake(center.x - 10, center.x + 10);
        CGPoint point3 = CGPointMake(center.x + 10, center.x);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:point1];
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        [path closePath];
        CAShapeLayer *triangleLayer = [CAShapeLayer layer];
//        triangleLayer.lineCap = _lineCap;
//        triangleLayer.lineWidth = _lineWidth;
        triangleLayer.fillColor = [UIColor redColor].CGColor;
        triangleLayer.strokeColor = _trackColor.CGColor;
        triangleLayer.path = path.CGPath;
        _triangleLayer = triangleLayer;
    }
    return _triangleLayer;
}
- (UIView *)triangleView
{
    if (!_triangleView) {
        CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
        _triangleView = [[UIView alloc] initWithFrame:CGRectMake(center.x - 20, center.y - 20, 40, 40)];
    }
    return _triangleView;
}
- (CAShapeLayer *)circleLayer
{
    if (!_circleLayer) {
        CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
        CAShapeLayer *circleLayer = [CAShapeLayer new];
        circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0,0) radius:30 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
        circleLayer.strokeColor = [UIColor greenColor].CGColor;
        circleLayer.fillColor = [UIColor yellowColor].CGColor;
        circleLayer.position = center;
        _circleLayer = circleLayer;
    }
    return _circleLayer;
}
@end
