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
#import "SWSModelViewController.h"
#import "BaiduMapViewController.h"
#import "ChildViewController.h"
#import "MJRefresh.h"


@interface HJSBuyCarViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,ChiledViewControllerDelegate>
{
    BOOL isSelected;
}
@property (weak, nonatomic) IBOutlet UITableView *buyCarTableView;

@property (weak, nonatomic) IBOutlet UIView *sortBgView;

@property (strong, nonatomic) NSMutableArray *modelsArray;

@property (strong, nonatomic) SWSResultMode *resultModel;

@property (weak, nonatomic) IBOutlet UISearchBar *mysearchBar;

//保存我们定位的按钮
@property (weak, nonatomic) IBOutlet UIButton *placeLocationButon;


@end

@implementation HJSBuyCarViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setSortbgViewSetting];

    self.navigationItem.titleView = self.mysearchBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLocationButtonSelected) name:@"pageBack" object:nil];

    [self addDownRefreshView];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)changeLocationButtonSelected{
    isSelected = NO;
}


- (void)loadCarDatas{
    
    NSString *urlString = SWSHomeRequestURL;
    
    [TSHttpRequest requestURL:urlString parameters:nil requestType:RequesetIsGET success:^(id result) {
        if (!_resultModel) {

            _resultModel = [SWSResultMode modelWithDictionary:result[@"result"]];
            [self.buyCarTableView reloadData];
        }
    } failure:^(id error) {
        [UIAlertView alertErrorView];
        [self.buyCarTableView.header endRefreshing];

    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.buyCarTableView.header endRefreshing];
    });

}

- (void)setSortbgViewSetting{
    self.sortBgView.alpha = 0.8;
}


//下拉加载更多，刷新
- (void)addDownRefreshView{
    
    self.buyCarTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCarDatas)];
    
    [self.buyCarTableView.header beginRefreshing];
    
    
}

#pragma mark - IBAction

//这是控制器左上角的定位按钮
- (IBAction)locationPlaceAction:(UIButton *)sender {
    
    if (isSelected) {
        return;
    }
    isSelected = YES;
    
    ChildViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];
    viewController.delegate = self;
    
    CGRect frame = self.view.bounds;
    frame.origin.x = CGRectGetWidth(frame);
    viewController.view.frame = frame;
    viewController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:viewController.view];
    
    [UIView animateWithDuration:2 animations:^{

        CGRect lastFrame = viewController.view.frame;
        lastFrame.origin.x = 0;
        viewController.view.frame = lastFrame;
    }];
    
    [keyWindow.rootViewController addChildViewController:viewController];
}


- (IBAction)baiduMapLocationPlaceAction:(UIButton *)sender {
    
    BaiduMapViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BaiduMapViewController"];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}


#pragma mark - Protol GroupY

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.buyCarTableView){
        
        return self.resultModel.carModels.count;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarInfoCell *cell = nil;
    if (tableView == self.buyCarTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CarInfoCell" forIndexPath:indexPath];
        
        
        cell.model = self.resultModel.carModels[indexPath.row];
    }else{
        cell = (CarInfoCell *)[[UITableViewCell alloc] init];
        cell.textLabel.text = [@(indexPath.row) stringValue];
    }
    
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


#pragma makr - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    SWSModelViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWSModelViewController"];
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewController animated:YES completion:nil];
    
    return NO;
}          

#pragma mark - ChiledViewControllerDelegate

- (void)locationButtonTitle:(NSString *)title{

    if (title.length > 3) {
        title = [title substringToIndex:2];
    }
    [self.placeLocationButon setTitle:title forState:UIControlStateNormal];
}

#pragma mark - Custom Accessor

- (NSMutableArray *)modelsArray{
    if(!_modelsArray){
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}

@end
