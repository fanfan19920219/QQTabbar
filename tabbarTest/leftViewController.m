//
//  leftViewController.m
//  tabbarTest
//
//  Created by zhangzhihua on 16/3/25.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "leftViewController.h"
#import "SkinManager.h"
#define TABLEVIWE_WIDTH self.view.frame.size.width - 70
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define DOWN_VIEW_HEIGHT 64.f

@interface  leftViewController()
{
    UIView          *_headerView;
    UIScrollView  *_bgScrollview;
    UIView          *_downView;
    
    
    NSArray *_titleArray;
    NSArray *_imageArray;
    int num;
}
@end


@implementation leftViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    num = 1;
    self.view.clipsToBounds = YES;
    
    [self create_Views];
    [self createController_View];
    [self create_downView];
    self.view.backgroundColor = RGBA(13, 186, 246, 1);
    
    _titleArray = [[NSArray alloc]initWithObjects:@"我的超级会员",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件", nil];
    _imageArray = [[NSArray alloc]initWithObjects:@"vip_shadow.png", @"sidebar_purse.png",@"sidebar_decoration.png",@"sidebar_favorit.png",@"sidebar_album.png",@"sidebar_file.png",nil];
    
}

-(void)create_Views{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(75, 0, TABLEVIWE_WIDTH, 200)];
    _headerView.backgroundColor = [UIColor redColor];
    _headerView.clipsToBounds = YES;
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidebar_bg.jpg"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = CGRectMake(0, 0, TABLEVIWE_WIDTH + 20, 200);
    [_headerView addSubview:bgImageView];
    [self.view addSubview:_headerView];
    
}

-(void)createController_View{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(_headerView.frame.origin.x + 10, 200, TABLEVIWE_WIDTH, self.view.frame.size.height - 200) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)create_downView{
    _downView = [[UIView alloc]initWithFrame:CGRectMake(70, self.view.frame.size.height - DOWN_VIEW_HEIGHT, TABLEVIWE_WIDTH, DOWN_VIEW_HEIGHT)];
    [self.view addSubview:_downView];
    
    UIButton *settingButton = [UIButton buttonWithType: UIButtonTypeCustom];
    settingButton.frame = CGRectMake(13, 20, 80, 25);
    [settingButton setImage:[UIImage imageNamed:@"sidebar_setting.png"] forState:UIControlStateNormal];
    [settingButton setTitle:@" 设置" forState:UIControlStateNormal];
    settingButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_downView addSubview:settingButton];
    
    UIButton *nightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [nightButton setImage:[UIImage imageNamed:@"sidebar_nightmode_off.png"] forState:UIControlStateNormal];
    [nightButton setTitle:@" 夜间" forState:UIControlStateNormal];
    nightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    nightButton.frame = CGRectMake(settingButton.frame.origin.x + 90, 21, 80, 25);
    [nightButton addTarget:self action:@selector(changeClolor) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:nightButton];
    
}

-(void)changeClolor
{
    num++;
     [SkinManager sharedSkinManager].skin = num%2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = RGBA(250, 250, 250, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;
}



@end







