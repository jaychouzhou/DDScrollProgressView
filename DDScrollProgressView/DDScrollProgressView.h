//
//  DDScrollProgressView.h
//  DDScrollProgressView
//
//  Created by MaxJ on 2019/3/22.
//  Copyright © 2019年 fizz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DDScrollProgressView;
typedef void(^WillChangeScrollViewBlock)(DDScrollProgressView* progressView);
typedef void(^DidEndChangedScrollView)(DDScrollProgressView* progressView);
@interface DDScrollProgressView : UIView
@property (nonatomic,assign,readonly) CGFloat segmentHeight;
@property (nonatomic,assign,readonly) CGFloat heightIncrement;
@property (nonatomic,assign,readonly) NSInteger curScale;
@property (nonatomic,copy)WillChangeScrollViewBlock willChangeBlock;
@property (nonatomic,copy)DidEndChangedScrollView didEndChangedBlock;
@property (nonatomic,assign) BOOL isScaleEqualHeight;

+(instancetype)DDScrollProgressView:(CGRect)frame;

-(void)setCurScale:(NSInteger)curScale;
-(void)setCurRadian:(CGFloat)curRadian;
-(void)setBlankAreaWithIgnoreRadian:(CGFloat)radian;
/**
 分割线总数，分多少个组。注意：会进行“取模，去掉余数”操作
 */
-(void)setTotalsSegmentCounts:(NSInteger)counts andSections:(NSInteger)sections;
/**
 Retrun section radians  Base on base line vertical
 */
-(NSArray *)getSectionRadians;

@end

NS_ASSUME_NONNULL_END
