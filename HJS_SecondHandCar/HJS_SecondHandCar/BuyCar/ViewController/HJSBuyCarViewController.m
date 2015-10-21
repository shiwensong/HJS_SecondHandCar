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

@interface HJSBuyCarViewController () <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *buyCarTableView;

@property (weak, nonatomic) IBOutlet UIView *sortBgView;


@property (strong, nonatomic) NSMutableArray *modelsArray;

@property (strong, nonatomic) SWSResultMode *resultModel;

@property (strong, nonatomic)  UITextField *searchTextField;

@property (strong, nonatomic) UIView *textFieldBgView;

@end

@implementation HJSBuyCarViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSearchBgViewSearchCar];
    [self loadCarDatas];
    [self setSortbgViewSetting];
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.delegate = self;
    
    self.navigationItem.titleView = self.textFieldBgView;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    self.tabBarController.tabBar.hidden = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//    self.tabBarController.tabBar.hidden = YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)setSearchtextFieldAnimatetion{
    
    
    //设置我们的navigationBar的按钮
    self.navigationItem.leftBarButtonItem = nil;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [UIView animateWithDuration:2 animations:^{
        
//        CGRect frame = self.searchTextField.frame;
//        frame.size.width = 250;
//        self.searchTextField.frame = frame;
        
        self.searchTextField.frame = CGRectMake(0, 0, TScreenWidth - 50, 35);
    }];
    

}

- (void)buttonAction:(UIButton *)button{
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        CGRect lastFrame = self.searchTextField.frame;
        lastFrame.size.width = 100;
        self.searchTextField.frame = lastFrame;
    } completion:^(BOOL finished) {
        NSLog(@"动画完成了！");
    }];
    
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self setSearchtextFieldAnimatetion];
    
    return NO;
}

#pragma mark - Custom Accessor

- (NSMutableArray *)modelsArray{
    if(!_modelsArray){
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}




- (UIView *)textFieldBgView{
    if (_textFieldBgView == nil) {
        _textFieldBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TScreenWidth - 50, 35)];
//        _textFieldBgView.backgroundColor = [UIColor whiteColor];
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 100, 35)];
        _searchTextField.backgroundColor = [UIColor lightGrayColor];
        _searchTextField.placeholder = @"请输入文字...";
        _searchTextField.delegate = self;
        [_textFieldBgView addSubview:_searchTextField];
    }
    
    return _textFieldBgView;
}



@end
