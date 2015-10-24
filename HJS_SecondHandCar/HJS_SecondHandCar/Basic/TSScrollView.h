//
//  TSScrollView.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-24.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSTSScrollViewDelegate <NSObject>

- (void)tapHeaderViewWithCurrentPage:(NSInteger)currentPage;

@end


@interface TSScrollView : UIView

@property(nonatomic, weak) id<TSTSScrollViewDelegate>delegate;

/**
 *  公开的方法，用来链接我们的TSNewsController文件，还有完成我们的数据传递功能
 *
 *  @param imageURLs 保存我们的所有imageURl的数组，我们需要用这个图片来制作我们的透视图的滚动效果
 *  @param titles    保存我们所有的title的数组，动态显示我们头视图的图片标题
 */
- (void)headerViewWithImageURLs:(NSArray *)imageURLs titles:(NSArray *)titles;


@end
