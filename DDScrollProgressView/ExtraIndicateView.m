//
//  ExtraIndicateView.m
//  DDScrollProgressView
//
//  Created by MaxJ on 2019/3/25.
//  Copyright © 2019年 fizz. All rights reserved.
//

#import "ExtraIndicateView.h"
@interface ExtraIndicateView()
@property (nonatomic,strong) NSMutableArray<UILabel*>* lableArray;
@property (nonatomic,strong) NSArray* dataSource;

@end
@implementation ExtraIndicateView
-(NSMutableArray<UILabel *> *)lableArray{
    if (!_lableArray) {
        _lableArray = [NSMutableArray array];
    }
    return _lableArray;
}
+ (instancetype)extraIndicateViewWithDataSource:(NSArray *)dataSource frame:(CGRect)frame{
    ExtraIndicateView * extraView = [[ExtraIndicateView alloc]initWithFrame:frame];
    [extraView addIndicateWithRadianArray:dataSource];
    extraView.dataSource = dataSource;
    return extraView;
}
- (void)addIndicateWithRadianArray:(NSArray *)radianArray{
    if (!radianArray || !radianArray.count) return;
    __weak ExtraIndicateView *weakSelf = self;
    [radianArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = 22.0f;
        CGFloat height =weakSelf.bounds.size.height;
        CGFloat x = (weakSelf.bounds.size.width - width) * 0.5;
        CGFloat y = 0;
        UIView * maskView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        CGFloat lableY = 0;
        UILabel * indicateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, lableY, width, width)];
        indicateLable.text = [NSString stringWithFormat:@"%ld",idx];
        indicateLable.font = [UIFont systemFontOfSize:17];
        indicateLable.textColor = UIColor.blackColor;
        indicateLable.backgroundColor = UIColor.clearColor;
        indicateLable.textAlignment = NSTextAlignmentCenter;
        [maskView addSubview:indicateLable];
        [weakSelf addSubview:maskView];
        [maskView setTransform:CGAffineTransformMakeRotation([obj floatValue] + M_PI)];// M_PI ->Compensate
        [weakSelf.lableArray addObject:indicateLable];
    }];
}

#pragma mark - external api
-(void)setDataSourceWithRadians:(NSArray *)radians{
    if (!radians) return;
    self.dataSource = radians;
    [self.lableArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.lableArray removeAllObjects];
    [self addIndicateWithRadianArray:self.dataSource];
    
}
-(void)setSelectedIndicate:(NSInteger)index{
    if (index > self.lableArray.count) {
        return;
    }
    [self.lableArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > index) {
            [obj setTextColor:UIColor.blackColor];
        }else if(idx == index){
            [obj setTextColor:[UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
        }else{
            [obj setTextColor:UIColor.whiteColor];
        }
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
