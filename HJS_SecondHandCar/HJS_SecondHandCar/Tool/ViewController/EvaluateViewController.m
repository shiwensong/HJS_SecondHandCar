//
//  EvaluateViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-24.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "EvaluateViewController.h"

@interface EvaluateViewController () <UIPickerViewDelegate,UIPickerViewDataSource>

{
    NSString *year;
    NSString *month;
    
}

@property (weak, nonatomic) IBOutlet UILabel *carInfoLabel;//保存我们的车辆信息

@property (weak, nonatomic) IBOutlet UILabel *beginPlateLabel;//保存的是我们的上牌时间的lable

@property (weak, nonatomic) IBOutlet UITextField *driverLongValueTextField;//保存我们的行驶里程的数据

@property (weak, nonatomic) IBOutlet UILabel *cityLocationLable;//保存我们的所在城市


//一下内容都是我们的自定义的pickerView的属性
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) NSMutableArray *array1;
@property (strong, nonatomic) NSMutableArray *array2;
@property (strong, nonatomic) id firstNumber;
@property (strong, nonatomic) id SecondNumber;
@property (strong, nonatomic)  NSDateComponents *dateComponents;


@end

@implementation EvaluateViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)creatPickerView{
    
    [self setCurrentTime];
    
    if(self.array1.count == 0 ){
        
        for ( int i = 0; i < 100; i ++) {
            
            NSString *firstString = [NSString stringWithFormat:@"20%.2d",i];
            [self.array1 addObject:firstString];
        }
        
        for (int i = 1; i <= 12; i++) {
            NSString *secondString = [NSString stringWithFormat:@"%d",i];
            [self.array2 addObject:secondString];
        }
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(50,100 , 300, 200)];
    [self.view addSubview:bgView];
    
    bgView.backgroundColor = [UIColor yellowColor];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 30)];
    [bgView addSubview:_dateLabel];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 35, 180, 200)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [bgView addSubview:pickerView];
    
    
    NSString *yearString = [NSString stringWithFormat:@"%ld",[_dateComponents year]];
    NSUInteger hehe = [self.array1 indexOfObject:yearString];
    [pickerView selectRow:hehe inComponent:0 animated:NO];
    
    NSString *monthString = [NSString stringWithFormat:@"%ld",[_dateComponents month]];
    NSUInteger haha = [self.array2 indexOfObject:monthString];
    [pickerView selectRow:haha inComponent:1 animated:NO];
    
    
    UIView *speaterLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, 300, 2)];
    speaterLineView.backgroundColor = [UIColor grayColor];
    speaterLineView.alpha = 0.3;
    [bgView addSubview:speaterLineView];
    
}


- (void)setCurrentTime{
    //创建一个我们的日历对象，NSCalendarIdentifierGregorian 这是我们的默认日历，
    NSCalendar *cal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = kCFCalendarUnitYear | kCFCalendarUnitMonth;
    
    //将时间转换为我们的NSDateComponents类型
    _dateComponents = [cal components:unitFlags fromDate:[NSDate date]];
    
}

#pragma mark - IBAction

- (IBAction)backButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Protol Group

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        //弹出我们的pickerView
        [self creatPickerView];
    }
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(component == 0){
        return self.array1.count;
    }
    
    return self.array2.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 0) {
        return 80;
    }
    return 80;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _firstNumber = [NSString stringWithFormat:@"%ld",[_dateComponents year]];
    _SecondNumber = [NSString stringWithFormat:@"%ld",[_dateComponents month]];
    
    if (component == 0) {
        _firstNumber = [self.array1 objectAtIndex:row];
    } else {
        _SecondNumber = [self.array2 objectAtIndex:row];
    }
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月",_firstNumber,_SecondNumber];
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    self.dateLabel.text = [NSString stringWithFormat:@"%ld年%ld月",[_dateComponents year],[_dateComponents month]];
    
    
    if (component == 0) {
        return [self.array1 objectAtIndex:row];
    } else {
        return [[self.array2 objectAtIndex:row] stringByAppendingString:@"月"];
    }
}

#pragma mark - Custom Accessor

- (NSMutableArray *)array1{
    if (!_array1) {
        _array1 = [NSMutableArray array];
    }
    return _array1;
}

- (NSMutableArray *)array2{
    if (!_array2) {
        _array2 = [NSMutableArray array];
    }
    return _array2;
}

@end
