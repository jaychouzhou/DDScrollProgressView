//
//  ExtraIndicateView.h
//  DDScrollProgressView
//
//  Created by MaxJ on 2019/3/25.
//  Copyright © 2019年 fizz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtraIndicateView : UIView
- (void)setSelectedIndicate:(NSInteger)index;
- (void)setDataSourceWithRadians:(NSArray *)radians;
+ (instancetype)extraIndicateViewWithDataSource:(NSArray *)dataSource frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
