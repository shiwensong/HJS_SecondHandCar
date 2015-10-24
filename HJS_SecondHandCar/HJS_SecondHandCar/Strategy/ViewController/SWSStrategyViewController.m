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
#import "StrategyDetaileViewController.h"
#import "TSScrollView.h"

static NSString * const FirstCellId = @"StrategyFirstCell";
static NSString * const SecondCellId = @"StrategySecondCell";


@interface SWSStrategyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *detailModelArray;

@end

@implementation SWSStrategyViewController

#pragma mark - Lifecycle

- (void)refreshData {

    switch (self.pageType) {
        case 0: {
            [self LoadViewControllerData:SWSStrategyAllArticleURL];
            break;
        }
        case 1:
            [self LoadViewControllerData:SWSBuyCarCommonSenseURL];
            break;
        case 2:
            [self LoadViewControllerData:SWSLawsAndRegulationsURL];
            break;
        case 3:
            [self LoadViewControllerData:SWSIndustryInformationURL];
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //cell注册
    [self.tableView registerNib:[UINib nibWithNibName:@"StrategyFirstCell" bundle:nil] forCellReuseIdentifier:FirstCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"StrategySecondCell" bundle:nil] forCellReuseIdentifier:SecondCellId];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - Private

//设置我们cell的值
- (void)setCellDatas:(SWSCarNewsCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
    DetailModel *model = self.detailModelArray[indexPath.row];
    if (model.imgurl != nil) {
        [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    }else {
        cell.newsImageView = nil;
    }
    cell.titleLabel.text = model.articletitle;
    cell.subTitleLabel.text = model.classname;
    cell.dateLable.text = model.articlepublishdate;
}


//加载我们的数据
- (void)LoadViewControllerData:(NSString *)URLString {
    [TSHttpRequest  requestURL:URLString parameters:nil requestType:RequesetIsGET success:^(id result) {
        if (self.detailModelArray.count > 0) {
            [self.detailModelArray removeAllObjects];
        }
        NSArray *array = result[@"result"][@"articlelist"];
        for (NSDictionary *dictionary  in array) {
            DetailModel *model = [DetailModel modelWithDictionary:dictionary];
            [self.detailModelArray addObject:model];
        }

        [self.tableView reloadData];
        
    } failure:^(id error) {
        [UIAlertView alertErrorView];
    }];
    
    
}


#pragma mark - Protol  Group

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.detailModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailModel *model = self.detailModelArray[indexPath.row];
    SWSCarNewsCell *cell = nil;
    if (model.imgurl) {
       
        cell = [tableView dequeueReusableCellWithIdentifier:FirstCellId forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:SecondCellId forIndexPath:indexPath];
    }
    
    [self setCellDatas:cell withIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StrategyDetaileViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StrategyDetaileViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    DetailModel *model = self.detailModelArray[indexPath.row];
    viewController.URLString = model.url;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.pageType != 0) {
        return nil;
    }
    
    TSScrollView *headerScrollView = [[TSScrollView alloc] initWithFrame:CGRectMake(0, 0, TScreenWidth, 200)];
    headerScrollView.backgroundColor = [UIColor yellowColor];
    
    NSArray *imageURLs = @[ScrollViewFirstImage,ScrollViewSecondImage,ScrollViewThreeImage];
    NSArray *titles = @[@"明骚小钢炮 家认证二手尚酷实拍",
                        @"二手2010款路虎神行者2实拍",
                        @"家家好车帮我卖掉了POLO"];
    [headerScrollView headerViewWithImageURLs:imageURLs titles:titles];

    return headerScrollView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.pageType != 0) {
        return 0;
    }
    return 200;
}

#pragma mark - Custom AccessorY

-(NSMutableArray *)detailModelArray{
    if (_detailModelArray == nil) {
        _detailModelArray = [NSMutableArray array];
    }
    return _detailModelArray;
}

@end
