//
//  EHCircleSlider.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHCircleSlider.h"

#define Angle2Radian(x)     ((x) * M_PI / 180)
#define Radian2Angle(x)     (180 * (x) / M_PI)

@interface EHCircleSlider(){
    BOOL _isOnline;
}

@property (nonatomic, weak) UIImageView *topImageView;
@property (nonatomic, weak) UIImageView *bottomImageView;
@property (nonatomic, weak) CAShapeLayer *maskLayer;
@property (nonatomic, weak) UIImageView *icon;

@end

@implementation EHCircleSlider

#pragma mark -- Life cycle

- (void)setUpSubViews{
    if (!self.bottomImageView) {
        CGRect frame = self.bounds;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        UIImage *img = [UIImage imagePNGName:@"home_yuan_bg"];
        [imageView setImage:img];
        [self addSubview:imageView];
        self.bottomImageView = imageView;
    }
    
    if (!self.topImageView) {
        CGRect frame = self.bounds;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        UIImage *img = [UIImage imagePNGName:@"home_yuan_bg2"];
        [imageView setImage:img];
        [self addSubview:imageView];
        self.topImageView = imageView;
    }
    
    if (!self.icon) {
        CGFloat width = self.topImageView.boundsHeight * 47 / 251;
        CGRect frame = CGRectMake(0, 0, width, width);
        UIImage *img = [UIImage imagePNGName:@"home_yuan_tiao"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setImage:img];
        [self addSubview:imageView];
        self.icon = imageView;
    }
    [self sendSubviewToBack:self.bottomImageView];
    [self insertSubview:self.topImageView aboveSubview:self.bottomImageView];
    [self bringSubviewToFront:self.icon];
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:self.topImageView.center];
    [bPath addArcWithCenter:self.topImageView.center radius:self.boundsHeightHalf startAngle:Angle2Radian(90) endAngle:Angle2Radian(36) clockwise:YES];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setPath:bPath.CGPath];
    shapeLayer.lineCap = kCALineCapRound;
    [shapeLayer setFrame:self.topImageView.bounds];
    [self.topImageView.layer setMask:shapeLayer];
    self.maskLayer = shapeLayer;
}

- (void)initRoutine{
    _maxValue = 100;
    _minValue = 0;
    _currentValue = 45;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib{
    [self initRoutine];
    [self setUpSubViews];
    [self setCurrentValue:self.currentValue];
}

#pragma mark -- Accessor

- (void)setMaxValue:(NSInteger)maxValue{
    NSAssert(maxValue >= self.minValue, @"最大值必须大于等于最小值");
    _maxValue = maxValue;
}

- (void)setMinValue:(NSInteger)minValue{
    NSAssert(minValue <= self.maxValue, @"最小值必须大于等于最大值");
}

- (void)setCurrentValue:(NSInteger)currentValue{
    NSAssert(currentValue <= self.maxValue && currentValue >= self.minValue, @"当前值超过设定的范围");
    _currentValue = currentValue;
    [self currentValueDidChanged];
}

#pragma mark -- Private

- (void)currentValueDidChanged{
    [self updateMaskerLayerPath];
    [self updateIconImageViewPosition];
}

- (UIBezierPath *)bezierPathOfCurrentValue{
    CGFloat startAngle = 0 + 90;
    CGFloat endAngle = 360.0 * self.currentValue / (self.maxValue - self.minValue) + 90;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.topImageView.center];
    [path addArcWithCenter:self.topImageView.center radius:self.topImageView.boundsHeightHalf startAngle:Angle2Radian(startAngle) endAngle:Angle2Radian(endAngle) clockwise:YES];
    return path;
}

