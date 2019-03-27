//
//  ViewController.m
//  DDScrollProgressView
//
//  Created by MaxJ on 2019/3/22.
//  Copyright © 2019年 fizz. All rights reserved.
//


#import "ViewController.h"
#import "DDScrollProgressView.h"
#import "ExtraIndicateView.h"
typedef enum :NSUInteger{
    HeightButtonType = 999,
    CountsButtonType,
    RadianButtonType,
}ButtonType;
@interface ViewController ()
@property (nonatomic,strong) DDScrollProgressView* ddScrollwView;
@property (nonatomic,strong) ExtraIndicateView* extraIndicateView;
@property (nonatomic,strong) UILabel* scaleValueLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *backGroundImage=[UIImage imageNamed:@"background"];
    self.view.contentMode=UIViewContentModeScaleAspectFill;
    self.view.layer.contents=(__bridge id _Nullable)(backGroundImage.CGImage);
    [self setUpUI];
}
- (void)setUpUI{
    CGFloat width = 300;
    CGFloat x = (self.view.bounds.size.width - width ) * 0.5;
    CGFloat y = (self.view.bounds.size.height - width ) * 0.5;
    DDScrollProgressView * ddView = [DDScrollProgressView DDScrollProgressView:CGRectMake(x, y, width, width)];
    ddView.backgroundColor = UIColor.clearColor;
    CGFloat gap = 25.0f;
    ExtraIndicateView * extraView = [ExtraIndicateView extraIndicateViewWithDataSource:[ddView getSectionRadians] frame:CGRectMake(x - gap, y - gap, width + gap *2, width + gap *2)];
    ddView.willChangeBlock = ^(DDScrollProgressView * _Nonnull progressView) {
        [self.scaleValueLabel setText:[NSString stringWithFormat:@"VALUE: %ld",(long)progressView.curScale]];
        [extraView setSelectedIndicate: ceil(round(progressView.curScale / (float)[progressView getNumberOfSegmentsInSection]))];
        //[extraView setSelectedIndicate: ceil(round(progressView.curScale / 5.0))];
    };
    
    [ddView setCurScale:0];
    [extraView setSelectedIndicate: 0];
    [self.view addSubview:extraView];
    [self.view addSubview:ddView];
    self.ddScrollwView  = ddView;
    self.extraIndicateView = extraView;
    //display scale label
    UILabel * scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(extraView.frame) + 20, self.view.bounds.size.width, 20)];
    scaleLabel.textAlignment = NSTextAlignmentCenter;
    scaleLabel.textColor = UIColor.whiteColor;
    scaleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:scaleLabel];
    self.scaleValueLabel = scaleLabel;
}
- (IBAction)clickedChangeHeight:(UIButton *)sender {
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case HeightButtonType:
            self.ddScrollwView.isScaleEqualHeight = sender.selected;
            break;
        case CountsButtonType:{
            NSInteger section = sender.selected ? 8 : 10;
            [self.ddScrollwView setTotalsSegmentCounts:50 andSections:section];
            [self.extraIndicateView setDataSourceWithRadians:self.ddScrollwView.getSectionRadians];
            break;
        }
        case RadianButtonType:{
            CGFloat section = sender.selected ? 180 : 95;
            [self.ddScrollwView setBlankAreaWithIgnoreRadian:section * M_PI/180];
            [self.extraIndicateView setDataSourceWithRadians:self.ddScrollwView.getSectionRadians];
            break;
        }
        default:
            break;
    }
    [self.scaleValueLabel setText:[NSString stringWithFormat:@"VALUE: %ld",(long)self.ddScrollwView.curScale]];

}

@end
