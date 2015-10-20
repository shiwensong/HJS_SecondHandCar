//
//  SearchView.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSearchView];
    }
    return self;
}


- (void)awakeFromNib{
    
    [self setSearchView];
}

#pragma mark - Private

- (void)setSearchView{
    
    //添加背景图片，设置背景图片不被拉升
    UIImage *backgroundImage = [UIImage imageNamed:@"search_navigationbar_textfield_background"];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    self.background = backgroundImage;
    
    //设置搜索框的左边View
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    leftImageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    self.leftView = leftImageView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    self.placeholder = @"搜索品牌，车系";
    self.tintColor = [UIColor grayColor];

    self.font = [UIFont systemFontOfSize:15];
}

@end
