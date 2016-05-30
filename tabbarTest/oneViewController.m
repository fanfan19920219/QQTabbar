//
//  ViewController.m
//  celltest
//
//  Created by zhangzhihua on 16/3/21.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "oneViewController.h"
#import "my_cell.h"
#import "ClickView.h"
#import "myTableView.h"

@interface oneViewController ()<UITableViewDataSource,UITableViewDelegate,MY_CELL_DELEGATE>{
    UIScrollView   *_myScrollView;
    myTableView   *_tableView;
    my_cell          *_currentCell;
    ClickView       *_clickView;
    
    NSMutableArray *_tableView_data_array;
}
@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化数据
    [self create_tableView_data_array];
    
    _tableView = [[myTableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44 - 44) style:UITableViewStylePlain];
    self.title = @"聊天";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    //注册通知
    [self  registerNotifacetion];
    //[self.view  bringSubviewToFront:_tableView];
//    _clickView = [[ClickView alloc]initWithFrame:self.view.frame];
//    _clickView.backgroundColor =[UIColor clearColor];
//    [self.view addSubview:_clickView];
//    [self.view  bringSubviewToFront:_clickView];
    
}

-(void)create_tableView_data_array{
    _tableView_data_array = [[NSMutableArray alloc]initWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    my_cell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[my_cell alloc]init];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行",[_tableView_data_array objectAtIndex:indexPath.row]];
    cell.Delegate = self;
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableView_data_array.count;
}

//
-(void)save_buttonClick{
    NSLog(@"save");
}

//
-(void)delete_buttonClick:(NSIndexPath*)indexPath{
    NSLog(@"delete");
    NSLog(@"indexPath ---- %@",indexPath);
    [_tableView_data_array removeObjectAtIndex:indexPath.row];
    [_tableView reloadData];
}


-(void)setcurrentCell:(my_cell*)cell{
    NSLog(@"2222222");
    _currentCell = cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"开始");
    [_currentCell refreshCell];
    _currentCell= nil;
}


//-(void)notifactionMethod{
//    [_currentCell refreshCell];
//    _currentCell= nil;
//}

//注册通知
-(void)registerNotifacetion{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableview:) name:@"tongzhi_tableView" object:nil];
}
-(void)setTableview:(NSNotification*)notifaction{
    NSLog(@"%@",notifaction.userInfo);
    if([[notifaction.userInfo objectForKey:@"orRight"]isEqualToString:@"yes"]){
        _tableView.userInteractionEnabled = NO;
    }else if([[notifaction.userInfo objectForKey:@"orRight"]isEqualToString:@"no"]){
        _tableView.userInteractionEnabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch");
}

@end
