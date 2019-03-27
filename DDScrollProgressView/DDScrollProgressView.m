//
//  DDScrollProgressView.m
//  DDScrollProgressView
//
//  Created by MaxJ on 2019/3/22.
//  Copyright © 2019年 fizz. All rights reserved.
//

#import "DDScrollProgressView.h"
@interface DDScrollProgressView(){
    CGFloat _width;
    CGFloat _height;
    BOOL _isLockCycleRotate;
}
//@property (nonatomic,strong) NSArray* startPathPointA;
@property (nonatomic,assign) NSInteger segmentCounts;
@property (nonatomic,assign) CGFloat ignoreRadian;
@property (nonatomic,assign) CGFloat paintToRadian;// [+] base line is centre negative vertical line
@property (nonatomic,assign) CGFloat perSegmentRadian;
@property (nonatomic,assign) CGFloat sections;
@property (nonatomic,strong) UIImageView* centreImageView;
@end
@implementation DDScrollProgressView

-(UIImageView *)centreImageView{
    if (!_centreImageView) {
        CGFloat imageW = self.bounds.size.width - (_heightIncrement + _segmentHeight + 10) * 2;
        CGFloat imgaeH = imageW;
        CGFloat imageX = (self.bounds.size.width - imageW ) * 0.5;
        CGFloat imgaeY = imageX;
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imageX,imgaeY,imageW,imgaeH)];
        imageV.image = [UIImage imageNamed:@"scroll_pan"];
        _centreImageView = imageV;
    }
    return _centreImageView;
}
+(instancetype)DDScrollProgressView:(CGRect)frame{
    DDScrollProgressView * ddView = [[DDScrollProgressView alloc] initWithFrame:frame];
    [ddView initData];
    [ddView addGesture];
    [ddView addSubview:ddView.centreImageView];
    return ddView;
}
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self initData];
//        [self addGesture];
//    }
//    return self;
//}
-(void)initData{
    self.segmentCounts = 50.0f;
    self.ignoreRadian = 95 * 2 * M_PI / 360.0;
    self.sections = 10;
    _segmentHeight = 15;
    _heightIncrement = [self getDefaultIncrementHeight];
    _width = self.frame.size.width - 0;
    _height = self.frame.size.height - 0;
}
-(void)addGesture{
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draggingGesture:)];
    [self addGestureRecognizer:panGesture];
}



-(void)setPaintToRadian:(CGFloat)paintToRadian{
    //valid
    _paintToRadian = paintToRadian < self.ignoreRadian * 0.5 ? self.ignoreRadian * 0.5 : (paintToRadian > M_PI * 2 - self.ignoreRadian * 0.5 ? paintToRadian = M_PI * 2 - self.ignoreRadian * 0.5 : paintToRadian);
    _curScale = [self getMaxVliadPaintIndex];
    [self refreshUI];
    
}

- (CGFloat)perSegmentRadian{
    _perSegmentRadian = (2 * M_PI - self.ignoreRadian) / self.segmentCounts;
    return _perSegmentRadian;
}
-(CGFloat)ignoreRadian{
    if (_ignoreRadian > M_PI * 2) {
        return M_PI * 2;
    }
    return _ignoreRadian;
}
-(void)refreshUI{
    [self.centreImageView setTransform:CGAffineTransformMakeRotation(self.paintToRadian)];
    [self setNeedsDisplay];
}

