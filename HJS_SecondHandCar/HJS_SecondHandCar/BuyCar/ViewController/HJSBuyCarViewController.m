//
//  HJSBuyCarViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSBuyCarViewController.h"
#import "SearchView.h"
#import "SWSResultMode.h"
#import "CarInfoCell.h"
#import "SWSWebDetailViewController.h"

@interface HJSBuyCarViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *buyCarTableView;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UIView *sortBgView;


@property (strong, nonatomic) NSMutableArray *modelsArray;

@property (strong, nonatomic) SWSResultMode *resultModel;

@end

@implementation HJSBuyCarViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSearchBgViewSearchCar];
    [self loadCarDatas];
    [self setSortbgViewSetting];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

//设置我们的navigationBar的搜索框
- (void)setSearchBgViewSearchCar
{
//    self.searchTextField.layer.borderColor = [UIColor grayColor].CGColor;
//    self.searchTextField.backgroundColor = [UIColor lightGrayColor];
//    self.searchTextField.layer.borderWidth =1.0;
//    self.searchTextField.textColor = [UIColor whiteColor];
//    self.searchTextField.layer.cornerRadius =15.0;
//    self.searchTextField.inputAccessoryView = (UIView *)[UIImage imageNamed:@"search_icon"];
}

- (void)loadCarDatas{
    
    NSString *urlString = @"http://apps.api.che168.com/Phone/V52/cars/search.ashx?_sign=b31212b55d1c6ca4560683e21291fb7b&channelid=App%20Store&pagesize=24&orderby=0&needaroundtype=0&pageindex=1&cid=510100&ispic=1&appversion=4.8.7&_appid=2scapp.ios&areaid=400000&dealertype=9&lastdate=&pid=510000";
    
    [TSHttpRequest requestURL:urlString parameters:nil requestType:RequesetIsGET success:^(id result) {
        if (!_resultModel) {

            _resultModel = [SWSResultMode modelWithDictionary:result[@"result"]];
            [self.buyCarTableView reloadData];
        }
    } failure:^(id error) {
        [UIAlertView alertErrorView];
    }];
}

- (void)setSortbgViewSetting{
    self.sortBgView.alpha = 0.8;

}

#pragma mark - Protol Group

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultModel.carModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarInfoCell" forIndexPath:indexPath];
    
    cell.model = self.resultModel.carModels[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SWSCarModel *model = self.resultModel.carModels[indexPath.row];
    NSString *HTTPURL = SWSWebViewRequestURL;
    NSString *urlString = [NSString stringWithFormat:@"%@%@.html",HTTPURL,model.carid];
    
    SWSWebDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWSWebDetailViewController"];
    viewController.URLString = urlString;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
    [self.buyCarTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Custom Accessor

- (NSMutableArray *)modelsArray{
    if(!_modelsArray){
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}
@end
