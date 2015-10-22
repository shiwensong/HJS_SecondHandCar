//
//  SWSStrategyViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SWSStrategyViewController.h"

#import "SWSCarNewsCell.h"
#import "SWSResultModel.h"
#import "DetailModel.h"

@interface SWSStrategyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SWSResultModel *resultModel;

@end

@implementation SWSStrategyViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStrategyNewDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - Private

- (void)loadStrategyNewDatas{
    
    
    [TSHttpRequest requestURL:SWSStrategyAllArticleURL parameters:nil requestType:RequesetIsGET success:^(id result) {
        
        self.resultModel = [[SWSResultModel alloc] initWithDictionary:result[@"result"]];
        
    } failure:^(id error) {
        [UIAlertView alertErrorView];
    }];
    
    [self.tableView reloadData];
}

//设置我们cell的值
- (void)setCellDatas:(SWSCarNewsCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    DetailModel *model = self.resultModel.detailModelArray[indexPath.row];
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    cell.titleLabel.text = model.articleintroduce;
    cell.subTitleLabel.text = model.articletitle;
}


#pragma mark - Protol  Group

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultModel.detailModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SWSCarNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWSCarNewsCell" forIndexPath:indexPath];
    [self setCellDatas:cell withIndexPath:indexPath];
    return cell;
}

@end