- (NSInteger)getMaxVliadPaintIndex{
    CGFloat validRaint =  self.paintToRadian >= self.ignoreRadian * 0.5? self.paintToRadian - self.ignoreRadian * 0.5 : 0;
    NSInteger validIdx = round(validRaint / self.perSegmentRadian);
    return validIdx;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     self.layer.shouldRasterize = YES;
    // Drawing code
//    [self testForContructor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawScale:context isShadow:YES];
    [self drawScale:context isShadow:NO];
}
- (void)drawScale:(CGContextRef)context isShadow:(BOOL)isShadow{
    //Changes the origin of the user coordinate system in a context.
    CGContextTranslateCTM(context, self.bounds.size.width / 2, self.bounds.size.height/ 2);
    NSInteger drawToIdx = isShadow ? self.segmentCounts : [self getMaxVliadPaintIndex];
    for (int idx = 0; idx <= drawToIdx; idx ++) {
        CGPoint startP = CGPointMake(0, _height * 0.5 - self.segmentHeight - self.heightIncrement );
        NSInteger sectinD = self.segmentCounts / self.sections;
        CGFloat endY =  idx % sectinD ? startP.y + self.segmentHeight :startP.y + self.segmentHeight + self.heightIncrement;
        CGPoint endP =  CGPointMake(0, endY) ;
        
        UIBezierPath * bePath = [UIBezierPath bezierPath];
        [bePath setLineWidth: idx % sectinD ? 2 : 2.5];
        [bePath moveToPoint:startP];
        [bePath addLineToPoint:endP];
        CGFloat rotateRadian = self.ignoreRadian * 0.5 + self.perSegmentRadian * idx;
        [bePath applyTransform:CGAffineTransformMakeRotation(rotateRadian)];
        //38,148,156
        UIColor * color = isShadow ? [UIColor colorWithRed:38/255.0 green:148/255.0 blue:156/255.0 alpha:1] : [UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        //UIColor * color = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [color setStroke];
        [bePath stroke];
    }
    CGContextTranslateCTM(context, -self.bounds.size.width / 2, -self.bounds.size.height/ 2);
    
}

-(CGFloat)getIgnoreRadian{
    return self.ignoreRadian;
}

#pragma mark - Touch Action
-(void)draggingGesture:(UIPanGestureRecognizer *)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:
            [self setPaintToRadianByScrollPiont:[gesture locationInView:self]];
            if (self.willChangeBlock) self.willChangeBlock(self);
            break;
        case UIGestureRecognizerStateEnded:
            _isLockCycleRotate = NO;
            if (self.didEndChangedBlock) self.didEndChangedBlock(self);
            break;
        default:
            break;
    }
}

- (void)setPaintToRadianByScrollPiont:(CGPoint)point{
    CGPoint validePoint = CGPointMake(point.x - self.centreImageView.center.x,  point.y - self.centreImageView.center.y);
    CGFloat angle = atan2(validePoint.x, validePoint.y);
    if (validePoint.x < 0) { //3 4 quadrant
        angle = -angle;
    }else{
        angle  =  M_PI * 2 - angle;
    }
    //limite cycleRotate
    CGFloat brake = self.ignoreRadian * 0.5 - 0.087;
    if (angle > M_PI * 2 - self.ignoreRadian * 0.5 + brake){
        if (!_isLockCycleRotate) {
            _isLockCycleRotate = YES;
            self.paintToRadian =  M_PI * 2 - self.ignoreRadian * 0.5;
        }
    }
    if (angle < self.ignoreRadian * 0.5 - brake ){
        if (!_isLockCycleRotate) {
            _isLockCycleRotate = YES;
            self.paintToRadian = self.ignoreRadian * 0.5;
        }
    }
    if (!_isLockCycleRotate) {
        self.paintToRadian = angle;
    }
    NSLog(@"validePoint = %@ angle = %f",NSStringFromCGPoint(validePoint),angle);
}
-(CGFloat)getRotationRadianBaseOnPoint:(CGPoint)point{
    CGPoint validePoint = CGPointMake(point.x - self.centreImageView.center.x,  point.y - self.centreImageView.center.y);
//    var angle:Number = Math.atan2(dy, dx);

    CGFloat angle = atan2(validePoint.x, validePoint.y); 
    if (validePoint.x < 0) { //3 4 quadrant
        angle = -angle;
    }else{
      angle  =  M_PI * 2 - angle;
    }
    NSLog(@"validePoint = %@ angle = %f",NSStringFromCGPoint(validePoint),angle);
    return angle;
}

- (CGFloat)getDefaultIncrementHeight{
    return 7.0;
}
#pragma mark - external api
-(NSArray *)getSectionRadians{
    NSMutableArray * radians = [NSMutableArray array];
    for (int idx = 0; idx < self.sections + 1; idx++) {
        [radians addObject:@(self.ignoreRadian * 0.5 + self.perSegmentRadian * self.segmentCounts / self.sections * idx)];
    }
    return radians.copy;
}
-(void)setCurScale:(NSInteger)curScale{
    CGFloat radianMax = curScale * self.perSegmentRadian + self.ignoreRadian * 0.5;
    self.paintToRadian = radianMax;
}
-(void)setCurRadian:(CGFloat)curRadian{
    self.paintToRadian = curRadian;
}

-(void)setIsScaleEqualHeight:(BOOL)isScaleEqualHeight{
    _isScaleEqualHeight  = isScaleEqualHeight;
    _heightIncrement     = isScaleEqualHeight ? 0 : [self getDefaultIncrementHeight];
    [self refreshUI];
}
-(void)setTotalsSegmentCounts:(NSInteger)counts andSections:(NSInteger)sections{
    self.sections = sections;
    self.segmentCounts = counts - counts % sections;
    //    [self refreshUI];
    [self setCurScale:0];
}

-(void)setBlankAreaWithIgnoreRadian:(CGFloat)radian{
    self.ignoreRadian = radian;
//    [self refreshUI];
    [self setCurScale:0];

}
@end
