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

@interface HJSBuyCarViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *buyCarTableView;

@property (weak, nonatomic) IBOutlet UIView *sortBgView;

@property (strong, nonatomic) NSMutableArray *modelsArray;

@property (strong, nonatomic) SWSResultMode *resultModel;

@property (weak, nonatomic) IBOutlet UISearchBar *mysearchBar;



@end

@implementation HJSBuyCarViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCarDatas];
    [self setSortbgViewSetting];

    self.navigationItem.titleView = self.mysearchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - Private


- (void)loadCarDatas{
    
    NSString *urlString = SWSHomeRequestURL;
    
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

#pragma mark - IBAction

//这是控制器左上角的定位按钮
- (IBAction)locationPlaceAction:(UIButton *)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];
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


#pragma mark - Protol Group

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
}                      // return NO to not become first responder
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;                     // called when text starts editing
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar;                   // called when bookmark button pressed
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;                     // called when cancel button pressed
//- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2);

#pragma mark - Custom Accessor

- (NSMutableArray *)modelsArray{
    if(!_modelsArray){
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}



@end
