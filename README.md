DDScrollProgressView
==============

A lightweight and interactable progress components of iOS  

Demo Project
==============
Find  `Demo/DDScrollProgressView.xcodeproj `    

![demo~](https://github.com/jaychouzhou/DDScrollProgressView/blob/master/Demo/SupFiles/Snapshot/demo2.gif)

Installation
==================
### CocoaPods
1. Add `pod 'DDScrollProgressView'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import correspond header file

### Manually
1. Download all the files in the `DDScrollProgressView` directory.
2. Add the source files to you Xocde project
3. Import correspond header file


Usage
==============
### Display default progress
```objc
DDScrollProgressView * ddView = [DDScrollProgressView DDScrollProgressView:CGRectMake(x, y, width, width)];
ddView.willChangeBlock = ^(DDScrollProgressView * _Nonnull progressView) {
    //rotating progress callback
};
ddView.didEndChangedBlock = ^(DDScrollProgressView * _Nonnull progressView) {
    //end rotated progress callback
}
```
### Display with nubmer indicate 
```objc
DDScrollProgressView * ddView = [DDScrollProgressView DDScrollProgressView:CGRectMake(x, y, width, width)];
ddView.backgroundColor = UIColor.clearColor;
CGFloat gap = 25.0f;
ExtraIndicateView * extraView = [ExtraIndicateView extraIndicateViewWithDataSource:[ddView getSectionRadians] frame:CGRectMake(x - gap, y - gap, width + gap *2, width + gap *2)];
ddView.willChangeBlock = ^(DDScrollProgressView * _Nonnull progressView) {
//rotating progress callback
//Coloring ExtraIndicateView number
[extraView setSelectedIndicate: ceil(round(progressView.curScale / (float)[progressView getNumberOfSegmentsInSection]))];
//[extraView setSelectedIndicate: ceil(round(progressView.curScale / 5.0))];
};

ddView.didEndChangedBlock = ^(DDScrollProgressView * _Nonnull progressView) {
//end rotated progress callback
}
```
### Customize Feature
* Summary look below, detail find to `Demo/DDScrollProgressView.xcodeproj `
```objc
//set currently scale then refresh
-(void)setCurScale:(NSInteger)curScale;

//set currently radian then refresh
-(void)setCurRadian:(CGFloat)curRadian;

//set the radian of blank area
-(void)setBlankAreaWithIgnoreRadian:(CGFloat)radian;

//The total number of segment bar and section,maybe discharge some segment when cannot divisible
-(void)setTotalsSegmentCounts:(NSInteger)counts andSections:(NSInteger)sections;

// getter radians of sections
-(NSArray *)getSectionRadians;

```
Requirements
==============
This library requires `iOS 8.0+` and `Xcode 8.0+`.

<br/><br/>
---
中文介绍
==============
这是一个轻量级，可交互，可定制的类仪表盘进度组件

演示项目
==============
下载demo，并运行 `Demo/DDScrollProgressView.xcodeproj `   

![demo~](https://github.com/jaychouzhou/DDScrollProgressView/blob/master/Demo/SupFiles/Snapshot/demo2.gif)

安装
==============
### CocoaPods
1. 在 Podfile 中添加  `pod 'DDScrollProgressView'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入相应头文件。

### 手动安装
1. 下载 `DDScrollProgressView`文件夹内的所有内容。
2. 将 `DDScrollProgressView` 内的源文件添加(拖放)到你的工程。

使用
==============
### 使用默认ScrollProgressView
```objc
DDScrollProgressView * ddView = [DDScrollProgressView DDScrollProgressView:CGRectMake(x, y, width, width)];
ddView.willChangeBlock = ^(DDScrollProgressView * _Nonnull progressView) {
//旋转时回调
};
ddView.didEndChangedBlock = ^(DDScrollProgressView * _Nonnull progressView) {
//旋转结束时回调
}
```
### 结合ExtraIndicateView使用
* 外层带有数字显示，并且数字状态同步变化
```objc
DDScrollProgressView * ddView = [DDScrollProgressView DDScrollProgressView:CGRectMake(x, y, width, width)];
ddView.backgroundColor = UIColor.clearColor;
CGFloat gap = 25.0f;
ExtraIndicateView * extraView = [ExtraIndicateView extraIndicateViewWithDataSource:[ddView getSectionRadians] frame:CGRectMake(x - gap, y - gap, width + gap *2, width + gap *2)];
ddView.willChangeBlock = ^(DDScrollProgressView * _Nonnull progressView) {
////旋转时回调
//ExtraIndicateView，数字颜色同步变化
[extraView setSelectedIndicate:progressView.curScale];
//[extraView setSelectedIndicate: ceil(round(progressView.curScale / 5.0))];
};

ddView.didEndChangedBlock = ^(DDScrollProgressView * _Nonnull progressView) {
//旋转结束时回调
}
```
### 自定义特性
* 简要如下所示, 详细请查看`Demo/DDScrollProgressView.xcodeproj ` ***更多等你来战***
```objc
//设置当前的进度，并且刷新
-(void)setCurScale:(NSInteger)curScale;

//设置当前的弧度，并且刷新
-(void)setCurRadian:(CGFloat)curRadian;

//设置空白区域所占的弧度，并且刷新
-(void)setBlankAreaWithIgnoreRadian:(CGFloat)radian;

//分割线总数，分多少个组。注意：会进行“取模，去掉余数”操作
-(void)setTotalsSegmentCounts:(NSInteger)counts andSections:(NSInteger)sections;

// 得到所有组对应的弧度
-(NSArray *)getSectionRadians;

```
系统要求
==============
该项目最低支持 `iOS 8.0` 和 `Xcode 8.0`。