- (CGPoint)iconCenterOfCurrentValue{
    
    CGFloat anglePad = 360.0 * self.currentValue / (self.maxValue - self.minValue);     //当前值所偏移的度数
    CGFloat normalAngle = 90 + anglePad;
//    CGFloat angel2Normal = 360.0 - (90 + anglePad);//将角度转换为极坐标中的角度
//    if (angel2Normal < 0) {
//        angel2Normal = 360 + angel2Normal;
//    }
    
    CGPoint circleCenter = self.topImageView.center;                //圆心
    CGFloat radius = self.topImageView.boundsHeightHalf - 10;       //半径
    // 已知圆心(x0, y0)和半径(r)、角度(a)，可求圆上一点(x1, y1), 公式: x1 = x0 + r * cos(a); y1 = y0 + r * sin(a); (PS:计算机中的正余弦函数的参数为弧度，需要注意装换)
    CGFloat radian = Angle2Radian(normalAngle);
    CGFloat x1 = circleCenter.x + radius * cosf(radian);
    CGFloat y1 = circleCenter.y + radius * sinf(radian);
    CGPoint point = CGPointMake(x1, y1);
//    EHLog(@"极坐标角度 = %f",normalAngle);
    
    return point;
}

- (void)updateMaskerLayerPath{
    UIBezierPath *path = [self bezierPathOfCurrentValue];
    self.maskLayer.path = path.CGPath;
}

- (void)updateIconImageViewPosition{
    CGPoint center = [self iconCenterOfCurrentValue];
    [self.icon setCenter:center];
}

- (CGFloat)lengthOfTowPoint:(CGPoint)p1 point2:(CGPoint)p2
{
    CGFloat a = fabsf(p1.x - p2.x);
    CGFloat b = fabsf(p1.y - p2.y);
    return sqrt(a*a + b*b);
}

-(BOOL)isOnLine:(CGPoint) point{
    CGFloat radius = self.topImageView.boundsHeightHalf;
    CGFloat length = [self lengthOfTowPoint:point point2:self.topImageView.center];
    return (length < (radius + self.icon.boundsHeightHalf + 5)) && (length > (radius - self.icon.boundsHeightHalf - 5));
}

- (CGFloat)anglePadOfTouchPoint:(CGPoint)point{
    //根据公式 c^2 = a^2 + b^2 - 2abCos(a);  cos(a) = (a^2 + b^2 - c^2) / 2ab
    CGPoint southPoint = CGPointMake(self.topImageView.centerX, self.topImageView.centerY + self.topImageView.boundsHeightHalf);
    CGFloat a = [self lengthOfTowPoint:self.topImageView.center point2:southPoint];
    CGFloat b = [self lengthOfTowPoint:self.topImageView.center point2:point];
    CGFloat c = [self lengthOfTowPoint:point point2:southPoint];
    CGFloat cosValue = ((a * a) + (b * b) - (c * c)) / (2 * a * b);
    CGFloat radian = acosf(cosValue);
    CGFloat angle = Radian2Angle(radian);
    if (point.x > self.topImageView.centerX) {
        angle = 360 - angle;
    }
    
//    EHLog(@"randian = %f,  angle = %f",radian,angle);
    return angle;
}

- (void)dealWithTouchPoint:(CGPoint)touchPoint{
    CGFloat angleOffSet = [self anglePadOfTouchPoint:touchPoint];
    CGFloat valueRange = (self.maxValue - self.minValue);
    NSInteger value = floorf(angleOffSet * valueRange / 360.0);
    NSInteger pad = fabsf(value - self.currentValue);
    NSInteger perV = (valueRange / 10);
    if (pad > perV) {
        return;
    }
    [self setCurrentValue:value];
}

#pragma mark -- Touche Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if ([self isOnLine:touchPoint]) {
        _isOnline = YES;
        [self dealWithTouchPoint:touchPoint];
    }
//    EHLog(@"%s",__FUNCTION__);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_isOnline) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        [self dealWithTouchPoint:touchPoint];
    }
//    EHLog(@"%s",__FUNCTION__);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_isOnline) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        [self dealWithTouchPoint:touchPoint];
        _isOnline = NO;
    }
//    EHLog(@"%s",__FUNCTION__);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_isOnline) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        [self dealWithTouchPoint:touchPoint];
        _isOnline = NO;
    }
//    EHLog(@"%s",__FUNCTION__);
}


@end
